import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';

abstract class ProposalRepository {
  Future<bool> createProposal(
      int projectId, String coverLetter, int statusFlag);
  Future<Proposal> getProposalsByProjectId(int id);
  Future<bool> udpateProposalById(int id, String coverLetter, int statusFlag);
  Future<List<ItemProposal>> getProposalStudent();
}
