// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';

class Proposal {
  bool? hasNext;
  String? offset;
  String? limit;
  int? total;
  List<ItemProposal>? items;
  Proposal({
    required this.hasNext,
    required this.offset,
    required this.limit,
    required this.total,
    this.items,
  });
  factory Proposal.fromJson(Map<String, dynamic> map) {
    return Proposal(
      hasNext: map['hasNext'],
      offset: map['offset'],
      limit: map['limit'],
      total: map['total'],
      items: List<ItemProposal>.from(
          map['items']?.map((x) => ItemProposal.fromJson(x))?.toList() ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "hasNext": hasNext,
      "offset": offset,
      "limit": limit,
      "total": total,
      "items": items != null ? items!.map((x) => x.toJson()).toList() : null,
    };
  }
}
