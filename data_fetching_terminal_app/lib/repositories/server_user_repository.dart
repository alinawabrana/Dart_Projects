// import 'package:chopper/chopper.dart';
// import 'package:data_fetching_terminal_app/data_repository_interface.dart';
// import 'package:data_fetching_terminal_app/models/user_model.dart';

// @ChopperApi(baseUrl: '/objects')
// abstract class UserService extends ChopperService implements UserRepository {
//   static UserService create([ChopperClient? client]) => _$UserService(client);

//   @override
//   @GET()
//   Future<List<UserModel>> getAllUser();
// }

import 'package:data_fetching_terminal_app/data_repository_interface.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerUserRepository implements UserRepository {
  final String baseUrl;

  ServerUserRepository({required this.baseUrl});
  @override
  Future<bool> createUser(UserModel user) async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: user.toJson(),
      );

      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteAllUser() async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        return false;
      } else {
        print(response.body);
        return true;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print('Failed to fetch data from the server!!!');
        return [];
      } else {
        final jsonMap = response.body;
        final jsonData = jsonDecode(jsonMap) as List;
        final allUsers = jsonData
            .map((json) => UserModel.fromJson(json))
            .toList();
        return allUsers;
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Future<UserModel?> getUserByID(int id) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print('Failed to fetch data from the server!!!');
        return null;
      } else {
        final jsonMap = response.body;
        final jsonData = jsonDecode(jsonMap);
        final user = UserModel.fromJson(jsonData);
        return user;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<bool> updateUser(int id, UserModel user) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: user.toJson(),
      );

      if (response.statusCode != 200) {
        return false;
      } else {
        print('Updated data: ${response.body}');
        return true;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
