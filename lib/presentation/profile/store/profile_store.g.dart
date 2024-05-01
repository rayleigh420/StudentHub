// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool>? _$successComputed;

  @override
  bool get success => (_$successComputed ??=
          Computed<bool>(() => super.success, name: '_ProfileStore.success'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ProfileStore.loading'))
      .value;
  Computed<String>? _$userRoleComputed;

  @override
  String get userRole =>
      (_$userRoleComputed ??= Computed<String>(() => super.userRole,
              name: '_ProfileStore.userRole'))
          .value;

  late final _$fetchProfileFutureAtom =
      Atom(name: '_ProfileStore.fetchProfileFuture', context: context);

  @override
  ObservableFuture<Profile?> get fetchProfileFuture {
    _$fetchProfileFutureAtom.reportRead();
    return super.fetchProfileFuture;
  }

  @override
  set fetchProfileFuture(ObservableFuture<Profile?> value) {
    _$fetchProfileFutureAtom.reportWrite(value, super.fetchProfileFuture, () {
      super.fetchProfileFuture = value;
    });
  }

  late final _$profileAtom =
      Atom(name: '_ProfileStore.profile', context: context);

  @override
  Profile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$success2Atom =
      Atom(name: '_ProfileStore.success2', context: context);

  @override
  bool get success2 {
    _$success2Atom.reportRead();
    return super.success2;
  }

  @override
  set success2(bool value) {
    _$success2Atom.reportWrite(value, super.success2, () {
      super.success2 = value;
    });
  }

  late final _$_fetchCompletedAtom =
      Atom(name: '_ProfileStore._fetchCompleted', context: context);

  @override
  bool get _fetchCompleted {
    _$_fetchCompletedAtom.reportRead();
    return super._fetchCompleted;
  }

  @override
  set _fetchCompleted(bool value) {
    _$_fetchCompletedAtom.reportWrite(value, super._fetchCompleted, () {
      super._fetchCompleted = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_ProfileStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$getProfileAsyncAction =
      AsyncAction('_ProfileStore.getProfile', context: context);

  @override
  Future<dynamic> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  @override
  String toString() {
    return '''
fetchProfileFuture: ${fetchProfileFuture},
profile: ${profile},
success2: ${success2},
token: ${token},
success: ${success},
loading: ${loading},
userRole: ${userRole}
    ''';
  }
}
