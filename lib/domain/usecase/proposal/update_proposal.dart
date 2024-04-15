import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class UpdateProposalParam {
  final int proposalId;
  final String coverLetter;
  final int statusFlag;

  UpdateProposalParam(this.proposalId, this.coverLetter, this.statusFlag);
}

class UpdateProposalUseCase extends UseCase<bool, UpdateProposalParam> {
  final ProposalRepository _proposalRepository;

  UpdateProposalUseCase(this._proposalRepository);

  @override
  Future<bool> call({required UpdateProposalParam params}) {
    return _proposalRepository.udpateProposalById(
        params.proposalId, params.coverLetter, params.statusFlag);
  }
}
