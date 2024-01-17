import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/request/login_request_model.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response =
          await AuthRemoteDatasource().login(event.loginRequestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
