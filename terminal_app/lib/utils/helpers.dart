import 'dart:io';
import 'package:path/path.dart' as p;

Future<void> createDirectoryFilesIfNotExist(var path) async {
  if (!path.existsSync()) {
    await path.create(recursive: true);
  }
}

Future<bool> checkDirectoryExistance(Directory directory) async {
  if (await directory.exists()) {
    return true;
  } else {
    return false;
  }
}

Future<void> createAndInsertDataIntoFile(File file) async {
  if (!file.existsSync()) {
    await file.create();
  }
  final fileName = file.path
      .split(Platform.pathSeparator)
      .firstWhere((string) => string.contains('.'))
      .split('.')[0];
  final className = fileName[0].toUpperCase() + fileName.substring(1);
  final template = await File('class_template.txt').readAsString();
  final content = template.replaceAll('{{CLASS_NAME}}', className);
  await file.writeAsString(content);
}

void providedPathFolderStructCreation(
  List<String> arguments,
  Directory featureDirectory,
) async {
  if (arguments[2] != 'p') return;
  if (arguments.length == 3) {
    print(
      'No Path is provided from where the folder structure is to be copied.',
    );
    return;
  }
  if (arguments.length > 4) {
    print('Your provided path is containing spaces. THEREFORE IT IS INVALID');
    return;
  }

  final providedPath = Directory(arguments[3]);
  if (!providedPath.existsSync()) {
    print('Provided Path Does not exist');
    return;
  }

  createDirectoryFilesIfNotExist(featureDirectory);

  final base = Directory(p.basename(providedPath.path));
  print(base);
  print(featureDirectory.path);
  final baseDirectory = Directory(
    '${featureDirectory.path}${Platform.pathSeparator}${base.path}',
  );
  print('base directory = $baseDirectory');
  createDirectoryFilesIfNotExist(baseDirectory);
  List<FileSystemEntity> listOfInsidePaths = [];
  await for (var entity in providedPath.list(
    recursive: true,
    followLinks: false,
  )) {
    if (entity.path.contains('.')) {
      listOfInsidePaths.add(
        File(p.relative(entity.path, from: providedPath.path)),
      );
    } else {
      listOfInsidePaths.add(
        Directory(p.relative(entity.path, from: providedPath.path)),
      );
    }
    // print(entity.path);
  }
  print('list = $listOfInsidePaths');

  final subDirectories = listOfInsidePaths
      .where((directory) => !directory.path.contains(Platform.pathSeparator))
      .toList();
  final subSubDirectories = listOfInsidePaths
      .where((directory) => directory.path.contains(Platform.pathSeparator))
      .toList();
  print('Sub directories = $subDirectories');
  print('Sub sub directories = $subSubDirectories');

  // await Future.wait(
  //   subDirectories.map((directory) async {
  //     if (directory.runtimeType.toString() == '_Directory') {
  //       print('Inside isDirectory');
  //       createDirectoryFilesIfNotExist(
  //         Directory(
  //           '${baseDirectory.path}${Platform.pathSeparator}${directory.path}',
  //         ),
  //       );
  //     } else if (directory.runtimeType.toString() == '_File') {
  //       print('Inside isFile');
  //       createDirectoryFilesIfNotExist(
  //         File(
  //           '${baseDirectory.path}${Platform.pathSeparator}${directory.path}',
  //         ),
  //       );
  //     }
  //   }),
  // );

  /// NOTE.........
  /// No difference in time of above using future.wait and below using for in loop bcz in Future.wait I am also iterating over the list using .map.

  for (final directory in listOfInsidePaths) {
    print(directory.runtimeType);
    if (directory.runtimeType.toString() == '_Directory') {
      print('Inside isDirectory');
      createDirectoryFilesIfNotExist(
        Directory(
          '${baseDirectory.path}${Platform.pathSeparator}${directory.path}',
        ),
      );
    } else if (directory.runtimeType.toString() == '_File') {
      print('Inside isFile');
      createDirectoryFilesIfNotExist(
        File('${baseDirectory.path}${Platform.pathSeparator}${directory.path}'),
      );
    }
  }
}
