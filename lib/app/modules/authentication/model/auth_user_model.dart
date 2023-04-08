import 'package:freezed_annotation/freezed_annotation.dart'
    '';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    required String status,
    String? createdAt,
    String? updatedAt,
    String? avatar,
    String? birthday,
    String? firstName,
    String? lastName,
    String? fullName,
    String? gender,
    String? phone,
    bool? flagAvatar,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, Object?> json) =>
      _$AuthUserModelFromJson(json);
}
