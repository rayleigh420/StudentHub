import 'package:boilerplate/data/network/apis/proposal/proposal_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class ProposalRepositoryImpl implements ProposalRepository {
  final ProposalApi _proposalApi;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  ProposalRepositoryImpl(this._proposalApi, this._sharedPreferenceHelper);

  @override
  Future<bool> createProposal(
      int projectId, String coverLetter, int statusFlag) async {
    try {
      int? studentId = await _sharedPreferenceHelper.currentStudentId;
      bool result = await _proposalApi.createProposal(
          projectId, studentId!, coverLetter, statusFlag);

      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Proposal> getProposalsByProjectId(int id) async {
    try {
      final token = await _sharedPreferenceHelper.authToken;

      final Proposal result =
          await _proposalApi.getProposalsByProjectId(token!, id);

      return result;
    } catch (e) {
      throw e;
    }
  }
}
