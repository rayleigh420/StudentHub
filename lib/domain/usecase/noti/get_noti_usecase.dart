import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/post/post.dart';
import 'package:boilerplate/domain/repository/noti/noti_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';

class GetNotiUseCase extends UseCase<List<Noti>, int> {
  final NotiRepository _notiRepository;

  GetNotiUseCase(this._notiRepository);

  @override
  Future<List<Noti>> call({required params}) {
    return _notiRepository.getNoti(params);
  }
}
