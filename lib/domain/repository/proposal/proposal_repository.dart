
import 'package:boilerplate/domain/entity/proposal/proposal.dart';

abstract class ProposalRepository {
  Future<Proposal> getProposalsByProjectId(int id);
}