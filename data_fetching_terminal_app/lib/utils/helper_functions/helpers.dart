import 'dart:convert';
import 'dart:io';

import 'package:data_fetching_terminal_app/utils/exceptions/exceptions.dart';

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

String convertStringToBinary(String data) {
  return data.runes
      .map((unit) => unit.toRadixString(2).padLeft(8, '0')) // 8-bit binary
      .join(' ');
}

String convertBinaryToString(String binary) {
  return String.fromCharCodes(
    binary.split(" ").map((b) => int.parse(b, radix: 2)),
  );
}

String convertIntToBinary(int data) {
  return data.toRadixString(2);
}
