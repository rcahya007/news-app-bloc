// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/auth_remote_datasource.dart';
import 'package:news_app/data/models/request/user_login_request_model.dart';
import 'package:news_app/data/models/response/user_login_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response = await authRemoteDatasource.login(event.user);
      response.fold(
        (massage) => emit(_Error(massage)),
        (response) => emit(_Loaded(response)),
      );
    });
  }
}
