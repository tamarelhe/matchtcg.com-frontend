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
);

Map<String, dynamic> _$AuthUserInfoToJson(AuthUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'locale': instance.locale,
    };
