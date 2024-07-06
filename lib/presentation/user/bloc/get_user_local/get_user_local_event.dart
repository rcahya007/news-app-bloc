part of 'get_user_local_bloc.dart';

@freezed
class GetUserLocalEvent with _$GetUserLocalEvent {
  const factory GetUserLocalEvent.started() = _Started;
  const factory GetUserLocalEvent.getUserLocal() = _GetUserLocal;
}
