import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_response.freezed.dart';
part 'group_response.g.dart';

@freezed
abstract class GroupResponse with _$GroupResponse {
  const factory GroupResponse({
    required String name,
    required String description,
    required DateTime createdAt,
  }) = _GroupResponse;

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);
}
