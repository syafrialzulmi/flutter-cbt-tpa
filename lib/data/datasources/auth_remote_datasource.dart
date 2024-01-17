import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_tpa/core/constants/variables.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/request/login_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cbt_tpa/data/models/request/register_request_model.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: registerRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Register Gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/logout'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData.accessToken}',
        });
    if (response.statusCode == 200) {
      return const Right('Logout Berhasil');
    } else {
      return const Left("Logout Gagal");
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/login'),
            headers: <String, String>{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: loginRequestModel.toJson());
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left("Login Gagal");
    }
  }
}
