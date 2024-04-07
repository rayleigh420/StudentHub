import 'package:boilerplate/domain/entity/profile/profile.dart';

abstract class ProfileUserRepository {
  // Future<String> getProfileCompany();
  Future<Profile> getProfile();
}
