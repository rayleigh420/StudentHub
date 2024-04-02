class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://34.16.137.128";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // auth endpoints
  static const String logIn = baseUrl + "/api/auth/sign-in";
  static const String signUp = baseUrl + "/api/auth/sign-up";

  // profile endpoints
  static const String createProfileCompany = baseUrl + "/api/profile/company";
  static const String createProfileStudent = baseUrl + "/api/profile/student";

  //project endpoints
  static const String createProject = baseUrl + "/api/project";
  static const String getProjects = baseUrl + "/api/project";
  static const String getProjectById = baseUrl + "/api/project";

  // TechStack endpoints
  static const String getTechStacks =
      baseUrl + "/api/techStack/getAllTechStack";

  // Language endpoints
  static const String getLanguages = baseUrl + "/api/language/getByStudentId";
  static const String updateLanguage =
      baseUrl + "/api/language/updateByStudentId";
}
