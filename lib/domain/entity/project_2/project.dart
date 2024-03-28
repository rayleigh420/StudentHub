class Project {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  int? companyId;
  int? projectScopeId;
  String? title;
  String? description;
  int? typeFlag;

  Project({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeId,
    this.title,
    this.description,
    this.typeFlag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'company_id': companyId,
      'project_scope_id': projectScopeId,
      'title': title,
      'description': description,
      'type_flag': typeFlag,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: DateTime.parse(map['deleted_at']),
      companyId: map['company_id'],
      projectScopeId: map['project_scope_id'],
      title: map['title'],
      description: map['description'],
      typeFlag: map['type_flag'],
    );
  }
}
