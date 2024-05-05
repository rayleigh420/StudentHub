// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectStore on _ProjectStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ProjectStore.loading'))
      .value;

  late final _$fetchProjectsFutureAtom =
      Atom(name: '_ProjectStore.fetchProjectsFuture', context: context);

  @override
  ObservableFuture<ProjectList?> get fetchProjectsFuture {
    _$fetchProjectsFutureAtom.reportRead();
    return super.fetchProjectsFuture;
  }

  @override
  set fetchProjectsFuture(ObservableFuture<ProjectList?> value) {
    _$fetchProjectsFutureAtom.reportWrite(value, super.fetchProjectsFuture, () {
      super.fetchProjectsFuture = value;
    });
  }

  late final _$projectsAtom =
      Atom(name: '_ProjectStore.projects', context: context);

  @override
  ProjectList? get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(ProjectList? value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ProjectStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getProjectsAsyncAction =
      AsyncAction('_ProjectStore.getProjects', context: context);

  @override
  Future<dynamic> getProjects() {
    return _$getProjectsAsyncAction.run(() => super.getProjects());
  }

  late final _$_ProjectStoreActionController =
      ActionController(name: '_ProjectStore', context: context);

  @override
  dynamic refreshProjects() {
    final _$actionInfo = _$_ProjectStoreActionController.startAction(
        name: '_ProjectStore.refreshProjects');
    try {
      return super.refreshProjects();
    } finally {
      _$_ProjectStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearStoreData() {
    final _$actionInfo = _$_ProjectStoreActionController.startAction(
        name: '_ProjectStore.clearStoreData');
    try {
      return super.clearStoreData();
    } finally {
      _$_ProjectStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchProjectsFuture: ${fetchProjectsFuture},
projects: ${projects},
success: ${success},
loading: ${loading}
    ''';
  }
}
