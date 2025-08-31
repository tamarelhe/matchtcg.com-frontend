// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  displayName: json['display_name'] as String?,
  locale: json['locale'] as String?,
  timezone: json['timezone'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  preferredGames:
      (json['preferred_games'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'display_name': instance.displayName,
  'locale': instance.locale,
  'timezone': instance.timezone,
  'city': instance.city,
  'country': instance.country,
  'preferred_games': instance.preferredGames,
};
