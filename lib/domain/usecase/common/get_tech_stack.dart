import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/post/post_list.dart';
import 'package:boilerplate/domain/entity/techStack/techStack_list.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/techStack/teach_stack_repository.dart';

class GetTechStackUseCase extends UseCase<TechStackList, void> {
  final TechStackRepository _techStackRepository;

  GetTechStackUseCase(this._techStackRepository);

  @override
  Future<TechStackList> call({required params}) {
    return _techStackRepository.getTechStacks();
  }
}
