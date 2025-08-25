import 'dart:convert';
import 'dart:io';

import 'package:data_fetching_terminal_app/exceptions/exceptions.dart';

int isValidint(var input) {
  try {
    return int.parse(input);
  } on FormatException {
    throw InvalidInputException(
      'You have provided an Invalid ID. Your ID should be an integer',
    );
  }
}

Future<void> writeJsonToFile(File file, dynamic data) async {
  final jsonString = const JsonEncoder.withIndent("  ").convert(data);
  await file.writeAsString(jsonString);
}

Future<dynamic> readJsonFromFile(File file) async {
  final jsonFileContent = await file.readAsString();
  if (jsonFileContent.isEmpty) return null;
  return jsonDecode(jsonFileContent);
}
