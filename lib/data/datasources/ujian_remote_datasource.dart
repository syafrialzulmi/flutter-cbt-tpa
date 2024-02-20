import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_tpa/core/constants/variables.dart';
import 'package:flutter_cbt_tpa/data/models/responses/ujian_response_model.dart';

import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

class UjianRemoteDatasource {
  Future<Either<String, UjianResponseModel>> getUjianByKetegori(
      String kategori) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/get-soal-ujian?kategori=$kategori'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authData.accessToken}',
        });
    if (response.statusCode == 200) {
      return Right(UjianResponseModel.fromJson(response.body));
    } else {
      return const Left("Get ujian gagal");
    }
  }

  Future<Either<String, String>> createUjian() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/create-ujian'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authData.accessToken}',
        });
    if (response.statusCode == 200) {
      return const Right("Create ujian berhasil");
    } else {
      return const Left("Get ujian gagal");
    }
  }

  Future<Either<String, String>> answer(int soalId, String jawaban) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final body = {
      'soal_id': soalId,
      'jawaban': jawaban,
    };

    print('soalId: $soalId');
    print('jawaban: $jawaban');
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/answers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
      body: jsonEncode(body),
      //     body: <String, dynamic>{
      //   'soal_id': soalId,
      //   'jawaban': jawaban,
      // }
    );

    if (response.statusCode == 200) {
      return const Right('answer berhasil');
    } else {
      return const Left('answer gagal');
    }
  }

  Future<Either<String, String>> hitungNilai(String kategori) async {
    final authData = await AuthLocalDatasource().getAuthData();
    print('kategori: $kategori');
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/get-nilai?kategori=$kategori'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('hitung nilai berhasil');
    } else {
      return const Left('hitung nilai gagal');
    }
  }
}
