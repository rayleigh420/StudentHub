import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/network/apis/skillSet/skill_set_api.dart';
import 'package:boilerplate/data/repository/auth/auth_repository_impl.dart';
import 'package:boilerplate/data/repository/post/post_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_company_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_student_repository_impl.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/skillSet/skill_set_repository_impl.dart';
import 'package:boilerplate/data/repository/user/user_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_student_repository.dart';
import 'package:boilerplate/domain/repository/profile/profle_company_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/skillSet/skill_set_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      getIt<AuthApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    getIt.registerSingleton<ProfileCompanyRepository>(
        ProfileCompanyRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    getIt.registerSingleton<ProfileStudentRepository>(
        ProfileStudentRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    getIt.registerSingleton<SkillSetRepository>(
        SkillSetRepositoryImpl(
          getIt<SkillSetApi>(),

    ));
  }
}
