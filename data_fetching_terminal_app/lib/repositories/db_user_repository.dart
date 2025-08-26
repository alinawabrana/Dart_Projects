import 'package:data_fetching_terminal_app/database/user_database.dart';
import 'package:data_fetching_terminal_app/interfaces/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/mappers/user_mapper.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:drift/drift.dart';

class DbUserRepository implements UserRepository {
  final db = UserDatabase();
  @override
  Future<bool> createUser(UserModel user) async {
    try {
      final newUser = UserTableCompanion.insert(
        firstName: user.firstName,
        lastName: user.lastName,
        yearOfBirth: user.dobYear,
        country: user.country,
      );

      await db.into(db.userTable).insert(newUser);

      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteAllUser() async {
    try {
      await db.delete(db.userTable).go();
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    try {
      await (db.delete(db.userTable)..where((user) => user.id.equals(id))).go();
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      final data = await db.select(db.userTable).get();
      if (data.isEmpty) return [];
      final allUsers = data.map((d) => d.toUserModel()).toList();
      return allUsers;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    try {
      final data = await (db.select(
        db.userTable,
      )..where((user) => user.id.equals(id))).getSingleOrNull();
      if (data == null) return null;
      final currentUser = data.toUserModel();
      return currentUser;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<bool> updateUser(int id, UserModel updatedData) async {
    try {
      final updatedUser = UserTableCompanion(
        firstName: Value(updatedData.firstName),
        lastName: Value(updatedData.lastName),
        yearOfBirth: Value(updatedData.dobYear),
        country: Value(updatedData.country),
      );

      await db.update(db.userTable).write(updatedUser);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
