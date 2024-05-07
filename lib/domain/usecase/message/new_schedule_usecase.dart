import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class NewScheduleParams {
  dynamic message;
  NewScheduleParams({required this.message});
}

class NewScheduleUseCase extends UseCase<dynamic, NewScheduleParams> {
  final MessageRepository _messageRepository;

  NewScheduleUseCase(this._messageRepository);

  @override
  Future<void> call({required params}) {
    return _messageRepository.newSchedule(params.message);
  }
}
