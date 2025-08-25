// import 'package:data_fetching_terminal_app/data_fetching_terminal_app.dart' as data_fetching_terminal_app;

import 'dart:io';

import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:data_fetching_terminal_app/repositories/file_user_repository.dart';
import 'package:data_fetching_terminal_app/repositories/server_user_repository.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print(
      "No Argumnet is provided!!!Following arguments are required:\n1. Service: (1) -f: files (2) -s: server\n2. Operation: (1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID\n3. Relevant operation input i.e: Id or user data.",
    );
    return;
  } else if (arguments[0] != '-f' && arguments[0] != '-s') {
    print(
      'The provided service is not valid. Plese Provide one of the following:\n(1) -f: files (2) -s: server',
    );
    return;
  }

  if (arguments.length == 1) {
    print(
      "You haven't tell us What operation to perform.\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.",
    );
    return;
  }

  if ((arguments[1] == '--find' ||
          arguments[1] == '--del' ||
          arguments[1] == '--up') &&
      arguments.length == 2) {
    print("You haven't provided the ID of the user");
    return;
  }

  final validateUser = RegExp(r"^[a-zA-Z]+,[a-zA-Z]+,[0-9]{4},[a-zA-Z]+$");

  File userFileDirectory = File('');
  File idsFileDirectory = File('');
  FileUserRepository userFileRepo = FileUserRepository(
    userFile: userFileDirectory,
    idsFile: idsFileDirectory,
  );
  ServerUserRepository serverUserRepository = ServerUserRepository(baseUrl: '');

  if (arguments[0] == '-f') {
    userFileDirectory = File(
      '${Directory.current.path}${Platform.pathSeparator}user_file.txt',
    );
    idsFileDirectory = File(
      '${Directory.current.path}${Platform.pathSeparator}id_file.txt',
    );

    if (!userFileDirectory.existsSync()) {
      userFileDirectory.createSync();
    }
    if (!idsFileDirectory.existsSync()) {
      idsFileDirectory.createSync();
    }

    userFileRepo = FileUserRepository(
      userFile: userFileDirectory,
      idsFile: idsFileDirectory,
    );
  } else {
    serverUserRepository = ServerUserRepository(
      baseUrl: 'https://api.restful-api.dev/objects',
    );
  }
  if (arguments[1] == '-u') {
    if (arguments.length == 2) {
      print(
        "You haven't entered the user information to be added. The format should be as follow:\nfirstName,lastName,Year of Birth,Country",
      );
      return;
    } else if (arguments[2].split(',').length != 4 ||
        !validateUser.hasMatch(arguments[2])) {
      print(
        "The format for user information is not valid. It should be as follow and each field is mandatory:\nfirstName,lastName,Year of Birth,Country",
      );
      return;
    }

    final data = arguments[2].split(',');

    final user = UserModel(
      firstName: data[0],
      lastName: data[1],
      dobYear: int.parse(data[2]),
      country: data[3],
    );

    print('User = ${user.toString()}');

    final isUserCreated = arguments[0] == '-f'
        ? await userFileRepo.createUser(user)
        : await serverUserRepository.createUser(user);

    if (!isUserCreated) {
      print('Failed to create the User');
      return;
    }
    print('User Created Successfully');
  } else if (arguments[1] == '--list') {
    final allUsers = arguments[0] == '-f'
        ? await userFileRepo.getAllUser()
        : await serverUserRepository.getAllUser();

    if (allUsers.isEmpty) {
      print('No User is Found');
      return;
    }

    print('All Users = $allUsers');
  } else if (arguments[1] == '--find') {
    final userID = int.parse(arguments[2]);

    final user = arguments[0] == '-f'
        ? await userFileRepo.getUserByID(userID)
        : await serverUserRepository.getUserByID(userID);

    if (user == null) {
      print('No User with id: $userID is Found');
      return;
    }

    print('User = $user');
  } else if (arguments[1] == '--up') {
    if (arguments.length == 3) {
      print(
        'Please provide the updated user data in the format: firstName,lastName,Year of Birth,Country',
      );
      return;
    } else if (arguments[3].split(',').length != 4 ||
        !validateUser.hasMatch(arguments[3])) {
      print(
        "The format for user information is not valid. It should be as follow and each field is mandatory:\nfirstName,lastName,Year of Birth,Country",
      );
      return;
    }

    final data = arguments[3].split(',');

    final user = UserModel(
      firstName: data[0],
      lastName: data[1],
      dobYear: int.parse(data[2]),
      country: data[3],
    );

    final userID = int.parse(arguments[2]);

    final isUpdated = arguments[0] == '-f'
        ? await userFileRepo.updateUser(userID, user)
        : await serverUserRepository.updateUser(userID, user);

    if (!isUpdated) {
      print('Failed to update the User');
      return;
    }
    print('User Updated Successfully');
  } else if (arguments[1] == '--del') {
    final userID = int.parse(arguments[2]);

    final isDeleted = arguments[0] == '-f'
        ? await userFileRepo.deleteUser(userID)
        : await serverUserRepository.deleteUser(userID);

    if (!isDeleted) {
      print('Failed to delete the User');
      return;
    }
    print('User Deleted Successfully');
  } else if (arguments[1] == '--del-all') {
    final isAllDeleted = arguments[0] == '-f'
        ? await userFileRepo.deleteAllUser()
        : await serverUserRepository.deleteAllUser();

    if (!isAllDeleted) {
      print('Failed to delete all Users');
      return;
    }
    print('All Users Deleted Successfully');
  } else {
    print(
      'You have entered invalid operation. Please try one of the following:\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.',
    );
    return;
  }
}
