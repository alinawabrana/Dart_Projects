import 'package:data_fetching_terminal_app/models/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getAllUser();
  Future<UserModel?> getUserByID(int id);
  Future<bool> updateUser(int id, UserModel updatedData);
  Future<bool> deleteUser(int id);
  Future<bool> deleteAllUser();
  Future<bool> createUser(UserModel user);
}
