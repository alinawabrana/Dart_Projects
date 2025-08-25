import 'package:data_fetching_terminal_app/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'dart:io';

class FileUserRepository implements UserRepository {
  final File userFile;
  final File idsFile;

  FileUserRepository({required this.userFile, required this.idsFile});
  @override
  Future<bool> createUser(UserModel user) async {
    final ids = await idsFile.readAsLines();
    final lines = await userFile.readAsLines();
    if (lines.isEmpty) {
      await idsFile.writeAsString('1\n');
      userFile.writeAsStringSync(
        '1\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
        mode: FileMode.append,
      );
    } else {
      int lastId = int.parse(ids.last);
      lastId = lastId + 1;
      print('last ID = $lastId');
      await idsFile.writeAsString(
        '${lastId.toString()}\n',
        mode: FileMode.append,
      );
      userFile.writeAsStringSync(
        '$lastId\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
        mode: FileMode.append,
      );
    }
    return true;
  }

  @override
  Future<bool> deleteAllUser() async {
    await userFile.writeAsString('');
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
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
    await userFile.writeAsString('');
    for (int i = 0; i < fileData.length; i = i + 6) {
      if (int.parse(fileData[0 + i]) != id) {
        await userFile.writeAsString(
          '${fileData[0 + i]}\n${fileData[1 + i]}\n${fileData[2 + i]}\n${fileData[3 + i]}\n${fileData[4 + i]}\n\n',
          mode: FileMode.append,
        );
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

  @override
  Future<List<UserModel>> getAllUser() async {
    final fileData = await userFile.readAsLines();
    if (fileData.isEmpty) return [];
    print('File Data length = ${fileData.length}');
    List<UserModel> allUsers = [];
    if (fileData.isEmpty) return allUsers;
    for (int i = 0; i < fileData.length; i = i + 6) {
      print(
        '${fileData[0 + i]}, ${fileData[1 + i]}, ${fileData[2 + i]}, ${fileData[3 + i]}, ${fileData[4 + i]}',
      );
      allUsers.add(
        UserModel(
          id: int.parse(fileData[0 + i]),
          firstName: fileData[1 + i],
          lastName: fileData[2 + i],
          dobYear: int.parse(fileData[3 + i]),
          country: fileData[4 + i],
        ),
      );
    }
    return allUsers;
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
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
      if (int.parse(fileData[0 + i]) == id) {
        return UserModel(
          id: int.parse(fileData[0 + i]),
          firstName: fileData[1 + i],
          lastName: fileData[2 + i],
          dobYear: int.parse(fileData[3 + i]),
          country: fileData[4 + i],
        );
      }
    }
    return null;
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
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
      if (int.parse(fileData[0 + i]) == id) {
        fileData[1 + i] = updatedData.firstName;
        fileData[2 + i] = updatedData.lastName;
        fileData[3 + i] = updatedData.dobYear.toString();
        fileData[4 + i] = updatedData.country;
      }
      await userFile.writeAsString(
        '${fileData[0 + i]}\n${fileData[1 + i]}\n${fileData[2 + i]}\n${fileData[3 + i]}\n${fileData[4 + i]}\n\n',
        mode: FileMode.append,
      );
    }
    return true;
  }
}
