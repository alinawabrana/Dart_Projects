enum Services {
  file(identifier: '-f'),
  database(identifier: '-d');

  final String identifier;
  const Services({required this.identifier});

  static String? fromIdentifier(String input) {
    for (final Services(identifier: identity) in Services.values) {
      if (identity == input) return identity;
    }
    return null;
  }
}

enum Operations {
  create(identifier: '-u'),
  update(identifier: '--up'),
  getUserbyId(identifier: '--find'),
  getAll(identifier: '--list'),
  deleteUserById(identifier: '--del'),
  deleteAll(identifier: '--del-all');

  final String identifier;
  const Operations({required this.identifier});

  static String? fromIdentifier(String input) {
    for (final Operations(identifier: identity) in Operations.values) {
      if (identity == input) return identity;
    }
    return null;
  }
}

enum Encoders {
  lines(identifier: 'lines'),
  json(identifier: 'json'),
  binary(identifier: 'binary');

  final String identifier;
  const Encoders({required this.identifier});

  static String? fromIdentifier(String input) {
    for (final Encoders(identifier: identity) in Encoders.values) {
      if (identity == input) return identity;
    }
    return null;
  }
}
