part of 'get_news_detail_bloc.dart';

@freezed
class GetNewsDetailEvent with _$GetNewsDetailEvent {
  const factory GetNewsDetailEvent.started() = _Started;
  const factory GetNewsDetailEvent.getNewsDetail(Article article) =
      _GetNewsDetail;
}
