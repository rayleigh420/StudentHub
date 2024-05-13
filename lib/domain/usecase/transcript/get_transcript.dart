import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/transcript/transcript_repository.dart';

class GetTranscriptUseCase extends UseCase<String, void>{
  final TranscriptRepository _transcriptRepository;

  GetTranscriptUseCase(this._transcriptRepository);

  @override
  FutureOr<String> call({required void params}) {
    // TODO: implement call
    return _transcriptRepository.getTranscript();
  }

}