import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/data/datasources/news_remote_datasource.dart';
import 'package:news_app/data/models/response/news_response_model.dart';

part 'get_news_bloc.freezed.dart';
part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  NewsRemoteDatasource newsRemoteDatasource;
  GetNewsBloc(
    this.newsRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetNews>((event, emit) async {
      emit(const _Loading());
      final response = await newsRemoteDatasource.getNews();

      response.fold(
        (massage) => emit(_Error(massage)),
        (response) => emit(_Loaded(response)),
      );
    });
  }
}
