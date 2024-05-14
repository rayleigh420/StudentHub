import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/profile/company.dart';
import 'package:boilerplate/domain/repository/profile/profile_company_repository.dart';

class UpdateProfileCompanyParams {
  final String companyName;
  final int size;
  final String website;
  final String description;
  UpdateProfileCompanyParams({
    required this.companyName,
    required this.size,
    required this.website,
    required this.description,
  });
}

class UpdateProfileCompanyUC extends UseCase<Company, UpdateProfileCompanyParams> {
  final ProfileCompanyRepository _profileCompanyRepository;

  UpdateProfileCompanyUC(this._profileCompanyRepository);

  @override
  Future<Company> call({required params}) {
    return _profileCompanyRepository.updateProfileCompany(
        params.companyName, params.size, params.website, params.description);
  }
}
