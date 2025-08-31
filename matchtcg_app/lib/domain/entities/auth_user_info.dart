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
  final String? city;
  final String? country;
  @JsonKey(name: 'preferred_games')
  final List<String>? interestedGames;

  const AuthUserInfo({
    required this.id,
    required this.email,
    this.displayName,
    required this.locale,
    this.city,
    this.country,
    this.interestedGames,
  });

  factory AuthUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserInfoToJson(this);

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    locale,
    city,
    country,
    interestedGames,
  ];

  AuthUserInfo copyWith({
    String? id,
    String? email,
    String? displayName,
    String? locale,
    String? city,
    String? country,
    List<String>? interestedGames,
  }) {
    return AuthUserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      locale: locale ?? this.locale,
      city: city ?? this.city,
      country: country ?? this.country,
      interestedGames: interestedGames ?? this.interestedGames,
    );
  }
}
