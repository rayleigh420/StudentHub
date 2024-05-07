import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class MessageParams {
  dynamic message;
  MessageParams({required this.message});
}

class NewMessageUseCase extends UseCase<dynamic, MessageParams> {
  final MessageRepository _messageRepository;

  NewMessageUseCase(this._messageRepository);

  @override
  Future<void> call({required params}) {
    return _messageRepository.newMessage(params.message);
  }
}
