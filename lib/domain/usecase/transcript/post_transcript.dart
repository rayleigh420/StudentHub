
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/repository/transcript/transcript_repository.dart';
import 'package:dio/dio.dart';


class PostTranscriptParams {
  final String filePath;
  final String fileName;


  PostTranscriptParams({required this.filePath,required this.fileName});
}
class PostTranscriptUseCase extends UseCase<bool, PostTranscriptParams>{
  final TranscriptRepository _transcriptRepository;

  PostTranscriptUseCase(this._transcriptRepository);



  @override
  Future<bool> call({required params}) {
    return _transcriptRepository.postTranscript(params.filePath, params.fileName);
  }
}