mixin Identifier {
  String get identifier;
}

enum Services with Identifier {
  file(identifier: '-f'),
  database(identifier: '-d');

  @override
  final String identifier;
  const Services({required this.identifier});
}

enum Operations with Identifier {
  create(identifier: '-u'),
  update(identifier: '--up'),
  getUserbyId(identifier: '--find'),
  getAll(identifier: '--list'),
  deleteUserById(identifier: '--del'),
  deleteAll(identifier: '--del-all');

  @override
  final String identifier;
  const Operations({required this.identifier});
}

enum Encoders with Identifier {
  lines(identifier: 'lines'),
  json(identifier: 'json'),
  binary(identifier: 'binary');

  @override
  final String identifier;
  const Encoders({required this.identifier});
}
