import 'dart:io';

import 'package:data_fetching_terminal_app/exceptions/exceptions.dart';
import 'package:data_fetching_terminal_app/fetch_user_data.dart';
import 'package:data_fetching_terminal_app/validators/validators.dart';

class ArgParserController {
  final List<String> arguments;

  ArgParserController({required this.arguments});

  String fileEncoder = 'lines';

  void initController() {
    serviceArgValidator();
  }

  void serviceArgValidator() {
    try {
      if (arguments.isEmpty) {
        throw NoArgumentException(
          "No Argumnet is provided!!!Following arguments are required:\n1. Service: (1) -f: files (2) -s: server\n2. Operation: (1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID\n3. Relevant operation input i.e: Id or user data.",
        );
      } else if (arguments[0] != '-f' && arguments[0] != '-d') {
        throw InvalidServiceException(
          'The provided service is not valid. Please Provide one of the following:\n(1) -f: files (2) -d: database',
        );
      }

      operationArgValidator();
    } on TerminalAppExceptions catch (e) {
      print(e.toString());
      exit(-1);
    }
  }

  void operationArgValidator() {
    try {
      if (arguments.length == 1) {
        throw NoOperationException(
          "You haven't tell us What operation to perform.\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.",
        );
      } else if (![
        '--up',
        '-u',
        '--find',
        '--list',
        '--del',
        '--del-all',
      ].contains(arguments[1])) {
        throw InvalidOperationException(
          'You have entered invalid operation. Please try one of the following:\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.',
        );
      }
      dataArg1Validator();
    } on TerminalAppExceptions catch (e) {
      print(e.toString());
      exit(-1);
    }
  }

  void dataArg1Validator() {
    try {
      if ((arguments[1] == '--find' ||
              arguments[1] == '--del' ||
              arguments[1] == '--up') &&
          (arguments.length == 2 || !validateId.hasMatch(arguments[2]))) {
        throw NoIdException(
          'You have either not provided the ID or the provided argument[2] is Invalid.',
        );
      } else if (arguments[1] == '-u') {
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
      }
      if (arguments[0] == '-f') {
        if (arguments[1] == '--list' || arguments[1] == '--del-all') {
          if (arguments.length >= 3) {
            validatingEncoderArguments(arguments, 2);
            fileEncoder = arguments[3];
          }
        }
      }
      dataArg2Validator();
    } on TerminalAppExceptions catch (e) {
      print(e.toString());
      exit(-1);
    }
  }

  void dataArg2Validator() {
    try {
      if (arguments[1] == '--up') {
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
      }
      if (arguments[0] == '-f') {
        if ((arguments[1] == '--find' ||
            arguments[1] == '--del' ||
            arguments[1] == '-u')) {
          if (arguments.length >= 4) {
            validatingEncoderArguments(arguments, 3);
            fileEncoder = arguments[4];
          }
        }
      }
      dataArg3Validator();
    } on TerminalAppExceptions catch (e) {
      print(e.toString());
      exit(-1);
    }
  }

  void dataArg3Validator() {
    try {
      if (arguments[0] == '-f') {
        if (arguments[1] == '--up') {
          if (arguments.length >= 5) {
            validatingEncoderArguments(arguments, 4);
            fileEncoder = arguments[5];
          }
        }
      }
      fetchUserData(arguments, fileEncoder: fileEncoder);
    } on TerminalAppExceptions catch (e) {
      print(e.toString());
      exit(-1);
    }
  }
}
