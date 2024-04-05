import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final GetProfileUseCase _getProfileUseCase;
  final ErrorStore errorStore;

  _ProfileStore(this._getProfileUseCase, this.errorStore);

  static ObservableFuture<Profile?> emptyProfileResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Profile?> fetchProfileFuture =
      ObservableFuture<Profile?>(emptyProfileResponse);

  @observable
  Profile? profile;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchProfileFuture.status == FutureStatus.pending;

  @computed
  String get userRole => profile?.student != null ? 'student' : 'company';

  @action
  Future getProfile() async {
    final future = _getProfileUseCase.call(params: null);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profile) {
      this.profile = profile;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
