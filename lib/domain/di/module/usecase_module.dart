import 'dart:async';

import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';
import 'package:boilerplate/domain/repository/favorite/favorite_repository.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_student_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_company_repository.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';
import 'package:boilerplate/domain/repository/skillSet/skill_set_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_signup_usecase.dart';
import 'package:boilerplate/domain/repository/techStack/teach_stack_repository.dart';
import 'package:boilerplate/domain/usecase/common/get_tech_stack.dart';
import 'package:boilerplate/domain/usecase/education/get_education_by_student_id.dart';
import 'package:boilerplate/domain/usecase/education/udpate_education_by_student_id.dart';
import 'package:boilerplate/domain/usecase/experience/get_experience_by_student_id.dart';
import 'package:boilerplate/domain/usecase/experience/udpate_experience_by_student_id.dart';
import 'package:boilerplate/domain/usecase/favorite/add_favorite_by_student_id.dart';
import 'package:boilerplate/domain/usecase/favorite/get_favorite_by_student_id.dart';
import 'package:boilerplate/domain/usecase/language/get_language_by_student_id.dart';
import 'package:boilerplate/domain/usecase/language/udpate_language_by_student_id.dart';
import 'package:boilerplate/domain/usecase/post/delete_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/find_post_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/insert_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/udpate_post_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/create_profile_company_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/create_profile_student_usecase.dart';

import 'package:boilerplate/domain/usecase/profile/profile_test_uc.dart';
import 'package:boilerplate/domain/usecase/project/delete_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/project/update_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/proposal/create_proposal.dart';
import 'package:boilerplate/domain/usecase/proposal/get_proposal_usecase.dart';
import 'package:boilerplate/domain/usecase/proposal/update_proposal.dart';
import 'package:boilerplate/domain/usecase/skillSet/get_skill_set.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';

import 'package:boilerplate/domain/usecase/project/get_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/post_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';

import '../../../di/service_locator.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );

    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<FindPostByIdUseCase>(
      FindPostByIdUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<InsertPostUseCase>(
      InsertPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(getIt<PostRepository>()),
    );

    //
    getIt.registerSingleton<StudentHubLoginUC>(
      StudentHubLoginUC(getIt<AuthRepository>()),
    );

    getIt.registerSingleton<StudentHubSignupUC>(
      StudentHubSignupUC(getIt<AuthRepository>()),
    );

    // Profile:--------------------------------------------------------------------
    getIt.registerSingleton<ProfileTestUC>(
      ProfileTestUC(getIt<AuthRepository>()),
    );
    getIt.registerSingleton<CreateProfileCompanyUC>(
      CreateProfileCompanyUC(getIt<ProfileCompanyRepository>()),
    );
    getIt.registerSingleton<CreateProfileStudentUC>(
      CreateProfileStudentUC(getIt<ProfileStudentRepository>()),
    );

    // Project:--------------------------------------------------------------------
    getIt.registerSingleton<GetProjectsUseCase>(
      GetProjectsUseCase(getIt<ProjectRepository>()),
    );

    // Techstack:--------------------------------------------------------------------
    getIt.registerSingleton<GetTechStackUseCase>(
      GetTechStackUseCase(getIt<TechStackRepository>()),
    );

    // SkillSet:--------------------------------------------------------------------
    getIt.registerSingleton<GetSkillSetUC>(
        GetSkillSetUC(getIt<SkillSetRepository>()));

    // Language:--------------------------------------------------------------------
    getIt.registerSingleton<GetLanguageByStudentIdUseCase>(
      GetLanguageByStudentIdUseCase(getIt<LanguageRepository>()),
    );
    getIt.registerSingleton<UpdateLanguageByStudentIdUseCase>(
      UpdateLanguageByStudentIdUseCase(getIt<LanguageRepository>()),
    );

    // Education:--------------------------------------------------------------------
    getIt.registerSingleton<GetEducationByStudentIdUseCase>(
      GetEducationByStudentIdUseCase(getIt<EducationRepository>()),
    );
    getIt.registerSingleton<UpdateEducationByStudentIdUseCase>(
      UpdateEducationByStudentIdUseCase(getIt<EducationRepository>()),
    );

    // Experience:--------------------------------------------------------------------
    getIt.registerSingleton<GetExperienceByStudentIdUseCase>(
      GetExperienceByStudentIdUseCase(getIt<ExperienceRepository>()),
    );
    getIt.registerSingleton<UpdateExperienceByStudentIdUseCase>(
      UpdateExperienceByStudentIdUseCase(getIt<ExperienceRepository>()),
    );

    // Profile:----------------------------------------------------------------------
    getIt.registerSingleton<GetProfileUseCase>(
      GetProfileUseCase(getIt<ProfileUserRepository>()),
    );

    // Project:----------------------------------------------------------------------
    getIt.registerSingleton<GetCompanyProjectsUseCase>(
        GetCompanyProjectsUseCase(getIt<ProjectRepository>()));
    getIt.registerSingleton<PostCompanyProjectsUseCase>(
        PostCompanyProjectsUseCase(getIt<ProjectRepository>()));
    getIt.registerSingleton<UpdateProjectsUseCase>(
        UpdateProjectsUseCase(getIt<ProjectRepository>()));
    getIt.registerSingleton<DeleteProjectsUseCase>(
        DeleteProjectsUseCase(getIt<ProjectRepository>()));

    // Favorite:--------------------------------------------------------------------
    getIt.registerSingleton<AddFavoriteByStudentIdUseCase>(
      AddFavoriteByStudentIdUseCase(getIt<FavoriteRepository>()),
    );
    getIt.registerSingleton<GetFavoriteByStudentIdUseCase>(
      GetFavoriteByStudentIdUseCase(getIt<FavoriteRepository>()),
    );
    //Propsal:--------------------------------------------------------------------
    getIt.registerSingleton<GetProposalsByProjectIdUseCase>(
      GetProposalsByProjectIdUseCase(getIt<ProposalRepository>()),
    );
    getIt.registerSingleton<CreateProposalUseCase>(
      CreateProposalUseCase(getIt<ProposalRepository>()),
    );
    getIt.registerSingleton<UpdateProposalUseCase>(
      UpdateProposalUseCase(getIt<ProposalRepository>()),
    );
  }
}
