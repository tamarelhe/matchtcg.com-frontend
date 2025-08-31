import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/auth_user_info.dart';
import '../models/user_requests.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @GET('/me')
  Future<AuthUserInfo> getCurrentUser();

  @PUT('/me')
  Future<AuthUserInfo> updateProfile(@Body() UpdateProfileRequest request);

  @DELETE('/me')
  Future<void> deleteAccount();

  @GET('/me/export')
  Future<dynamic> exportUserData();
}
