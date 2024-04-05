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
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      userId: map['userId'],
      companyName: map['companyName'],
      website: map['website'],
      size: map['size'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'userId': userId,
      'companyName': companyName,
      'website': website,
      'size': size,
      'description': description,
    };
  }

  void getTypes() {
    print('Company');
    print('id: ${id.runtimeType}');
    print('createdAt: ${createdAt.runtimeType}');
    print('updatedAt: ${updatedAt.runtimeType}');
    print('deletedAt: ${deletedAt?.runtimeType}');
    print('userId: ${userId.runtimeType}');
    print('companyName: ${companyName.runtimeType}');
    print('website: ${website.runtimeType}');
    print('size: ${size.runtimeType}');
    print('description: ${description.runtimeType}');
  }
}
