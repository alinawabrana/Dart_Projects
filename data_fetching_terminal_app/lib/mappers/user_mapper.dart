import 'package:data_fetching_terminal_app/models/user_model.dart';

import '../database/user_database.dart';

extension UserMapper on UserTableData {
  UserModel toUserModel() => UserModel(
    id: id,
    firstName: firstName,
    lastName: lastName,
    dobYear: yearOfBirth,
    country: country,
  );
}
