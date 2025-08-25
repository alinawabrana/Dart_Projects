import 'dart:convert';

import 'package:data_fetching_terminal_app/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/interfaces/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'dart:io';

class FileUserRepository implements UserRepository {
  final File userFile;
  final File idsFile;
  final String fileEncoder;

  FileUserRepository({
    required this.userFile,
    required this.idsFile,
    required this.fileEncoder,
  });
  @override
  Future<bool> createUser(UserModel user) async {
    if (fileEncoder == 'json') {
      List<dynamic> userData = [];
      String jsonFileContent = await userFile.readAsString();
      if (jsonFileContent.isNotEmpty) {
        userData = jsonDecode(jsonFileContent);
      }

      final userWithID = user.copyWith(
        id: userData.isEmpty ? 1 : (userData.last['id'] + 1),
      );

      userData.add(userWithID.toJson());

      await writeJsonToFile(userFile, userData);
      return true;
    } else {
      final (ids, lines) = await Future.wait([
        idsFile.readAsLines(),
        userFile.readAsLines(),
      ]).then((lists) => (lists[0], lists[1]));
      if (lines.isEmpty) {
        final userWithId = user.copyWith(id: 1);
        await Future.wait([
          idsFile.writeAsString('1\n', mode: FileMode.append),
          userFile.writeAsString(
            '${userWithId.id}\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
            mode: FileMode.append,
          ),
        ]);
      } else {
        int lastId = int.parse(ids.last);
        lastId = lastId + 1;
        print('last ID = $lastId');
        final userWithId = user.copyWith(id: lastId);
        await Future.wait([
          idsFile.writeAsString(
            '${lastId.toString()}\n',
            mode: FileMode.append,
          ),
          userFile.writeAsString(
            '${userWithId.id}\n${user.firstName}\n${user.lastName}\n${user.dobYear.toString()}\n${user.country}\n\n',
            mode: FileMode.append,
          ),
        ]);
      }
      return true;
    }
  }

  @override
  Future<bool> deleteAllUser() async {
    await userFile.writeAsString('');
    if (fileEncoder != 'json') await idsFile.writeAsString('');
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    if (fileEncoder == 'json') {
      List<dynamic> userData = [];
      String jsonFileData = await userFile.readAsString();
      if (jsonFileData.isEmpty) return false;
      userData = jsonDecode(jsonFileData);

      if (userData.indexWhere((data) => data['id'] == id) == -1) return false;

      userData.removeWhere((data) => data['id'] == id);

      await writeJsonToFile(userFile, userData);
      return true;
    } else {
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
      await Future.wait([
        idsFile.writeAsString(''),
        userFile.writeAsString(''),
      ]);
      for (int i = 0; i < fileData.length; i = i + 6) {
        if (int.parse(fileData[0 + i]) != id) {
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
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    if (fileEncoder == 'json') {
      List<dynamic> userData = [];
      String jsonFileData = await userFile.readAsString();
      if (jsonFileData.isEmpty) return [];
      userData = jsonDecode(jsonFileData);
      final allUsers = userData
          .map((data) => UserModel.fromJson(data))
          .toList();
      return allUsers;
    } else {
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
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    if (fileEncoder == 'json') {
      List<dynamic> userData = [];
      String jsonFileData = await userFile.readAsString();
      if (jsonFileData.isEmpty) return null;
      userData = jsonDecode(jsonFileData);
      if (userData.indexWhere((data) => data['id'] == id) == -1) return null;
      final currentUser = userData.firstWhere(
        (data) => data['id'] == id,
        orElse: () => null,
      );
      if (currentUser == null) return null;
      return UserModel.fromJson(currentUser);
    } else {
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
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
    if (fileEncoder == 'json') {
      List<dynamic> userData = [];
      String jsonFileData = await userFile.readAsString();
      if (jsonFileData.isEmpty) return false;
      userData = jsonDecode(jsonFileData);

      int index = userData.indexWhere((data) => data['id'] == id);

      if (index == -1) {
        return false;
      }

      final updatedUserWithID = updatedData.copyWith(id: id);
      userData[index] = updatedUserWithID;
      await writeJsonToFile(userFile, userData);
      return true;
    } else {
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
}
