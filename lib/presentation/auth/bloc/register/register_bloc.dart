import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/request/register_request_model.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final response =
          await AuthRemoteDatasource().register(event.registerRequestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}