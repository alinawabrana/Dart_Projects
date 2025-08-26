import 'dart:io';

import 'package:data_fetching_terminal_app/database/user_database.dart';
import 'package:data_fetching_terminal_app/exceptions/exceptions.dart';
import 'package:data_fetching_terminal_app/helper_functions/helpers.dart';
import 'package:data_fetching_terminal_app/models/user_model.dart';
import 'package:data_fetching_terminal_app/repositories/db_user_repository.dart';
import 'package:data_fetching_terminal_app/repositories/file_user_repository.dart';
import 'package:data_fetching_terminal_app/validators/validators.dart';

void fetchUserData(List<String> arguments) async {
  late DbUserRepository dbUserRepo;
  try {
    late File userFileDirectory;
    late File idsFileDirectory;
    String fileEncoder = 'lines';
    late LinesFileUserRepository userFileRepo;
    late JsonFileUserRepository userJsonFileRepo;
    // ServerUserRepository serverUserRepository = ServerUserRepository(
    //   baseUrl: '',
    // );

    if (arguments[0] == '-d') dbUserRepo = DbUserRepository(db: UserDatabase());

    if ((arguments[1] == '--find' ||
            arguments[1] == '--del' ||
            arguments[1] == '--up') &&
        (arguments.length == 2 || !validateId.hasMatch(arguments[2]))) {
      throw NoIdException(
        'You have either not provided the ID or the provided argument[2] is Invalid.',
      );
    }

    if (arguments[0] == '-f') {
      if ((arguments[1] == '--find' ||
          arguments[1] == '--del' ||
          arguments[1] == '-u')) {
        if (arguments.length >= 4) {
          validatingEncoderArguments(arguments, 3);
          fileEncoder = arguments[4];
        }
      } else if (arguments[1] == '--list' || arguments[1] == '--del-all') {
        if (arguments.length >= 3) {
          validatingEncoderArguments(arguments, 2);
          fileEncoder = arguments[3];
        }
      } else if (arguments[1] == '--up') {
        if (arguments.length >= 5) {
          validatingEncoderArguments(arguments, 4);
          fileEncoder = arguments[5];
        }
      }

      userFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}${fileEncoder == 'json' ? 'json${Platform.pathSeparator}user_file.json' : 'lines${Platform.pathSeparator}user_file.txt'}',
      );
      idsFileDirectory = File(
        '${Directory.current.path}${Platform.pathSeparator}lines${Platform.pathSeparator}id_file.txt',
      );

      if (!userFileDirectory.existsSync()) {
        userFileDirectory.createSync(recursive: true);
      }
      if (fileEncoder == 'lines' && !idsFileDirectory.existsSync()) {
        idsFileDirectory.createSync(recursive: true);
      }

      if (fileEncoder == 'json') {
        userJsonFileRepo = JsonFileUserRepository(userFile: userFileDirectory);
      } else {
        userFileRepo = LinesFileUserRepository(
          userFile: userFileDirectory,
          idsFile: idsFileDirectory,
        );
      }
    }
    if (arguments[1] == '-u') {
      if (arguments.length == 2) {
        throw UserInputException(
          "You haven't entered the user information to be added. The format should be as follow:\nfirstName,lastName,Year of Birth(INTEGER),Country",
        );
      } else if (arguments[2].split(',').length != 4 ||
          !validateUser.hasMatch(arguments[2])) {
        throw UserFormatException(
          "The format for user information is not valid. It should be as follow and each field is mandatory:\nfirstName,lastName,Year of Birth,Country",
        );
      }

      final data = arguments[2].split(',');

      final user = UserModel(
        firstName: data[0],
        lastName: data[1],
        dobYear: int.parse(data[2]),
        country: data[3],
      );

      print('User = ${user.toJson()}');

      final isUserCreated = arguments[0] == '-f'
          ? fileEncoder == 'json'
                ? await userJsonFileRepo.createUser(user)
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
                : await userFileRepo.getUserByID(userID)
          : await dbUserRepo.getUserByID(userID);

      if (user == null) {
        throw NoUserException('No User with id: $userID is Found');
      }

      print('User = $user');
    } else if (arguments[1] == '--up') {
      if (arguments.length == 3) {
        throw UpdatedUserInputException(
          'You have not provided the updated data.\nPlease provide the updated user data in the format: firstName,lastName,Year of Birth,Country',
        );
      } else if (arguments[3].split(',').length != 4 ||
          !validateUser.hasMatch(arguments[3])) {
        throw InvalidInputException(
          "The format for user information is not valid. It should be as follow and each field is mandatory:\nfirstName,lastName,Year of Birth,Country",
        );
      }

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
    dbUserRepo.db.close();
    exit(-1);
  }
}
