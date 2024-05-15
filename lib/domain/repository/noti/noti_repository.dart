import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';

abstract class NotiRepository {
Future<List<Noti>> getNoti(int id);
}
