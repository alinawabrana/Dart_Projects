import 'dart:io';

import 'package:data_fetching_terminal_app/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';

Future<bool> createLinesOrBinaryFile(
  File idsFile,
  File userFile,
  UserModel user, {
  bool isBinary = false,
}) async {
  final (ids, lines) = await Future.wait([
    idsFile.readAsLines(),
    userFile.readAsLines(),
  ]).then((lists) => (lists[0], lists[1]));
  if (lines.isEmpty) {
    final userWithId = user.copyWith(id: 1);
    await Future.wait([
      idsFile.writeAsString('1\n', mode: FileMode.append),
      !isBinary
          ? userFile.writeAsString(
              '${userWithId.id}\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
              mode: FileMode.append,
            )
          : userFile.writeAsString(
              '${convertIntToBinary(userWithId.id!)}\n${convertStringToBinary(user.firstName)}\n${convertStringToBinary(user.lastName)}\n${convertIntToBinary(user.dobYear)}\n${convertStringToBinary(user.country)}\n\n',
              mode: FileMode.append,
            ),
    ]);
  } else {
    int lastId = int.parse(ids.last);
    lastId = lastId + 1;
    print('last ID = $lastId');
    final userWithId = user.copyWith(id: lastId);
    await Future.wait([
      idsFile.writeAsString('${lastId.toString()}\n', mode: FileMode.append),
      !isBinary
          ? userFile.writeAsString(
              '${userWithId.id}\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
              mode: FileMode.append,
            )
          : userFile.writeAsString(
              '${convertIntToBinary(userWithId.id!)}\n${convertStringToBinary(user.firstName)}\n${convertStringToBinary(user.lastName)}\n${convertIntToBinary(user.dobYear)}\n${convertStringToBinary(user.country)}\n\n',
              mode: FileMode.append,
            ),
    ]);
  }
  return true;
}

Future<bool> deleteLinesOrBinaryFileData(
  File idsFile,
  File userFile,
  int id, {
  bool isBinary = false,
}) async {
  final fileData = await userFile.readAsLines();
  if (fileData.isEmpty) return false;
  final idsData = await idsFile.readAsLines();
  bool idExist = false;
  for (int j = 0; j < idsData.length; j++) {
    if (int.parse(idsData[j]) == id) {
      idExist = true;
    }
  }

  if (!idExist) {
    return false;
  }
  print('File length = ${fileData.length}');
  await Future.wait([idsFile.writeAsString(''), userFile.writeAsString('')]);
  for (int i = 0; i < fileData.length; i = i + 6) {
    if ((!isBinary
            ? int.parse(fileData[0 + i])
            : int.parse(fileData[0 + i], radix: 2)) !=
        id) {
      await Future.wait([
        idsFile.writeAsString(
          '${idsData[(i / 6).floor()]}\n',
          mode: FileMode.append,
        ),
        userFile.writeAsString(
          '${fileData[0 + i]}\n${fileData[1 + i]}\n${fileData[2 + i]}\n${fileData[3 + i]}\n${fileData[4 + i]}\n\n',
          mode: FileMode.append,
        ),
      ]);
    }
  }

  if (fileData.length != userFile.readAsLinesSync().length) {
    print('new file length = ${userFile.readAsLinesSync().length}');
    return true;
  } else {
    print('User Id not found');
    return false;
  }
}

Future<List<UserModel>> getAllLinesOrBinaryFileData(
  File userFile, {
  bool isBinary = false,
}) async {
  final fileData = await userFile.readAsLines();
  if (fileData.isEmpty) return [];
  print('File Data length = ${fileData.length}');
  List<UserModel> allUsers = [];
  if (fileData.isEmpty) return allUsers;
  for (int i = 0; i < fileData.length; i = i + 6) {
    allUsers.add(
      !isBinary
          ? UserModel(
              id: int.parse(fileData[0 + i]),
              firstName: fileData[1 + i],
              lastName: fileData[2 + i],
              dobYear: int.parse(fileData[3 + i]),
              country: fileData[4 + i],
            )
          : UserModel(
              id: int.parse(fileData[0 + i], radix: 2),
              firstName: convertBinaryToString(fileData[1 + i]),
              lastName: convertBinaryToString(fileData[2 + i]),
              dobYear: int.parse(fileData[3 + i], radix: 2),
              country: convertBinaryToString(fileData[4 + i]),
            ),
    );
  }
  return allUsers;
}

Future<UserModel?> getLinesOrBinaryFileData(
  File idsFile,
  File userFile,
  int id, {
  bool isBinary = false,
}) async {
  final fileData = await userFile.readAsLines();
  if (fileData.isEmpty) return null;
  final idsData = await idsFile.readAsLines();
  bool idExist = false;
  for (int j = 0; j < idsData.length; j++) {
    if (int.parse(idsData[j]) == id) {
      idExist = true;
    }
  }

  if (!idExist) {
    return null;
  }
  for (int i = 0; i < fileData.length; i = i + 6) {
    print(
      '${fileData[0 + i]}, ${fileData[1 + i]}, ${fileData[2 + i]}, ${fileData[3 + i]}, ${fileData[4 + i]}',
    );
    if (int.parse(fileData[0 + i]) == id) {
      return !isBinary
          ? UserModel(
              id: int.parse(fileData[0 + i]),
              firstName: fileData[1 + i],
              lastName: fileData[2 + i],
              dobYear: int.parse(fileData[3 + i]),
              country: fileData[4 + i],
            )
          : UserModel(
              id: int.parse(fileData[0 + i], radix: 2),
              firstName: convertBinaryToString(fileData[1 + i]),
              lastName: convertBinaryToString(fileData[2 + i]),
              dobYear: int.parse(fileData[3 + i], radix: 2),
              country: convertBinaryToString(fileData[4 + i]),
            );
    }
  }
  return null;
}

Future<bool> updateLinesOrBinaryFileData(
  File idsFile,
  File userFile,
  int id,
  UserModel updatedData, {
  bool isBinary = false,
}) async {
  final fileData = await userFile.readAsLines();
  if (fileData.isEmpty) return false;
  final idsData = await idsFile.readAsLines();
  bool idExist = false;
  for (int j = 0; j < idsData.length; j++) {
    if (int.parse(idsData[j]) == id) {
      idExist = true;
    }
  }

  if (!idExist) {
    return false;
  }

  await userFile.writeAsString('');

  for (int i = 0; i < fileData.length; i = i + 6) {
    if ((!isBinary
            ? int.parse(fileData[0 + i])
            : int.parse(fileData[0 + i], radix: 2)) ==
        id) {
      fileData[1 + i] = !isBinary
          ? updatedData.firstName
          : convertStringToBinary(updatedData.firstName);
      fileData[2 + i] = !isBinary
          ? updatedData.lastName
          : convertStringToBinary(updatedData.lastName);
      fileData[3 + i] = !isBinary
          ? updatedData.dobYear.toString()
          : convertIntToBinary(updatedData.dobYear);
      fileData[4 + i] = !isBinary
          ? updatedData.country
          : convertStringToBinary(updatedData.country);
    }
    await userFile.writeAsString(
      '${fileData[0 + i]}\n${fileData[1 + i]}\n${fileData[2 + i]}\n${fileData[3 + i]}\n${fileData[4 + i]}\n\n',
      mode: FileMode.append,
    );
  }
  return true;
}
