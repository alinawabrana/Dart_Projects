// import 'dart:io';
// import 'package:path/path.dart' as p;

// void main(List<String> arguments) {
//   if (arguments.isEmpty) {
//     print(
//       'Argument is empty!!!. Therefore no directories and files are created',
//     );
//   } else {
//     if (arguments.first == '-f') {
//       if (arguments.length == 1) {
//         print('No feature name is defined');
//       } else {
//         final currentDir = Directory.current;
//         // print('current dir = ${currentDir.path}');

//         // print('feature name ${arguments[1]}');

//         final featureDirectory = Directory(
//           '${currentDir.path}${Platform.pathSeparator}bin${Platform.pathSeparator}src${Platform.pathSeparator}features${Platform.pathSeparator}${arguments[1]}',
//         );

//         if (featureDirectory.existsSync()) {
//           print('This feature is already available!!!');
//           return;
//         }

//         final List<String> featuesInternalDir = ['data', 'presentation'];
//         featuesInternalDir.forEach(
//           (dir) => createDirectoryFilesIfNotExist(
//             Directory('${featureDirectory.path}${Platform.pathSeparator}$dir'),
//           ),
//         );
//         final List<(String, List<String>)> files = [
//           ('data', ['api.dart', 'repository.dart', 'controllers.dart']),
//           ('presentation', ['ui.dart', 'widget.dart']),
//         ];

//         files.forEach(
//           (data) => data.$2.forEach(
//             (file) => createDirectoryFilesIfNotExist(
//               File(
//                 '${featureDirectory.path}${Platform.pathSeparator}${data.$1}${Platform.pathSeparator}$file',
//               ),
//             ),
//           ),
//         );

//         /// Inserting data in files

//         final data = Directory(
//           '${featureDirectory.path}${Platform.pathSeparator}data',
//         );
//         final presentation = Directory(
//           '${featureDirectory.path}${Platform.pathSeparator}presentation',
//         );

//         files.forEach(
//           (data) => data.$2.forEach((file) {
//             String fileName = p.basenameWithoutExtension(file);
//             fileName = fileName[0].toUpperCase() + fileName.substring(1);
//             File(
//               '${featureDirectory.path}${Platform.pathSeparator}${data.$1}${Platform.pathSeparator}$file',
//             ).writeAsStringSync('''
// class $fileName {
//  String a;
//  String b;

//  $fileName({required this.a, required this.b});
// } ''');
//           }),
//         );

//         // final featureDir = Directory(
//         //   '${currentDir.path}${Platform.pathSeparator}bin${Platform.pathSeparator}src${Platform.pathSeparator}features${Platform.pathSeparator}${arguments[1]}',
//         // );

//         // createDirectoryFilesIfNotExist(featureDir);

//         // final featureData = Directory(
//         //   '${featureDir.path}${Platform.pathSeparator}data',
//         // );
//         // createDirectoryFilesIfNotExist(featureData);
//         // final featurePresentation = Directory(
//         //   '${featureDir.path}${Platform.pathSeparator}presentation',
//         // );
//         // createDirectoryFilesIfNotExist(featurePresentation);

//         //     final apiFile = File(
//         //       '${featureData.path}${Platform.pathSeparator}api.dart',
//         //     );

//         //     createDirectoryIfNotExist(apiFile);
//       }
//     }
//   }
// }

// void createDirectoryFilesIfNotExist(var path) {
//   if (!path.existsSync()) {
//     path.createSync(recursive: true);
//   }
// }

import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print(
      'Argument is empty!!!. Therefore no directories and files are created',
    );
  } else {
    if (arguments.first == '-f') {
      if (arguments.length == 1) {
        print('No feature name is defined');
      } else {
        final currentDir = Directory.current;

        final featureDirectory = Directory(
          '${currentDir.path}${Platform.pathSeparator}bin${Platform.pathSeparator}src${Platform.pathSeparator}features${Platform.pathSeparator}${arguments[1]}',
        );

        if (featureDirectory.existsSync()) {
          print('This feature is already available!!!');
          providedPathFolderStructCreation(arguments, featureDirectory.path);
          return;
        } else {
          featureDirectory.createSync(recursive: true);

          if (arguments.length > 2) {
            providedPathFolderStructCreation(arguments, featureDirectory.path);
          } else {
            final dataDirectory = Directory(
              '${featureDirectory.path}${Platform.pathSeparator}data',
            );
            final presentationDirectory = Directory(
              '${featureDirectory.path}${Platform.pathSeparator}presentation',
            );

            // Creating the Data and Presentation director inside the feature directory.

            await Future.wait([
              createDirectoryFilesIfNotExist(dataDirectory),
              createDirectoryFilesIfNotExist(presentationDirectory),
            ]);

            // Creating files and their content of both data and presentation directories./

            await Future.wait([
              createAndInsertDataIntoFile(
                File('${dataDirectory.path}${Platform.pathSeparator}api.dart'),
              ),
              createAndInsertDataIntoFile(
                File(
                  '${dataDirectory.path}${Platform.pathSeparator}repository.dart',
                ),
              ),
              createAndInsertDataIntoFile(
                File(
                  '${dataDirectory.path}${Platform.pathSeparator}controllers.dart',
                ),
              ),
              createAndInsertDataIntoFile(
                File(
                  '${presentationDirectory.path}${Platform.pathSeparator}ui.dart',
                ),
              ),
              createAndInsertDataIntoFile(
                File(
                  '${presentationDirectory.path}${Platform.pathSeparator}widget.dart',
                ),
              ),
            ]);
          }
        }
      }
    }
  }
}

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
  String featureDirectory,
) async {
  if (arguments.length == 2) return;
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
  print(arguments[3].toString());
  final providedPath = Directory(arguments[3]);
  if (!providedPath.existsSync()) {
    print('Provided Path Does not exist');
    return;
  }
  final base = Directory(p.basename(providedPath.path));
  print(base);
  print(featureDirectory);
  final baseDirectory = Directory(
    '$featureDirectory${Platform.pathSeparator}${base.path}',
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
