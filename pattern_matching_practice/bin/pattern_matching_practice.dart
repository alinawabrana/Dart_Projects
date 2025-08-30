import 'package:pattern_matching_practice/pattern_matching_functions/pattern_functions.dart';

class UserInfo {
  String name;
  int age;

  UserInfo({required this.name, required this.age});
}

void main(List<String> arguments) {
  //-------------------------- DIFFERENCE BEFORE AND AFTER PATTERN MATCHING -----------------------------//
  //--------------------------------------------- START -----------------------------//

  //----------- Multiple Returns ----------------//

  //------- before --------//

  List<Object> userInfo(Map<String, dynamic> json) {
    return [json['name'] as String, json['age'] as int];
  }

  var json = {'name': 'Ali', 'age': 24};

  var info = userInfo(json);
  var name = info[0] as String;
  var age = info[1] as int;

  // in Above you can note that we have to explicitly downcast the type of each list index like string or int.
  // To remove the concept of list and also the type safe downcasting we can return the UserInfo Model.

  UserInfo userInfo2(Map<String, dynamic> json) {
    return UserInfo(name: json['name'] as String, age: json['age'] as int);
  }

  var info2 = userInfo2(json);
  var name2 = info2.name;
  var age2 = info2.age;

  // In above the cast are gone but it is verbose to define the model separately for a small task and that bundles up a couple of bits of data.
  // Therefore to remove this we have used the RECORDS.

  //------- after --------//

  (String, int) userInfo3(Map<String, dynamic> json) {
    return (json['name'] as String, json['age'] as int);
  }

  var info3 = userInfo3(json);
  var name3 = info3.$1;
  var age3 = info3.$2;

  // In above for saving the data we are creating new variables. this is good for few return but what if the function returns more.
  // For that the code will look verbode. To remove this verboseness of code, we use destructuring.

  var (name4, age4) = userInfo3(json);
  // This is called record pattern destructuring.
  // If you want to use only a single value then you can do as follow:

  var (_, age5) = userInfo3(json);

  // You can also change the existing variables instead of binding new ones

  (name2, age2) = userInfo3(json);

  //----------- JSON Destructuring ----------------//

  // It is common in dart to bundle up the data in Maps and list.
  // To pull the data from a Map which can have a list inside as well we can now use destructuring.

  //------- before --------//

  var json2 = {
    'user': ['Lily', 14],
  };

  var name6 = json2['user']![0];
  var age6 = json2['user']![1];

  // In addition to record patterns we also have maps and list patterns for destructuring collections .
  // The usage is in the first code in after block.

  // Let's suppose we have retrieve the data from the network. Below is the kind of code we have to write.

  if (json2 is Map<String, dynamic> &&
      json2.length == 1 &&
      json2.containsKey('user')) {
    var user = json2['user'];
    if (user is List<dynamic> &&
        user!.length == 2 &&
        user[0] is String &&
        user[1] is int) {
      var name = user[2] as String;
      var age = user[1] as int;
    }
  }

  // To remove this verboseness of code, there is also pattern matching in switch case as well.
  // When the pattern is inside the switch case, we can say it's refutable means that before destructuring the pattern can decide wether or not to accept the incoming data.
  // The solution is provided in the code 2 in after block.

  //------- after --------//

  var {'user': [name7, age7]} = json2;
  // Note that the structure of the patterns mirrors the structure of the original data
  // This works only if you know the structure of data. If you don't know the structure then you first have to validate it.

  // SOLUTION 2

  switch (json2) {
    case {'user': [String name, int age]}:
      print('User $name is $age years old');
      break;

    default:
      print('Unknown Message');
  }

  // To Further refine the above switch case we can use the if case statements as below

  if (json2 case {'user': [String name, int age]}) {
    print('User $name is $age years old');
  } else {
    print('Unknown Message');
  }

  //----------- Useful Switches ----------------//

  //------- before --------//

  final charCode = 20;
  final nextCharcode = 10;

  switch (charCode) {
    case 10:
      if (nextCharcode == 10) {
        print("Skip Comnent");
      } else {
        print("Operator($charCode)");
      }
      break;

    case 5:
    case 6:
    case 7:
    case 8:
      print("Operator($charCode)");
      break;

    default:
      if (charCode >= 10 && charCode <= 19) {
        print(charCode);
      } else {
        print('Invalid');
      }
      break;
  }

  //------- after --------//

  // To refine the above code we can do following:
  // Remove the break statements. It actually means nothing in dart and was there just to look familiar to users migrating from other languages that uses it.
  // We can add guard clauses. A guard let you evaluate and arbitrary expression to see if that case match. When the guard is false then instead of moving out of the entire switch statemenet, It moves to the next switch case
  // We can add logoc operatiors as well in cases. like ||, && etc.
  // We can reduce the greater than, equal to etc logoc to remove the left side and only keeps the right side. i.e: charcode >= 10 reduces to >= 10

  switch (charCode) {
    // this is the gaurd clause
    case 10 when nextCharcode == 10:
      print('Skip Commnent');

    case 5 || 6 || 7 || 8:
      print("Operator($charCode)");

    case >= 10 && <= 19:
      print(charCode);

    default:
      print('Invalid');
  }

  // We can furthur reduce it to save the returned result in a varibale as well using switch cases.
  // This apprach is called the SWITCH EXPRESSION.

  var result = switch (charCode) {
    // this is the gaurd clause
    10 when nextCharcode == 10 => print('Skip Commnent'),

    5 || 6 || 7 || 8 => print("Operator($charCode)"),

    >= 10 && <= 19 => print(charCode),

    _ => print('Invalid'),
  };

  //----------- Object Destructuring ----------------//

  // For map when we loop over it then we recieve the MapEntry as an input and we have to use someName.key or someName.value like thing to access the key and value.
  // to further improve it we have used the MapEntry and has applied destructuring over it

  //------- before --------//

  Map<String, dynamic> hist = {"Ali": 20, "Sami": 10, "Hammad": 25};

  for (var entry in hist.entries) {
    print("${entry.key} occured ${entry.value} times");
  }

  // To further refine this we have used destructuring using MapEntry as in after block

  //------- after --------//

  for (var MapEntry(key: key, value: count) in hist.entries) {
    print("$key occured $count times");
  }

  // In above if we have the name of variable same as that of the entry name then we can further reduce it as follow

  for (var MapEntry(:key, value: count) in hist.entries) {
    // Here key is having the same name as that in MapEntry property.
    print("$key occured $count times");
  }

  //----------- Functional-Type Programming ----------------//

  // Here the dart has introduced a new class specifier named "sealed".
  // This class checks exhaustiveness, means that it will check if every possible cases are utilized or not.
  // If nit then compiler will tell you while coding about that case.

  //---------------------------------------------- END ------------------------------//

  //-------------------------- String Pattern Matching (basic searching) -----------------------------//

  // stringPatternMatching();

  //-------------------------- Regular Expression (Regex) Pattern Matching -----------------------------//

  // regexPatternMatching();

  // advancedRegexPatternMatching();

  //-------------------------- Matching constants -----------------------------//

  // matchingConstants();

  //-------------------------- Matching with conditions (guards) -----------------------------//

  // matchingWithConditions();

  //-------------------------- Matching lists -----------------------------//

  // matchingList();

  //-------------------------- Matching objects -----------------------------//

  // matchingObjects();

  //-------------------------- Pattern Matching in Loops (using regex or destructuring) -----------------------------//

  patternMatchingInLoop();
}
