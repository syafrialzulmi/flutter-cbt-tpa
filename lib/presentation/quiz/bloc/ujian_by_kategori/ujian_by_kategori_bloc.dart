// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_tpa/data/datasources/ujian_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/responses/ujian_response_model.dart';

part 'ujian_by_kategori_bloc.freezed.dart';
part 'ujian_by_kategori_event.dart';
part 'ujian_by_kategori_state.dart';

class UjianByKategoriBloc
    extends Bloc<UjianByKategoriEvent, UjianByKategoriState> {
  final UjianRemoteDatasource ujianRemoteDatasource;
  UjianByKategoriBloc(
    this.ujianRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetUjianByKategori>((event, emit) async {
      emit(const _Loading());
      final response =
          await ujianRemoteDatasource.getUjianByKetegori(event.kategori);
      response.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data.isEmpty) {
            emit(const _Notfound());
          } else {
            emit(_Success(r));
          }
        },
      );
    });
  }
}
