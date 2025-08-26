import 'dart:io';

import 'package:data_fetching_terminal_app/exceptions/exceptions.dart';
import 'package:data_fetching_terminal_app/fetch_user_data.dart';

void main(List<String> arguments) {
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

    if (arguments.length == 1) {
      throw NoOperationException(
        "You haven't tell us What operation to perform.\n(1) -u: Create user. (2) --find: Find user by ID. (3) --list: List all users. (4) --del: Delete user by ID. (5) --del-all: Delete all users. (6) --up: Update user by ID.",
      );
    }

    fetchUserData(arguments);
  } on TerminalAppExceptions catch (e) {
    print(e.toString());
    exit(-1); // Exit with error.
  }
}
