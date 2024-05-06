import 'dart:developer';

import 'package:mobx/mobx.dart';

part 'tab_store.g.dart';

class TabStore = _TabStore with _$TabStore;

abstract class _TabStore with Store {
  @observable
  int selectedIndex = 1;

  @action
  void setTabIndex(int index) {
    selectedIndex = index;
    log("đã chuyển index: $index");
  }
}