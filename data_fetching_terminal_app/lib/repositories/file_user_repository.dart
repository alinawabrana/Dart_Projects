import 'dart:convert';

import 'package:data_fetching_terminal_app/utils/helper_functions/files_helpers.dart';
import 'package:data_fetching_terminal_app/utils/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/interfaces/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'dart:io';

class LinesFileUserRepository implements UserRepository {
  final File userFile;
  final File idsFile;

  LinesFileUserRepository({required this.userFile, required this.idsFile});
  @override
  Future<bool> createUser(UserModel user) async {
    return await createLinesOrBinaryFile(idsFile, userFile, user);
  }

  @override
  Future<bool> deleteAllUser() async {
    await userFile.writeAsString('');
    await idsFile.writeAsString('');
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    return await deleteLinesOrBinaryFileData(idsFile, userFile, id);
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    return await getAllLinesOrBinaryFileData(userFile);
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    return await getLinesOrBinaryFileData(idsFile, userFile, id);
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
    return await updateLinesOrBinaryFileData(
      idsFile,
      userFile,
      id,
      updatedData,
    );
  }
}

class JsonFileUserRepository implements UserRepository {
  final File userFile;

  JsonFileUserRepository({required this.userFile});
  @override
  Future<bool> createUser(UserModel user) async {
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
  }

  @override
  Future<bool> deleteAllUser() async {
    await userFile.writeAsString('');
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    List<dynamic> userData = [];
    String jsonFileData = await userFile.readAsString();
    if (jsonFileData.isEmpty) return false;
    userData = jsonDecode(jsonFileData);

    if (userData.indexWhere((data) => data['id'] == id) == -1) return false;

    userData.removeWhere((data) => data['id'] == id);

    await writeJsonToFile(userFile, userData);
    return true;
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    List<dynamic> userData = [];
    String jsonFileData = await userFile.readAsString();
    if (jsonFileData.isEmpty) return [];
    userData = jsonDecode(jsonFileData);
    final allUsers = userData.map((data) => UserModel.fromJson(data)).toList();
    return allUsers;
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
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
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
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
  }
}

class BinaryFileUserRepository implements UserRepository {
  final File userFile;
  final File idsFile;

  BinaryFileUserRepository({required this.userFile, required this.idsFile});
  @override
  Future<bool> createUser(UserModel user) async {
    return await createLinesOrBinaryFile(
      idsFile,
      userFile,
      user,
      isBinary: true,
    );
  }

  @override
  Future<bool> deleteAllUser() async {
    await userFile.writeAsString('');
    await idsFile.writeAsString('');
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    return await deleteLinesOrBinaryFileData(
      idsFile,
      userFile,
      id,
      isBinary: true,
    );
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    return await getAllLinesOrBinaryFileData(userFile, isBinary: true);
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    return await getLinesOrBinaryFileData(
      idsFile,
      userFile,
      id,
      isBinary: true,
    );
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
    return await updateLinesOrBinaryFileData(
      idsFile,
      userFile,
      id,
      updatedData,
      isBinary: true,
    );
  }
}
