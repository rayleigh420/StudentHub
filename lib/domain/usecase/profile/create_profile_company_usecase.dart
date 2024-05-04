import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/profile/profile_company_repository.dart';

class CreateProfileCompanyParams {
  final String companyName;
  final int size;
  final String website;
  final String description;
  CreateProfileCompanyParams({
    required this.companyName,
    required this.size,
    required this.website,
    required this.description,
  });
}

class CreateProfileCompanyUC extends UseCase<bool, CreateProfileCompanyParams> {
  final ProfileCompanyRepository _profileCompanyRepository;

  CreateProfileCompanyUC(this._profileCompanyRepository);

  @override
  Future<bool> call({required params}) {
    return _profileCompanyRepository.createProfileCompany(
        params.companyName, params.size, params.website, params.description);
  }
}
