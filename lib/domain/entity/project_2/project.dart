class Project {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? companyId;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? typeFlag;
  int? numberOfStudents;
  // List<dynamic>? proposals;
  int? countProposals;
  int? countMessages;
  int? countHired;
  bool? isSaved;
  Project({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.typeFlag,
    this.numberOfStudents,
    // this.proposals,
    this.countProposals,
    this.countMessages,
    this.countHired,
    this.isSaved,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudents,
      // 'proposals': proposals,
      'countProposals': countProposals,
      'countMessages': countMessages,
      'countHired': countHired,
      'isSaved': isSaved ?? false,
    };
  }

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      companyId: map['companyId'],
      projectScopeFlag: map['projectScopeFlag'],
      title: map['title'],
      description: map['description'],
      typeFlag: map['typeFlag'],
      numberOfStudents: map['numberOfStudents'],
      // proposals: List<dynamic>.from(map['proposals']),
      countProposals: map['countProposals'],
      countMessages: map['countMessages'],
      countHired: map['countHired'],
      isSaved: map['isSaved'],
    );
  }
}
