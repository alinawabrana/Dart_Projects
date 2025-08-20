import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_build_runner_serializable_freeze/data_models/info_object.dart';
import 'package:practice_build_runner_serializable_freeze/frezzed_classes/freeze_practice.dart';

void main(List<String> arguments) async {
  final uri = Uri.parse('https://api.restful-api.dev/objects/7');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final body = response.body;
    final jsonData = jsonDecode(body);
    print(body);
    print(jsonData);

    final p = Person(
      'Ali',
      age: 24,
    ); // This is also a freezed class but with custom variable and method

    p.method(); // This is a cutsom method created while defining freezed abstract class. I also requires the provate constructor for this.

    final info = InfoObjectFreezed.fromJson(jsonData);
    print('${info.name},${info.name.runtimeType}');
    print('${info.data.toString()}');
  }
}

/// Requires build_runner,
/// (json_serilalizable & json_annotation side by side for data classes),
/// (freezed & freezed_annotation side by side for == & hashCode & copyWith overloading in each class)
