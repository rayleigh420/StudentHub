abstract class ProfileCompanyRepository {
  // Future<String> getProfileCompany();
  Future<bool> createProfileCompany(
    String companyName,
    int size,
    String website,
    String description,
  );
}