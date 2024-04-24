import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class GetAllMessageUseCase extends UseCase<List<MessageProject>, void> {
  final MessageRepository _messageRepository;

  GetAllMessageUseCase(this._messageRepository);

  @override
  Future<List<MessageProject>> call({required params}) {
    return _messageRepository.getMessages();
  }
}
