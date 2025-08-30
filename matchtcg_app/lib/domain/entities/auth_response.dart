import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'auth_user_info.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends Equatable {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  final AuthUserInfo user;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType,
    required this.expiresAt,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    tokenType,
    expiresAt,
    user,
  ];
}
