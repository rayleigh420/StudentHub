import 'package:boilerplate/data/network/apis/proposal/proposal_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class ProposalRepositoryImpl implements ProposalRepository {
  final SharedPreferenceHelper _sharedPreferenceHelper;
  final ProposalApi _proposalApi;

  ProposalRepositoryImpl(this._proposalApi, this._sharedPreferenceHelper);

  @override
  Future<Proposal> getProposalsByProjectId(int id) async {
    try {
      final token = await _sharedPreferenceHelper.authToken;
      
      final Proposal result = await _proposalApi.getProposalsByProjectId(token!, id);

      return result;
    } catch (e) {
      throw e;
    }
  }
  
  

}

