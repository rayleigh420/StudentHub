class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.studenthub.dev";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // auth endpoints
  static const String logIn = baseUrl + "/api/auth/sign-in";
  static const String signUp = baseUrl + "/api/auth/sign-up";
  static const String logOut = baseUrl + "/api/auth/logout";
  static const String changePassword = baseUrl + "/api/user/changePassword";

  // profile endpoints
  static const String createProfileCompany = baseUrl + "/api/profile/company";
  static const String createProfileStudent = baseUrl + "/api/profile/student";
  static const String getProfile = baseUrl + "/api/auth/me";
  static const String updateProfileCompany = baseUrl + "/api/profile/company";
  //project endpoints
  static const String createProject = baseUrl + "/api/project";
  static const String getProjects = baseUrl + "/api/project";
  static const String getProjectById = baseUrl + "/api/project";
  static const String getProjectCompany = baseUrl + "/api/project/company";
  static const String deleteProject = baseUrl + "/api/project";
  static const String updateProject = baseUrl + "/api/project";
  // TechStack endpoints
  static const String getTechStacks =
      baseUrl + "/api/techStack/getAllTechStack";

  // Skillset endpoints
  static const String getSkillSets = baseUrl + "/api/skillset/getAllSkillSet";

  // Language endpoints
  static const String getLanguages = baseUrl + "/api/language/getByStudentId";
  static const String updateLanguage =
      baseUrl + "/api/language/updateByStudentId";

  // Education endpoints
  static const String getEducations = baseUrl + "/api/education/getByStudentId";
  static const String updateEducation =
      baseUrl + "/api/education/updateByStudentId";

  // Experience endpoints
  static const String getExperiences =
      baseUrl + "/api/experience/getByStudentId";
  static const String updateExperience =
      baseUrl + "/api/experience/updateByStudentId";

  // Favorite endpoints
  static const String getFavorites = baseUrl + "/api/favoriteProject";
  static const String addFavorite = baseUrl + "/api/favoriteProject";
  // Proposal endpoints
  static const String getProposals = baseUrl + "/api/proposal/getByProjectId";
  static const String createProposal = baseUrl + "/api/proposal";
  static const String updateProposal = baseUrl + "/api/proposal";
  static const String getProposalStudent = baseUrl + "/api/proposal/student";
  
  // Resume endpoints
  static const String postResume = baseUrl + "/api/profile/student";
  static const String getResume = baseUrl + "/api/profile/student";

  //Transcript endpoints
  static const String postTranscript = baseUrl + "/api/profile/student";
  static const String getTranscript = baseUrl + "/api/profile/student";
}
