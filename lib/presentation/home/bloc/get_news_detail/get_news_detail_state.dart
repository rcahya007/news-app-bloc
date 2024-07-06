part of 'get_news_detail_bloc.dart';

@freezed
class GetNewsDetailState with _$GetNewsDetailState {
  const factory GetNewsDetailState.initial() = _Initial;
  const factory GetNewsDetailState.loading() = _Loading;
  const factory GetNewsDetailState.loaded(Article article) = _Loaded;
  const factory GetNewsDetailState.error(String message) = _Error;
}
