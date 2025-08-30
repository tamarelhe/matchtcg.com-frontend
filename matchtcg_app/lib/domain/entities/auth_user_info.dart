import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_info.g.dart';

@JsonSerializable()
class AuthUserInfo extends Equatable {
  final String id;
  final String email;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String locale;

  const AuthUserInfo({
    required this.id,
    required this.email,
    this.displayName,
    required this.locale,
  });

  factory AuthUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserInfoToJson(this);

  @override
  List<Object?> get props => [id, email, displayName, locale];

  AuthUserInfo copyWith({
    String? id,
    String? email,
    String? displayName,
    String? locale,
  }) {
    return AuthUserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      locale: locale ?? this.locale,
    );
  }
}
