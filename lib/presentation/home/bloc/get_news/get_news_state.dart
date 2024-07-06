part of 'get_news_bloc.dart';

@freezed
class GetNewsState with _$GetNewsState {
  const factory GetNewsState.initial() = _Initial;
  const factory GetNewsState.loading() = _Loading;
  const factory GetNewsState.loaded(NewsResponseModel news) = _Loaded;
  const factory GetNewsState.error(String message) = _Error;
}
