// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/auth_local_datasource.dart';

part 'check_auth_bloc.freezed.dart';
part 'check_auth_event.dart';
part 'check_auth_state.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvent, CheckAuthState> {
  final AuthLocalDatasource _authLocalDatasource;
  CheckAuthBloc(
    this._authLocalDatasource,
  ) : super(const _Loaded(false)) {
    on<_Check>((event, emit) async {
      emit(const _Loading());
      final authData = await _authLocalDatasource.isAuth();
      if (authData) {
        emit(const _Loaded(true));
      } else {
        emit(const _Loaded(false));
      }
    });
  }
}
