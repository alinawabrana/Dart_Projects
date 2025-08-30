import 'dart:io';

import 'package:data_fetching_terminal_app/database/user_database.dart';
import 'package:data_fetching_terminal_app/exceptions/exceptions.dart';
import 'package:data_fetching_terminal_app/utils/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:data_fetching_terminal_app/repositories/db_user_repository.dart';
import 'package:data_fetching_terminal_app/repositories/file_user_repository.dart';

void fetchUserData(
  List<String> arguments, {
  String fileEncoder = 'lines',
}) async {
  late DbUserRepository dbUserRepo;
  try {
    late File userFileDirectory;
    late File idsFileDirectory;
    late LinesFileUserRepository userFileRepo;
    late JsonFileUserRepository userJsonFileRepo;
    late BinaryFileUserRepository userBinaryFileRepo;
    // ServerUserRepository serverUserRepository = ServerUserRepository(
    //   baseUrl: '',
    // );

    if (arguments[0] == '-d') dbUserRepo = DbUserRepository(db: UserDatabase());

    if (arguments[0] == '-f') {
      userFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}${fileEncoder == 'json'
            ? 'json${Platform.pathSeparator}user_file.json'
            : fileEncoder == 'binary'
            ? 'binary${Platform.pathSeparator}user_file_binary.txt'
            : 'lines${Platform.pathSeparator}user_file.txt'}',
      );
      idsFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}${fileEncoder == 'binary' ? 'binary${Platform.pathSeparator}id_file_binary.txt' : 'lines${Platform.pathSeparator}id_file.txt'}',
      );

      if (!userFileDirectory.existsSync()) {
        userFileDirectory.createSync(recursive: true);
      }
      if ((fileEncoder == 'lines' || fileEncoder == 'binary') &&
          !idsFileDirectory.existsSync()) {
        idsFileDirectory.createSync(recursive: true);
      }

      if (fileEncoder == 'json') {
        userJsonFileRepo = JsonFileUserRepository(userFile: userFileDirectory);
      } else if (fileEncoder == 'binary') {
        userBinaryFileRepo = BinaryFileUserRepository(
          userFile: userFileDirectory,
          idsFile: idsFileDirectory,
        );
      } else {
        userFileRepo = LinesFileUserRepository(
          userFile: userFileDirectory,
          idsFile: idsFileDirectory,
        );
      }
    }
    if (arguments[1] == '-u') {
      final data = arguments[2].split(',');

      final user = UserModel(
        firstName: data[0],
        lastName: data[1],
        dobYear: int.parse(data[2]),
        country: data[3],
      );

      final isUserCreated = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.createUser(user)
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.createUser(user)
                : await userFileRepo.createUser(user)
          : await dbUserRepo.createUser(user);

      if (!isUserCreated) {
        print('Failed to create the User');
        return;
      }
      print('User Created Successfully');
    } else if (arguments[1] == '--list') {
      final allUsers = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.getAllUser()
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.getAllUser()
                : await userFileRepo.getAllUser()
          : await dbUserRepo.getAllUser();

      if (allUsers.isEmpty) {
        print('No User is Found');
        return;
      }

      print('All Users = $allUsers');
    } else if (arguments[1] == '--find') {
      final userID = isValidint(arguments[2]);

      final user = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.getUserByID(userID)
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.getUserByID(userID)
                : await userFileRepo.getUserByID(userID)
          : await dbUserRepo.getUserByID(userID);

      if (user == null) {
        throw NoUserException('No User with id: $userID is Found');
      }

      print('User = $user');
    } else if (arguments[1] == '--up') {
      final data = arguments[3].split(',');

      final user = UserModel(
        firstName: data[0],
        lastName: data[1],
        dobYear: int.parse(data[2]),
        country: data[3],
      );

      final userID = isValidint(arguments[2]);

      final isUpdated = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.updateUser(userID, user)
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.updateUser(userID, user)
                : await userFileRepo.updateUser(userID, user)
          : await dbUserRepo.updateUser(userID, user);

      if (!isUpdated) {
        throw NoUserException(
          'Failed to update the User. No User with id: $userID is Found.',
        );
      }
      print('User Updated Successfully');
    } else if (arguments[1] == '--del') {
      final userID = isValidint(arguments[2]);

      final isDeleted = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.deleteUser(userID)
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.deleteUser(userID)
                : await userFileRepo.deleteUser(userID)
          : await dbUserRepo.deleteUser(userID);

      if (!isDeleted) {
        throw NoUserException(
          'Failed to delete the User. No User with id: $userID is Found.',
        );
      }
      print('User Deleted Successfully');
    } else if (arguments[1] == '--del-all') {
      final isAllDeleted = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.deleteAllUser()
                : fileEncoder == 'binary'
                ? await userBinaryFileRepo.deleteAllUser()
                : await userFileRepo.deleteAllUser()
          : await dbUserRepo.deleteAllUser();

      if (!isAllDeleted) {
        print('Failed to delete all Users');
        return;
      }
      print('All Users Deleted Successfully');
    } else {
      throw InvalidOperationException(
        'You have entered invalid operation. Please try one of the following:\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.',
      );
    }
  } on TerminalAppExceptions catch (e) {
    print(e.toString());
    if (arguments[0] == '-d') dbUserRepo.db.close();
    exit(-1);
  }
}
