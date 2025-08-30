import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/auth_response.dart';
import '../models/auth_requests.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/auth/refresh')
  Future<AuthResponse> refresh(@Body() RefreshRequest request);

  @POST('/auth/logout')
  Future<void> logout();

  @GET('/auth/oauth/google')
  Future<HttpResponse<dynamic>> getGoogleOAuthUrl();

  @GET('/auth/oauth/apple')
  Future<HttpResponse<dynamic>> getAppleOAuthUrl();
}
