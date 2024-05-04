import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/project_2/project.dart';

part 'current_message_store.g.dart';

class CurrentMessageStore = _CurrentMessageStore with _$CurrentMessageStore;

abstract class _CurrentMessageStore with Store {
  _CurrentMessageStore(this.errorStore);

  final ErrorStore errorStore;

  @observable
  int index = -2;

  @observable
  int index2 = -2;

  @action
  void setIndex(int index) {
    this.index = index;
  }

  @action
  void setIndex2(int index) {
    this.index2 = index;
  }

  @action
  void clearMessageListItem() {
    this.index = -2;
    this.index2 = -2;
  }
}
