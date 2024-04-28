
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/repository/resume/resume_repository.dart';
import 'package:dio/dio.dart';


class PostResumeParams {
  final String filePath;
  final String fileName;


  PostResumeParams({required this.filePath,required this.fileName});
}
class PostResumeUseCase extends UseCase<bool, PostResumeParams>{
  final ResumeRepository _resumeRepository;

  PostResumeUseCase(this._resumeRepository);



  @override
  Future<bool> call({required params}) {
    return _resumeRepository.postResume(params.filePath, params.fileName);
  }
}