import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/auth_local_datasource.dart';
import 'package:news_app/data/models/response/user_login_response_model.dart';

part 'get_user_local_bloc.freezed.dart';
part 'get_user_local_event.dart';
part 'get_user_local_state.dart';

class GetUserLocalBloc extends Bloc<GetUserLocalEvent, GetUserLocalState> {
  final AuthLocalDatasource authLocalDatasource;
  GetUserLocalBloc(
    this.authLocalDatasource,
  ) : super(const _Initial()) {
    on<_GetUserLocal>((event, emit) async {
      emit(const _Loading());
      final response = await authLocalDatasource.getAuthData();
      if (response != null) {
        emit(_Loaded(response));
      } else {
        emit(const _Error('Something went wrong'));
      }
    });
  }
}
