class Endpoints {
  Endpoints._();

  // base url
  // static const String baseUrl = "http://jsonplaceholder.typicode.com";
  static const String baseUrl = "http://192.168.6.104:4400";
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // auth endpoints
  static const String logIn = baseUrl + "/api/auth/sign-in";
  static const String signUp = baseUrl + "/api/auth/sign-up";
}
