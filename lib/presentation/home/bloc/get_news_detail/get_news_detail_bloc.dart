// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/news_remote_datasource.dart';
import 'package:news_app/data/models/response/news_response_model.dart';

part 'get_news_detail_bloc.freezed.dart';
part 'get_news_detail_event.dart';
part 'get_news_detail_state.dart';

class GetNewsDetailBloc extends Bloc<GetNewsDetailEvent, GetNewsDetailState> {
  final NewsRemoteDatasource newsRemoteDatasource;
  GetNewsDetailBloc(
    this.newsRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetNewsDetail>((event, emit) async {
      emit(const _Loading());
      final response = await newsRemoteDatasource.getNewsDetail(event.article);
      response.fold(
        (massage) => emit(_Error(massage)),
        (response) => emit(_Loaded(response)),
      );
    });
  }
}
