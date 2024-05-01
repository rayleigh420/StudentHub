import 'dart:async';


import 'package:flutter/cupertino.dart';
abstract class TranscriptRepository {
  Future<bool> postTranscript(String filePath, String fileName);
}