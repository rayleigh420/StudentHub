import 'package:boilerplate/domain/entity/techStack/teachStack.dart';

class TechStackList {
  final List<TechStack>? techStacks;

  TechStackList({
    this.techStacks,
  });

  factory TechStackList.fromJson(Map<String, dynamic> json) {
    List<TechStack> techStacks = <TechStack>[];
    techStacks = List.from(
        json['result'].map((techstack) => TechStack.fromMap(techstack)));

    return TechStackList(
      techStacks: techStacks,
    );
  }
}
