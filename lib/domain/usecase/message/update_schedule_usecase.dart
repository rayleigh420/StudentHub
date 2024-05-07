import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class UpdatecheduleParams {
  final int interviewId;
  dynamic message;
  UpdatecheduleParams({required this.interviewId, required this.message});
}

class UpdateScheduleUseCase extends UseCase<dynamic, UpdatecheduleParams> {
  final MessageRepository _messageRepository;

  UpdateScheduleUseCase(this._messageRepository);

  @override
  Future<void> call({required params}) {
    return _messageRepository.updateSchedule(
        params.interviewId, params.message);
  }
}
