// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_company_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectCompanyStore on _ProjectCompanyStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ProjectCompanyStore.loading'))
      .value;

  late final _$fetchCompanyProjectFutureAtom = Atom(
      name: '_ProjectCompanyStore.fetchCompanyProjectFuture', context: context);

  @override
  ObservableFuture<ProjectList?> get fetchCompanyProjectFuture {
    _$fetchCompanyProjectFutureAtom.reportRead();
    return super.fetchCompanyProjectFuture;
  }

  @override
  set fetchCompanyProjectFuture(ObservableFuture<ProjectList?> value) {
    _$fetchCompanyProjectFutureAtom
        .reportWrite(value, super.fetchCompanyProjectFuture, () {
      super.fetchCompanyProjectFuture = value;
    });
  }

  late final _$companyProjectsAtom =
      Atom(name: '_ProjectCompanyStore.companyProjects', context: context);

  @override
  ProjectList? get companyProjects {
    _$companyProjectsAtom.reportRead();
    return super.companyProjects;
  }

  @override
  set companyProjects(ProjectList? value) {
    _$companyProjectsAtom.reportWrite(value, super.companyProjects, () {
      super.companyProjects = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ProjectCompanyStore.success', context: context);

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

  late final _$getCompanyProjectsAsyncAction =
      AsyncAction('_ProjectCompanyStore.getCompanyProjects', context: context);

  @override
  Future<dynamic> getCompanyProjects() {
    return _$getCompanyProjectsAsyncAction
        .run(() => super.getCompanyProjects());
  }

  late final _$postCompanyProjectsAsyncAction =
      AsyncAction('_ProjectCompanyStore.postCompanyProjects', context: context);

  @override
  Future<dynamic> postCompanyProjects(
      String title, int scopeType, int studentNumber, String describeProject) {
    return _$postCompanyProjectsAsyncAction.run(() => super
        .postCompanyProjects(title, scopeType, studentNumber, describeProject));
  }

  late final _$updateCompanyProjectsAsyncAction = AsyncAction(
      '_ProjectCompanyStore.updateCompanyProjects',
      context: context);

  @override
  Future<dynamic> updateCompanyProjects(Project project) {
    return _$updateCompanyProjectsAsyncAction
        .run(() => super.updateCompanyProjects(project));
  }

  late final _$deleteCompanyProjectsAsyncAction = AsyncAction(
      '_ProjectCompanyStore.deleteCompanyProjects',
      context: context);

  @override
  Future<dynamic> deleteCompanyProjects(int projectId) {
    return _$deleteCompanyProjectsAsyncAction
        .run(() => super.deleteCompanyProjects(projectId));
  }

  late final _$_ProjectCompanyStoreActionController =
      ActionController(name: '_ProjectCompanyStore', context: context);

  @override
  dynamic refreshCompanyProjects() {
    final _$actionInfo = _$_ProjectCompanyStoreActionController.startAction(
        name: '_ProjectCompanyStore.refreshCompanyProjects');
    try {
      return super.refreshCompanyProjects();
    } finally {
      _$_ProjectCompanyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchCompanyProjectFuture: ${fetchCompanyProjectFuture},
companyProjects: ${companyProjects},
success: ${success},
loading: ${loading}
    ''';
  }
}
