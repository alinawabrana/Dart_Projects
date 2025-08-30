void stringPatternMatching() {
  String text = "I love programming in Dart";

  // Basic contains check
  if (text.contains("Dart")) {
    print("Found Dart!");
  }

  // Starts with / ends with
  print(text.startsWith("I love"));
  print(text.endsWith("Python"));
}

void regexPatternMatching() {
  String email = "user@example.com";

  // Regex to check if it's an email
  RegExp regex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");

  if (regex.hasMatch(email)) {
    print("Valid email");
  } else {
    print("Invalid email");
  }

  // Extract numbers
  String sentence = "My phone number is 12345";
  RegExp numbers = RegExp(r"\d+");
  print(numbers.firstMatch(sentence)?.group(0)); // 12345
}

void matchingConstants() {
  var command = "start";

  switch (command) {
    case "start":
      print("Starting...");
    case "stop":
      print("Stopping...");
    default:
      print("Unknown command");
  }
}

void matchingWithConditions() {
  int number = 10;

  switch (number) {
    case >= 0 && <= 10:
      print("Between 0 and 10");
    case > 10:
      print("Greater than 10");
    default:
      print("Negative number");
  }
}

void matchingList() {
  var list = [1, 2, 3];

  switch (list) {
    case [1, 2, 3]:
      print("Matched exactly [1,2,3]");
    case [1, _, _]: // `_` means "don’t care"
      print("List starts with 1");
    case [var a, var b, var c]:
      print("Unpacked: $a $b $c");
    default:
      print("No match");
  }
}

void matchingObjects() {
  var point = (x: 10, y: 20);

  switch (point) {
    case (x: 0, y: 0):
      print("Origin");
    case (x: var x, y: var y):
      print("Point at ($x, $y)");
  }
}

void patternMatchingInLoop() {
  List<String> words = ["cat", "dog", "car", "dart"];

  for (var word in words) {
    if (RegExp(r"^c").hasMatch(word)) {
      print("$word starts with c");
    }
  }
}

void advancedRegexPatternMatching() {
  const pattern =
      r'^\[(?<Time>\s*((?<hour>\d+)):((?<minute>\d+))\.((?<second>\d+)))\]'
      r'\s(?<Message>\s*(.*)$)';

  final regExp = RegExp(pattern, multiLine: true);

  const multilineText =
      '[00:13.37] This is a first message.\n'
      '[01:15.57] This is a second message.\n';

  RegExpMatch regExpMatch = regExp.firstMatch(multilineText)!;
  print(regExpMatch.groupNames.join('-')); // hour-minute-second-Time-Message.
  final time = regExpMatch.namedGroup('Time'); // 00:13.37
  final hour = regExpMatch.namedGroup('hour'); // 00
  final minute = regExpMatch.namedGroup('minute'); // 13
  final second = regExpMatch.namedGroup('second'); // 37
  final message = regExpMatch.namedGroup(
    'Message',
  ); // This is the first message.
  final date = regExpMatch.namedGroup('Date'); // Undefined `Date`, throws.

  Iterable<RegExpMatch> matches = regExp.allMatches(multilineText);
  for (final m in matches) {
    print(m.namedGroup('Time'));
    print(m.namedGroup('Message'));
    // 00:13.37
    // This is the first message.
    // 01:15.57
    // This is the second message.
  }
}
