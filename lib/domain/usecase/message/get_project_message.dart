import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class GetProjectMessageParams {
  final int projectId;
  final int receiverId;

  GetProjectMessageParams({required this.projectId, required this.receiverId});
}

class GetProjectMessageUseCase
    extends UseCase<List<Message>, GetProjectMessageParams> {
  final MessageRepository _messageRepository;

  GetProjectMessageUseCase(this._messageRepository);

  @override
  Future<List<Message>> call({required params}) {
    return _messageRepository.getProjectMessages(
        params.projectId, params.receiverId);
  }
}
