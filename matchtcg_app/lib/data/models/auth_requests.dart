import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterRequest {
  final String email;
  final String password;
  final String timezone;
  final String locale;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? country;
  final String? city;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.timezone,
    required this.locale,
    this.displayName,
    this.country,
    this.city,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class RefreshRequest {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  const RefreshRequest({required this.refreshToken});

  factory RefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshRequestToJson(this);
}
