import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/repository/proposal/proposal_repository.dart';

class GetProposalsByProjectIdUseCase extends UseCase<Proposal, int>{
  final ProposalRepository _proposalRepository;

  GetProposalsByProjectIdUseCase(this._proposalRepository);



  @override
  FutureOr<Proposal> call({required params}) {
    return _proposalRepository.getProposalsByProjectId(params);
  }
}