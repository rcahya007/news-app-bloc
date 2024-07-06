// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/auth_local_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthLocalDatasource authLocalDatasource;
  LogoutBloc(
    this.authLocalDatasource,
  ) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());
      await authLocalDatasource.removeAuthData();
      emit(const _Loaded('Logout success'));
    });
  }
}
