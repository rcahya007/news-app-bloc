part of 'get_news_bloc.dart';

@freezed
class GetNewsEvent with _$GetNewsEvent {
  const factory GetNewsEvent.started() = _Started;
  const factory GetNewsEvent.getNews() = _GetNews;
}
