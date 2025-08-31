// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserInfo _$AuthUserInfoFromJson(Map<String, dynamic> json) => AuthUserInfo(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String?,
  locale: json['locale'] as String,
  city: json['city'] as String?,
  country: json['country'] as String?,
  interestedGames:
      (json['preferred_games'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$AuthUserInfoToJson(AuthUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'locale': instance.locale,
      'city': instance.city,
      'country': instance.country,
      'preferred_games': instance.interestedGames,
    };
