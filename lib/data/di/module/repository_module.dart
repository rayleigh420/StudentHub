import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/apis/educations/education_api.dart';
import 'package:boilerplate/data/network/apis/experiences/experience_api.dart';
import 'package:boilerplate/data/network/apis/favorite/favorite_api.dart';
import 'package:boilerplate/data/network/apis/languages/language_api.dart';
import 'package:boilerplate/data/network/apis/message/message_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/network/apis/proposal/proposal_api.dart';
import 'package:boilerplate/data/network/apis/resume/resume_api.dart';
import 'package:boilerplate/data/network/apis/skillSet/skill_set_api.dart';
import 'package:boilerplate/data/network/apis/project/project_api.dart';
import 'package:boilerplate/data/network/apis/transcript/transcript_api.dart';
import 'package:boilerplate/data/repository/auth/auth_repository_impl.dart';
import 'package:boilerplate/data/network/apis/techStacks/tech_stack_api.dart';
import 'package:boilerplate/data/repository/educations/education_repository_impl.dart';
import 'package:boilerplate/data/repository/experiences/experience_repository_impl.dart';
import 'package:boilerplate/data/repository/favorite/favorite_repository_impl.dart';
import 'package:boilerplate/data/repository/languages/language_repository_impl.dart';
import 'package:boilerplate/data/repository/message/message_repository_impl.dart';
import 'package:boilerplate/data/repository/post/post_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_company_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_student_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_user_repository_impl.dart';
import 'package:boilerplate/data/repository/project/project_repository_impl.dart';
import 'package:boilerplate/data/repository/proposal/proposal_repository_impl.dart';
import 'package:boilerplate/data/repository/resume/resume_repository_impl.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/skillSet/skill_set_repository_impl.dart';
import 'package:boilerplate/data/repository/techStack/tech_stack_repository_impl.dart';
import 'package:boilerplate/data/repository/transcript/transcript_repository_impl.dart';
import 'package:boilerplate/data/repository/user/user_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';
import 'package:boilerplate/domain/repository/favorite/favorite_repository.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_student_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_company_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';
import 'package:boilerplate/domain/repository/resume/resume_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/skillSet/skill_set_repository.dart';
import 'package:boilerplate/domain/repository/techStack/teach_stack_repository.dart';
import 'package:boilerplate/domain/repository/transcript/transcript_repository.dart';
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

    //profile_student
    getIt.registerSingleton<ProfileStudentRepository>(
        ProfileStudentRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    // SkillSet
    getIt.registerSingleton<SkillSetRepository>(
        SkillSetRepositoryImpl(getIt<SkillSetApi>()));

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
      getIt<SharedPreferenceHelper>(),
    ));

    // Education
    getIt.registerSingleton<EducationRepository>(EducationRepositoryImpl(
      getIt<EducationApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    // Experience
    getIt.registerSingleton<ExperienceRepository>(ExperienceRepositoryImpl(
      getIt<ExperienceApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    // Profile User
    getIt.registerSingleton<ProfileUserRepository>(ProfileUserRepositoryImpl(
      getIt<ProfileApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    // Favorite
    getIt.registerSingleton<FavoriteRepository>(FavoriteRepositoryImpl(
      getIt<FavoriteApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    // Proposal
    getIt.registerSingleton<ProposalRepository>(ProposalRepositoryImpl(
      getIt<ProposalApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    // Resume
    getIt.registerSingleton<ResumeRepository>(ResumeRepositoryImpl(
      getIt<ResumeApi>(),
      getIt<SharedPreferenceHelper>(),
    ));
    // Transcipt
    getIt.registerSingleton<TranscriptRepository>(TranscriptRepositoryImpl(
      getIt<TranscriptApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<MessageRepository>(MessageRepositoryImpl(
      getIt<MessageApi>(),
    ));
  }
}
