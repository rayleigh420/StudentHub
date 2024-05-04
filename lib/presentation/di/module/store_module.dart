import 'dart:async';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/usecase/message/get_all_message_usecase.dart';
import 'package:boilerplate/domain/usecase/message/get_project_message.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/domain/usecase/project/delete_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/project/get_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/post_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/update_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/chat/store/current_message_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/chat/store/notification_store.dart';

import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/navigations/tab_store.dart';
import 'package:boilerplate/presentation/post/store/post_store.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';

import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton(ProjectStore(
      getIt<GetProjectsUseCase>(),
      getIt<ErrorStore>(),
    ));

    getIt.registerSingleton(ProfileStore(getIt<GetProfileUseCase>(),
        getIt<ErrorStore>(), getIt<SharedPreferenceHelper>()));

    getIt.registerSingleton(
      ProjectCompanyStore(
        getIt<GetCompanyProjectsUseCase>(),
        getIt<PostCompanyProjectsUseCase>(),
        getIt<UpdateProjectsUseCase>(),
        getIt<DeleteProjectsUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton(
      MessageStore(
        getIt<GetAllMessageUseCase>(),
        getIt<GetProjectMessageUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton(TabStore());

    getIt.registerSingleton(NotificationStore(
        getIt<SharedPreferenceHelper>(), getIt<ErrorStore>()));

    getIt.registerSingleton(
      CurrentMessageStore(
        getIt<ErrorStore>(),
      ),
    );
  }
}
