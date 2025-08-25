import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@Freezed()
abstract class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    required String firstName,
    required String lastName,
    required int dobYear,
    required String country,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
