// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ProfileStore.loading'))
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

  late final _$successAtom =
      Atom(name: '_ProfileStore.success', context: context);

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
success: ${success},
loading: ${loading}
    ''';
  }
}
