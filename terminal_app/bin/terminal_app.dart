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
import 'package:terminal_app/utils/helpers.dart';

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
          providedPathFolderStructCreation(arguments, featureDirectory);
          return;
        } else {
          if (arguments.length > 2) {
            providedPathFolderStructCreation(arguments, featureDirectory);
          } else {
            featureDirectory.createSync(recursive: true);
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
