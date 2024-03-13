class Project {
  final String title;
  final List<String> props;
  final int scopeFrom;
  final String scopeFrom2;
  final int? scopeTo;
  final String? scopeTo2;
  int? quantityRequired;
  DateTime? createdDate;
  final int proposal;
  bool? isSaved;
  Project({
    required this.title,
    required this.props,
    required this.scopeFrom,
    required this.scopeFrom2,
    this.scopeTo,
    this.scopeTo2,
    this.quantityRequired,
    this.createdDate,
    required this.proposal,
    this.isSaved
  });
  factory Project.fromMap(Map<String, dynamic> json) => Project(
        title: json["title"],
        props: List<String>.from(json["props"].map((x) => x)),
        scopeFrom: json["scopeFrom"],
        scopeFrom2: json["scopeFrom2"],
        scopeTo: json["scopeTo"],
        scopeTo2: json["scopeTo2"],
        quantityRequired: json["quantityRequired"],
        createdDate: DateTime.parse(json["createdDate"]),
        proposal: json["proposal"],
        isSaved: json["isSaved"]
      );
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "props": props,
      "scopeFrom": scopeFrom,
      "scopeFrom2": scopeFrom2,
      "scopeTo": scopeTo,
      "scopeTo2": scopeTo2,
      "quantityRequired": quantityRequired,
      "createdDate": createdDate,
      "proposal": proposal,
      "isSaved": isSaved
    };
  }
}
