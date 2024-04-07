import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/domain/usecase/project/get_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/post_company_projects_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'project_company_store.g.dart';

class ProjectCompanyStore = _ProjectCompanyStore with _$ProjectCompanyStore;

abstract class _ProjectCompanyStore with Store {
  final GetCompanyProjectsUseCase _getCompanyProjectsUseCase;
  final PostCompanyProjectsUseCase _postCompanyProjectsUseCase;
  final ErrorStore errorStore;
  _ProjectCompanyStore(this._getCompanyProjectsUseCase,
      this._postCompanyProjectsUseCase, this.errorStore);

  static ObservableFuture<ProjectList?> emptyProfileResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ProjectList?> fetchCompanyProjectFuture =
      ObservableFuture<ProjectList?>(emptyProfileResponse);

  @observable
  ProjectList? companyProjects;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchCompanyProjectFuture.status == FutureStatus.pending;

  @action
  Future getCompanyProjects() async {
    final future = _getCompanyProjectsUseCase.call(params: null);
    fetchCompanyProjectFuture = ObservableFuture(future);

    future.then((companyProjects) {
      this.companyProjects = companyProjects;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future postCompanyProjects(String title, int scopeType, int studentNumber,
      String describeProject) async {
    final newProject = await _postCompanyProjectsUseCase.call(
        params: PostcompanyProjectParams(
            title: title,
            scopeType: scopeType,
            studentNumber: studentNumber,
            describeProject: describeProject));
    companyProjects?.projects!.add(newProject);
  }

  @action
  refreshCompanyProjects() {
    companyProjects = null;
    success = false;
    errorStore.errorMessage = "";
    getCompanyProjects();
  }
}
