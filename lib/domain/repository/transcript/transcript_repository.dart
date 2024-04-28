import 'dart:async';
import 'dart:html';

import 'package:flutter/cupertino.dart';
abstract class TranscriptRepository {
  Future<bool> postTranscript(int id,FormData formData);
}