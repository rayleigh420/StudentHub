import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/resume/resume_repository.dart';

class GetResumeUseCase  extends UseCase<String, void>{
  final ResumeRepository _resumeRepository;

  GetResumeUseCase(this._resumeRepository);

  Future<String> call({required params}) async {
    return await _resumeRepository.getResume();
  }
}