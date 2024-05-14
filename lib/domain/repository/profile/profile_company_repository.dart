import 'package:boilerplate/domain/entity/profile/company.dart';

abstract class ProfileCompanyRepository {
  // Future<String> getProfileCompany();
  Future<bool> createProfileCompany(
    String companyName,
    int size,
    String website,
    String description,
  );
  // Future<Company> updateProfileCompany
  Future<Company> updateProfileCompany(
    String companyName,
    int size,
    String website,
    String description,
  );
}