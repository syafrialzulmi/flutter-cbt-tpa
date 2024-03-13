// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_tpa/data/models/responses/nilai_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_tpa/data/datasources/ujian_remote_datasource.dart';

part 'hitung_nilai_bloc.freezed.dart';
part 'hitung_nilai_event.dart';
part 'hitung_nilai_state.dart';

class HitungNilaiBloc extends Bloc<HitungNilaiEvent, HitungNilaiState> {
  final UjianRemoteDatasource ujianRemoteDatasource;
  HitungNilaiBloc(
    this.ujianRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetNilai>((event, emit) async {
      emit(const HitungNilaiState.loading());
      final response = await ujianRemoteDatasource.hitungNilai(event.kategori);
      response.fold(
        (l) => emit(HitungNilaiState.error(l)),
        (r) => emit(HitungNilaiState.success(r)),
      );
    });
  }
}
