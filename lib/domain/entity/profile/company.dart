// "id": 31,
//       "createdAt": "2024-04-01T05:01:38.659Z",
//       "updatedAt": "2024-04-01T05:01:38.659Z",
//       "deletedAt": null,
//       "userId": 79,
//       "companyName": "Long company",
//       "website": "string",
//       "size": 10,
//       "description": "string"
class Company {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int userId;
  String companyName;
  String website;
  int size;
  String description;
  Company({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.companyName,
    required this.website,
    required this.size,
    required this.description,
  });

  factory Company.fromJson(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: DateTime.parse(map['deleted_at']),
      userId: map['user_id'],
      companyName: map['company_name'],
      website: map['website'],
      size: map['size'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'user_id': userId,
      'company_name': companyName,
      'website': website,
      'size': size,
      'description': description,
    };
  }
}
