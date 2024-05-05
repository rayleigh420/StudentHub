// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrentMessageStore on _CurrentMessageStore, Store {
  late final _$indexAtom =
      Atom(name: '_CurrentMessageStore.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$index2Atom =
      Atom(name: '_CurrentMessageStore.index2', context: context);

  @override
  int get index2 {
    _$index2Atom.reportRead();
    return super.index2;
  }

  @override
  set index2(int value) {
    _$index2Atom.reportWrite(value, super.index2, () {
      super.index2 = value;
    });
  }

  late final _$_CurrentMessageStoreActionController =
      ActionController(name: '_CurrentMessageStore', context: context);

  @override
  void setIndex(int index) {
    final _$actionInfo = _$_CurrentMessageStoreActionController.startAction(
        name: '_CurrentMessageStore.setIndex');
    try {
      return super.setIndex(index);
    } finally {
      _$_CurrentMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex2(int index) {
    final _$actionInfo = _$_CurrentMessageStoreActionController.startAction(
        name: '_CurrentMessageStore.setIndex2');
    try {
      return super.setIndex2(index);
    } finally {
      _$_CurrentMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessageListItem() {
    final _$actionInfo = _$_CurrentMessageStoreActionController.startAction(
        name: '_CurrentMessageStore.clearMessageListItem');
    try {
      return super.clearMessageListItem();
    } finally {
      _$_CurrentMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
index: ${index},
index2: ${index2}
    ''';
  }
}
