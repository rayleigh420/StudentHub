import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class GetProposalsStudentUseCase extends UseCase<List<ItemProposal>, void> {
  final ProposalRepository _proposalRepository;

  GetProposalsStudentUseCase(this._proposalRepository);

  @override
  Future<List<ItemProposal>> call({required params}) {
    return _proposalRepository.getProposalStudent();
  }
}
