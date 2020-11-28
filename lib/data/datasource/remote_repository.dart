import 'dart:convert';

import 'package:TataEdgeDemo/data/network/network_client/api_client.dart';
import 'package:TataEdgeDemo/data/network/request/api_question_list_response.dart';
import 'package:dio/dio.dart';

class RemoteDatasource {
  ApiClient apiClient;

  RemoteDatasource(this.apiClient);

  /// fetch questions from remote for the category
  /// @param category : String
  Future<List<QuestionsListResponse>> getQuestions(String category) async {
    var path = "api/v1/questions?limit=10&category=$category";
    Response<String> response = await apiClient.get(path, null, null);
    List responseJson = jsonDecode(response.data);
    var responseList = responseJson
        .map((json) => QuestionsListResponse.fromJson(json))
        .toList();
    return responseList;
  }
}
