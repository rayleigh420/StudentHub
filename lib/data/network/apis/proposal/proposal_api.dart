import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:dio/dio.dart';

class ProposalApi {
  final DioClient _dioClient;

  ProposalApi(this._dioClient);

  Future<Proposal> getProposalsByProjectId(String token, int id) async {
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
      // log("getProposalsByProjectId");
      // log(res.data["result"].runtimeType.toString());
      return Proposal.fromJson(res.data["result"]);
    } catch (e) {
      log("error in get projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
