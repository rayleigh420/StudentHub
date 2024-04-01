import 'dart:async';

import 'package:boilerplate/domain/entity/techStack/techStack_list.dart';

abstract class TechStackRepository {
  Future<TechStackList> getTechStacks();
}
