import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeze_practice.freezed.dart';
part 'freeze_practice.g.dart';

@Freezed()
abstract class InfoObjectFreezed with _$InfoObjectFreezed {
  const factory InfoObjectFreezed({
    required String id,
    required String name,
    required DataFreezed data,
  }) = _InfoObjectFreezed;

  factory InfoObjectFreezed.fromJson(Map<String, Object?> json) =>
      _$InfoObjectFreezedFromJson(json);
}

@Freezed()
abstract class DataFreezed with _$DataFreezed {
  const factory DataFreezed({
    required int year,
    required double price,
    @JsonKey(name: 'CPU model') required String cpuModel,
    @JsonKey(name: 'Hard disk size') required String hardDiskSize,
  }) = _DataFreezed;

  factory DataFreezed.fromJson(Map<String, Object?> json) =>
      _$DataFreezedFromJson(json);
}

@freezed
abstract class Person with _$Person {
  // Added constructor. Must not have any parameter
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world. This is $name with age $age');
  }
}
