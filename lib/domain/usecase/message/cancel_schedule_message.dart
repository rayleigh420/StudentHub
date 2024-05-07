import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class CancelScheduleParams {
  final int interviewId;

  CancelScheduleParams({required this.interviewId});
}

class CancelScheduleUseCase extends UseCase<dynamic, CancelScheduleParams> {
  final MessageRepository _messageRepository;

  CancelScheduleUseCase(this._messageRepository);

  @override
  Future<void> call({required params}) {
    return _messageRepository.cancelSchedule(
      params.interviewId,
    );
  }
}
