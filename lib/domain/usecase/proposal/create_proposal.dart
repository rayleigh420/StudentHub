import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class CreateProposalParam {
  final int projectId;
  final String coverLetter;
  final int statusFlag;

  CreateProposalParam(this.projectId, this.coverLetter, this.statusFlag);
}

class CreateProposalUseCase extends UseCase<bool, CreateProposalParam> {
  final ProposalRepository _proposalRepository;

  CreateProposalUseCase(this._proposalRepository);

  @override
  Future<bool> call({required CreateProposalParam params}) {
    return _proposalRepository.createProposal(
        params.projectId, params.coverLetter, params.statusFlag);
  }
}
