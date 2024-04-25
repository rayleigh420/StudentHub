import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:dio/dio.dart';

class ProposalApi {
  final DioClient _dioClient;

  ProposalApi(this._dioClient);

  Future<Proposal> getProposalsByProjectId(String token, int id) async {
    print("getProposalsByProjectId");
    Proposal result;
    ItemProposal itemProposal;
    try {
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.get(
        Endpoints.getProposals + "/$id",
        options: Options(
          headers: {
            'Authorization': authToken,
          },
        ),
      );
      print("getProposalsByProjectId12345");
      print(res.data["result"].runtimeType.toString());
      print(res.data["result"]);
      print("123456");
      result = Proposal.fromJson(res.data["result"]);
      print(result.toJson());
      itemProposal =result.items![0];
      print(itemProposal.student!.id);
      return Proposal.fromJson(res.data["result"]);
    }  catch (e) {
       log("error in get projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}