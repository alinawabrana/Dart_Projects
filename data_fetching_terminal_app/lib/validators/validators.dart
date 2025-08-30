import 'package:data_fetching_terminal_app/utils/enums/enums.dart';
import 'package:data_fetching_terminal_app/utils/exceptions/exceptions.dart';

final validateUser = RegExp(r"^[a-zA-Z]+,[a-zA-Z]+,[0-9]{4},[a-zA-Z]+$");
final validateId = RegExp(r"^[0-9]+$");

void validatingEncoderArguments(
  List<String> arguments,
  int indexOfEncoderArgument,
) {
  if (arguments[indexOfEncoderArgument] != '-e') {
    throw InvalidInputException(
      'The provided argument[$indexOfEncoderArgument] is Invalid.\nYou can only provide -e as a argument[$indexOfEncoderArgument] which further requires an encoder name.\nEncoders can be:(1) lines (2) json (3) binary',
    );
  } else if (arguments.length == indexOfEncoderArgument + 1) {
    throw NoFileEncoderException(
      "You haven't provided the file encoder. Encoders can be:\n(1) lines (2) json (3) binary",
    );
  } else if (Encoders.fromIdentifier(arguments[indexOfEncoderArgument + 1]) ==
      null) {
    throw InvalidFileEncoderException(
      "Invlaid encoder is provided. Encoders can be:\n(1) lines (2) json (3) binary",
    );
  }
}
