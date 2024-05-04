class Project {
  int? id;
  int? projectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? companyId;
  String? companyName;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? typeFlag;
  int? numberOfStudents;
  // List<dynamic>? proposals;
  int? countProposals;
  int? countMessages;
  int? countHired;
  bool? isFavorite;
  Project({
    this.id,
    this.projectId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.typeFlag,
    this.numberOfStudents,
    this.companyName,
    // this.proposals,
    this.countProposals,
    this.countMessages,
    this.countHired,
    this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudents,
      'companyName': companyName ?? '',
      // 'proposals': proposals,
      'countProposals': countProposals,
      'countMessages': countMessages,
      'countHired': countHired,
      'isFavorite': isFavorite ?? false,
    };
  }

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      projectId: map['projectId'] != null ? map['projectId'] : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      companyId: map['companyId'] != null ? map['companyId'] : null,
      projectScopeFlag:
          map['projectScopeFlag'] != null ? map['projectScopeFlag'] : null,
      title: map['title'] != null ? map['title'] : null,
      description: map['description'] != null ? map['description'] : null,
      typeFlag: map['typeFlag'] != null ? map['typeFlag'] : null,
      numberOfStudents: map['numberOfStudents'] ?? 0,
      // proposals: List<dynamic>.from(map['proposals']),
      countProposals: map['countProposals'] ?? 0,
      countMessages: map['countMessages'] ?? 0,
      countHired: map['countHired'] ?? 0,
      isFavorite: map['isFavorite'] ?? false,
      companyName: map['companyName'] != null ? map['companyName'] : null,
    );
  }
}
