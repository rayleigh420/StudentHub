import 'package:boilerplate/domain/entity/proposal/proposal.dart';

abstract class ProposalRepository {
  Future<bool> createProposal(
      int projectId, String coverLetter, int statusFlag);
  Future<Proposal> getProposalsByProjectId(int id);
}
