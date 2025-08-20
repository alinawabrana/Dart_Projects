// import 'package:json_annotation/json_annotation.dart';
// part 'info_object.g.dart';

// @JsonSerializable()
// class InfoObject {
//   final String id;
//   final String name;
//   final Data data;

//   InfoObject({required this.id, required this.name, required this.data});

//   factory InfoObject.fromJson(Map<String, dynamic> json) =>
//       _$InfoObjectFromJson(json);

//   Map<String, dynamic> toJson(InfoObject instance) =>
//       _$InfoObjectToJson(instance);
// }

// @JsonSerializable()
// class Data {
//   final int year;
//   final double price;
//   @JsonKey(name: 'CPU model')
//   final String cpuModel;
//   @JsonKey(name: 'Hard disk size')
//   final String hardDiskSize;

//   Data({
//     required this.year,
//     required this.price,
//     required this.cpuModel,
//     required this.hardDiskSize,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

//   Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
// }
