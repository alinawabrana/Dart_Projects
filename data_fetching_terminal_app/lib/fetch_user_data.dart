import 'dart:io';

import 'package:data_fetching_terminal_app/database/user_database.dart';
import 'package:data_fetching_terminal_app/utils/enums/enums.dart';
import 'package:data_fetching_terminal_app/utils/exceptions/exceptions.dart';
import 'package:data_fetching_terminal_app/utils/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:data_fetching_terminal_app/repositories/db_user_repository.dart';
import 'package:data_fetching_terminal_app/repositories/file_user_repository.dart';

void fetchUserData(List<String> arguments, String? fileEncoder) async {
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

    if (arguments[0] == Services.database.identifier) {
      dbUserRepo = DbUserRepository(db: UserDatabase());
    } else if (arguments[0] == Services.file.identifier) {
      userFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}${fileEncoder == Encoders.json.identifier
            ? 'json${Platform.pathSeparator}user_file.json'
            : fileEncoder == Encoders.binary.identifier
            ? 'binary${Platform.pathSeparator}user_file_binary.txt'
            : 'lines${Platform.pathSeparator}user_file.txt'}',
      );
      idsFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}${fileEncoder == Encoders.binary.identifier ? 'binary${Platform.pathSeparator}id_file_binary.txt' : 'lines${Platform.pathSeparator}id_file.txt'}',
      );

      if (!userFileDirectory.existsSync()) {
        userFileDirectory.createSync(recursive: true);
      }
      if ([
            Encoders.binary.identifier,
            Encoders.lines.identifier,
          ].contains(fileEncoder) &&
          !idsFileDirectory.existsSync()) {
        idsFileDirectory.createSync(recursive: true);
      }

      if (fileEncoder == Encoders.json.identifier) {
        userJsonFileRepo = JsonFileUserRepository(userFile: userFileDirectory);
      } else if (fileEncoder == Encoders.binary.identifier) {
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
    if (arguments[1] == Operations.create.identifier) {
      final data = arguments[2].split(',');

      final user = UserModel(
        firstName: data[0],
        lastName: data[1],
        dobYear: int.parse(data[2]),
        country: data[3],
      );

      final isUserCreated = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.createUser(user)
                : fileEncoder == Encoders.binary.identifier
                ? await userBinaryFileRepo.createUser(user)
                : await userFileRepo.createUser(user)
          : await dbUserRepo.createUser(user);

      if (!isUserCreated) {
        print('Failed to create the User');
        return;
      }
      print('User Created Successfully');
    } else if (arguments[1] == Operations.getAll.identifier) {
      final allUsers = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.getAllUser()
                : fileEncoder == Encoders.binary.identifier
                ? await userBinaryFileRepo.getAllUser()
                : await userFileRepo.getAllUser()
          : await dbUserRepo.getAllUser();

      if (allUsers.isEmpty) {
        print('No User is Found');
        return;
      }

      print('All Users = $allUsers');
    } else if (arguments[1] == Operations.getUserbyId.identifier) {
      final userID = isValidint(arguments[2]);

      final user = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.getUserByID(userID)
                : fileEncoder == Encoders.binary.identifier
                ? await userBinaryFileRepo.getUserByID(userID)
                : await userFileRepo.getUserByID(userID)
          : await dbUserRepo.getUserByID(userID);

      if (user == null) {
        throw NoUserException('No User with id: $userID is Found');
      }

      print('User = $user');
    } else if (arguments[1] == Operations.update.identifier) {
      final data = arguments[3].split(',');

      final user = UserModel(
        firstName: data[0],
        lastName: data[1],
        dobYear: int.parse(data[2]),
        country: data[3],
      );

      final userID = isValidint(arguments[2]);

      final isUpdated = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.updateUser(userID, user)
                : fileEncoder == Encoders.binary.identifier
                ? await userBinaryFileRepo.updateUser(userID, user)
                : await userFileRepo.updateUser(userID, user)
          : await dbUserRepo.updateUser(userID, user);

      if (!isUpdated) {
        throw NoUserException(
          'Failed to update the User. No User with id: $userID is Found.',
        );
      }
      print('User Updated Successfully');
    } else if (arguments[1] == Operations.deleteUserById.identifier) {
      final userID = isValidint(arguments[2]);

      final isDeleted = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.deleteUser(userID)
                : fileEncoder == Encoders.binary.identifier
                ? await userBinaryFileRepo.deleteUser(userID)
                : await userFileRepo.deleteUser(userID)
          : await dbUserRepo.deleteUser(userID);

      if (!isDeleted) {
        throw NoUserException(
          'Failed to delete the User. No User with id: $userID is Found.',
        );
      }
      print('User Deleted Successfully');
    } else if (arguments[1] == Operations.deleteAll.identifier) {
      final isAllDeleted = arguments[0] == Services.file.identifier
          ? fileEncoder == Encoders.json.identifier
                ? await userJsonFileRepo.deleteAllUser()
                : fileEncoder == Encoders.binary.identifier
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
    if (arguments[0] == Services.database.identifier) dbUserRepo.db.close();
    exit(-1);
  }
}
