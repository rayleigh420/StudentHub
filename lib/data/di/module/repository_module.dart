import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/apis/educations/education_api.dart';
import 'package:boilerplate/data/network/apis/experiences/experience_api.dart';
import 'package:boilerplate/data/network/apis/languages/language_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/network/apis/project/project_api.dart';
import 'package:boilerplate/data/repository/auth/auth_repository_impl.dart';
import 'package:boilerplate/data/network/apis/techStacks/tech_stack_api.dart';
import 'package:boilerplate/data/repository/educations/education_repository_impl.dart';
import 'package:boilerplate/data/repository/experiences/experience_repository_impl.dart';
import 'package:boilerplate/data/repository/languages/language_repository_impl.dart';
import 'package:boilerplate/data/repository/post/post_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_repository_company_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_user_repository_impl.dart';
import 'package:boilerplate/data/repository/project/project_repository_impl.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/techStack/tech_stack_repository_impl.dart';
import 'package:boilerplate/data/repository/user/user_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/domain/repository/profile/profle_company_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/techStack/teach_stack_repository.dart';
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
    //auth
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      getIt<AuthApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    //profile_company
    getIt.registerSingleton<ProfileCompanyRepository>(
        ProfileCompanyRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    //project
    getIt.registerSingleton<ProjectRepository>(ProjectRepositoryImpl(
        getIt<ProjectApi>(), getIt<SharedPreferenceHelper>()));

    // TechStack
    getIt.registerSingleton<TechStackRepository>(TechStackRepositoryImpl(
      getIt<TechStackApi>(),
    ));

    // Language
    getIt.registerSingleton<LanguageRepository>(LanguageRepositoryImpl(
      getIt<LanguageApi>(),
    ));

    // Education
    getIt.registerSingleton<EducationRepository>(EducationRepositoryImpl(
      getIt<EducationApi>(),
    ));

    // Experience
    getIt.registerSingleton<ExperienceRepository>(ExperienceRepositoryImpl(
      getIt<ExperienceApi>(),
    ));

    // Profile User
    getIt.registerSingleton<ProfileUserRepository>(ProfileUserRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
  }
}
