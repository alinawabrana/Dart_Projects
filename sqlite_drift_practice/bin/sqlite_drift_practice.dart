import 'package:drift/drift.dart';
import 'package:sqlite_drift_practice/database/user_db.dart';

void main(List<String> arguments) async {
  final db = AppDatabase();
  try {
    //------------------------ INSERT COMMANDS ----------------------------------//

    // final todoData = TodoItemsCompanion.insert(
    //   title: 'todo: finish drift setup',
    //   content: 'We can now write queries and define our own tables.',
    // );

    // await db.into(db.todoItems).insert(todoData);

    // BY DEFAULT: The drift allows the tables to add the data in the column field which is referencing to some other field.
    // This happens because we have not turned on the PRAGMA foreign_keys = ON in our NativeDatabase.createInBackground method.
    // After turning this on, the insert method will return the error stating FOREIGN KEY constraint failed.

    // final albumData = AlbumsCompanion.insert(
    //   name: 'Ali Hammad Rana',
    //   artist: 4,
    // );

    // await db.into(db.albums).insert(albumData);

    //------------------------ DELETE COMMANDS ----------------------------------//

    // await db.delete(db.albums).go();

    // await db.todoItems.deleteWhere((item) => item.id.equals(4));

    //------------------------ UPDATE COMMANDS ----------------------------------//

    final updatedTodo = TodoItemsCompanion(
      title: Value('Ali Nawab Rana'),
      content: Value('This is the content related to ALi Nawab Rana'),
    );

    await (db.update(
      db.todoItems,
    )..where((item) => item.id.equals(3))).write(updatedTodo);

    //Only Updating the title of all the todos
    // final updatedTitleOfAll = TodoItemsCompanion.custom(
    //   title: Constant('This is the updated Title!!!'),
    // );

    // await db.update(db.todoItems).write(updatedTitleOfAll);

    //------------------------ SELECT COMMANDS ----------------------------------//

    final todo = await (db.select(
      db.todoItems,
    )..where((item) => item.id.equals(1))).get();

    final limitTodo = await (db.select(
      db.todoItems,
    )..limit(2, offset: 1)).get();

    final orderedTodo =
        await (db.select(db.todoItems)..orderBy([
              (item) => OrderingTerm(
                expression: item.createdAt,
                mode: OrderingMode.desc,
              ),
            ]))
            .get();

    final query = (db.select(db.todoItems)
      ..where((item) => item.content.length.isBiggerOrEqualValue(16)));

    final bigContents = await query.map((item) => item.content).get();

    final allTodoData = await db.select(db.todoItems).get();
    final allAlbumData = await db.select(db.albums).get();
    print('All todo data = ${allTodoData.toString()}');
    print('All Album data = ${allAlbumData.toString()}');
    print('Todo = $todo');
    print('Limited Todo = $limitTodo');
    print('Ordered Todo = $orderedTodo');
    print('Content having length greater than 16 = $bigContents');
    await db.close();
  } catch (e) {
    print('Error: $e');
    await db.close();
  }
}
