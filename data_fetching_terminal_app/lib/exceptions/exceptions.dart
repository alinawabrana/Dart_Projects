abstract class TerminalAppExceptions implements Exception {
  final String message;

  const TerminalAppExceptions(this.message);

  @override
  String toString() {
    return '${runtimeType.toString()}: $message';
  }
}

class NoArgumentException extends TerminalAppExceptions {
  const NoArgumentException([super.message = 'No Argument Provided!!!']);
}

class InvalidInputException extends TerminalAppExceptions {
  const InvalidInputException([super.message = 'Invalid Argument provided!!!']);
  // [] isb used because the message in the parent class is optional
}

class InvalidServiceException extends TerminalAppExceptions {
  const InvalidServiceException([
    super.message = "Invalid Service provided!!!",
  ]);
}

class InvalidOperationException extends TerminalAppExceptions {
  const InvalidOperationException([
    super.message = 'Invalid Operation provided!!!',
  ]);
}

class NoOperationException extends TerminalAppExceptions {
  const NoOperationException([super.message = 'No Operation is provided!!!']);
}

class NoIdException extends TerminalAppExceptions {
  const NoIdException([super.message = 'No ID is Provided!!!']);
}

class UserInputException extends TerminalAppExceptions {
  const UserInputException([super.message = 'No user data is provided!!!!']);
}

class UpdatedUserInputException extends TerminalAppExceptions {
  const UpdatedUserInputException([
    super.message = 'No user updated data is provided!!!!',
  ]);
}

class UserFormatException extends TerminalAppExceptions {
  const UserFormatException([
    super.message = 'Invalid Format for user is provided!!!',
  ]);
}

class NoUserException extends TerminalAppExceptions {
  const NoUserException([super.message = 'No User Found!!!']);
}

class NoFileEncoderException extends TerminalAppExceptions {
  const NoFileEncoderException([super.message = 'No File Encoder provided!!!']);
}

class InvalidFileEncoderException extends TerminalAppExceptions {
  const InvalidFileEncoderException([
    super.message = 'Invalid File Encoder is provided!!!',
  ]);
}
