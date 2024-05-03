import 'dart:async';


import 'package:flutter/cupertino.dart';
abstract class ResumeRepository {
  Future<bool> postResume(String filePath, String fileName);
  Future<String> getResume();
}