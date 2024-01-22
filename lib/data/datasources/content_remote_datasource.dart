import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_tpa/core/constants/variables.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/responses/content_response_model.dart';
import 'package:http/http.dart' as http;

class ContentRemoteDatasource {
  Future<Either<String, ContentResponseModel>> getContentById(String id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/contents?id=$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.accessToken}',
        });
    if (response.statusCode == 200) {
      return Right(ContentResponseModel.fromJson(response.body));
    } else {
      return const Left("Logout Gagal");
    }
  }
}
