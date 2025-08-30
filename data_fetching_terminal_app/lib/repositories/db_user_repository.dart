import 'package:data_fetching_terminal_app/database/user_database.dart';
import 'package:data_fetching_terminal_app/interfaces/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/utils/mappers/user_mapper.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:drift/drift.dart';

class DbUserRepository implements UserRepository {
  final UserDatabase db;

  DbUserRepository({required this.db});

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

      db.close();
      return true;
    } catch (e) {
      print('Error: $e');
      db.close();
      return false;
    }
  }

  @override
  Future<bool> deleteAllUser() async {
    try {
      await db.delete(db.userTable).go();
      db.close();
      return true;
    } catch (e) {
      print('Error: $e');
      db.close();
      return false;
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    try {
      await (db.delete(db.userTable)..where((user) => user.id.equals(id))).go();
      db.close();
      return true;
    } catch (e) {
      print('Error: $e');
      db.close();
      return false;
    }
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      final data = await db.select(db.userTable).get();
      if (data.isEmpty) {
        db.close();
        return [];
      }
      final allUsers = data.map((d) => d.toUserModel()).toList();
      db.close();
      return allUsers;
    } catch (e) {
      print('Error: $e');
      db.close();
      return [];
    }
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    try {
      final data = await (db.select(
        db.userTable,
      )..where((user) => user.id.equals(id))).getSingleOrNull();
      if (data == null) {
        db.close();
        return null;
      }
      final currentUser = data.toUserModel();
      db.close();
      return currentUser;
    } catch (e) {
      print('Error: $e');
      db.close();
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
      db.close();
      return true;
    } catch (e) {
      print('Error: $e');
      db.close();
      return false;
    }
  }
}
