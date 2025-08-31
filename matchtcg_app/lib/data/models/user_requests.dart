import 'package:json_annotation/json_annotation.dart';

part 'user_requests.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? locale;
  final String? timezone;
  final String? city;
  final String? country;
  @JsonKey(name: 'preferred_games')
  final List<String>? preferredGames;

  const UpdateProfileRequest({
    this.displayName,
    this.locale,
    this.timezone,
    this.city,
    this.country,
    this.preferredGames,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
