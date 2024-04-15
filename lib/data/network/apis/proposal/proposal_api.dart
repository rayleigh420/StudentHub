import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:dio/dio.dart';

class ProposalApi {
  final DioClient _dioClient;

  ProposalApi(this._dioClient);

  Future<bool> createProposal(
      int projectId, int studentId, String coverLetter, int statusFlag) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.createProposal,
          data: jsonEncode({
            "projectId": projectId,
            "studentId": studentId,
            "coverLetter": coverLetter,
            "statusFlag": statusFlag,
            "disableFlag": 0
          }));
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw new Exception(e.toString());
    }
  }

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
