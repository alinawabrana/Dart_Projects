import 'package:data_fetching_terminal_app/utils/enums/enums.dart';

extension IdentifiableEnum on Identifier {
  static String? fromIdentifier<T extends Identifier>(
    List<T> values,
    String input,
  ) {
    for (final T(identifier: identifier) in values) {
      if (identifier == input) return identifier;
    }
    return null;
  }
}
