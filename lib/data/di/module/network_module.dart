import 'package:boilerplate/core/data/network/dio/configs/dio_configs.dart';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/logging_interceptor.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/apis/educations/education_api.dart';
import 'package:boilerplate/data/network/apis/experiences/experience_api.dart';
import 'package:boilerplate/data/network/apis/favorite/favorite_api.dart';
import 'package:boilerplate/data/network/apis/languages/language_api.dart';
import 'package:boilerplate/data/network/apis/message/message_api.dart';
import 'package:boilerplate/data/network/apis/noti/noti_api.dart';
import 'package:boilerplate/data/network/apis/pdf_api/pdf_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/network/apis/proposal/proposal_api.dart';
import 'package:boilerplate/data/network/apis/resume/resume_api.dart';
import 'package:boilerplate/data/network/apis/skillSet/skill_set_api.dart';
import 'package:boilerplate/data/network/apis/project/project_api.dart';
import 'package:boilerplate/data/network/apis/techStacks/tech_stack_api.dart';
import 'package:boilerplate/data/network/apis/transcript/transcript_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/interceptors/error_interceptor.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async =>
            await getIt<SharedPreferenceHelper>().authToken,
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: Endpoints.baseUrl,
        connectionTimeout: Endpoints.connectionTimeout,
        receiveTimeout: Endpoints.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<ErrorInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );
    // getIt.registerSingleton<SocketClient>(SocketClient());
    // api's:-------------------------------------------------------------------
    getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));

    getIt.registerSingleton(AuthApi(getIt<DioClient>()));

    getIt.registerSingleton(ProfileApi(getIt<DioClient>()));

    getIt.registerSingleton(ProjectApi(getIt<DioClient>()));

    getIt.registerSingleton<TechStackApi>(TechStackApi(getIt<DioClient>()));

    getIt.registerSingleton<SkillSetApi>(SkillSetApi(getIt<DioClient>()));

    getIt.registerSingleton<LanguageApi>(LanguageApi(getIt<DioClient>()));

    getIt.registerSingleton<EducationApi>(EducationApi(getIt<DioClient>()));

    getIt.registerSingleton<ExperienceApi>(ExperienceApi(getIt<DioClient>()));

    getIt.registerSingleton<FavoriteApi>(FavoriteApi(getIt<DioClient>()));

    getIt.registerSingleton<ProposalApi>(ProposalApi(getIt<DioClient>()));

    getIt.registerSingleton<ResumeApi>(ResumeApi(getIt<DioClient>()));

    getIt.registerSingleton<TranscriptApi>(TranscriptApi(getIt<DioClient>()));

    getIt.registerSingleton<MessageApi>(MessageApi(getIt<DioClient>()));

    getIt.registerSingleton<PDFApi>(PDFApi());

    getIt.registerSingleton<NotiApi>(NotiApi(getIt<DioClient>()));
  }
}
