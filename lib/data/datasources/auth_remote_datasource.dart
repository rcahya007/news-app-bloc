import 'package:dartz/dartz.dart';
import 'package:news_app/data/models/request/user_login_request_model.dart';
import 'package:news_app/data/models/response/user_login_response_model.dart';
// import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, UserLoginResponseModel>> login(
      UserLoginRequestModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    if (user.email == 'test@example.com' && user.password == 'password') {
      return Right(UserLoginResponseModel(
          email: 'test@example.com',
          name: 'test-name',
          userId: '1',
          username: 'test-username'));
    } else {
      return const Left('User not found');
    }
  }
}
