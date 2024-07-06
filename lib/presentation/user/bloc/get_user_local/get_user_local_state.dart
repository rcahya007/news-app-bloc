part of 'get_user_local_bloc.dart';

@freezed
class GetUserLocalState with _$GetUserLocalState {
  const factory GetUserLocalState.initial() = _Initial;
  const factory GetUserLocalState.loading() = _Loading;
  const factory GetUserLocalState.loaded(UserLoginResponseModel user) = _Loaded;
  const factory GetUserLocalState.error(String message) = _Error;
}
