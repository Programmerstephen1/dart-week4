import 'dart:io';
import 'package:intl/intl.dart';

class Entry {
  final String original;
  final String manipulated;
  final DateTime timestamp;

  Entry(this.original, this.manipulated, this.timestamp);

  @override
  String toString() =>
      'Original: $original, Manipulated: $manipulated, Timestamp: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp)}';

  String timeElapsed() {
    final duration = DateTime.now().difference(timestamp);
    if (duration.inDays > 0) return '${duration.inDays} day(s) ago';
    if (duration.inHours > 0) return '${duration.inHours} hour(s) ago';
    if (duration.inMinutes > 0) return '${duration.inMinutes} minute(s) ago';
    return 'just now';
  }
}

String manipulateString(String input) {
  // Trim whitespace, reverse, uppercase, and capitalize first letter
  String trimmed = input.trim();
  if (trimmed.isEmpty) return '';
  String reversed = trimmed.split('').reversed.join('');
  String upper = reversed.toUpperCase();
  return upper[0] + upper.substring(1).toLowerCase();
}

Future<List<Entry>> readEntriesFromFile(String path) async {
  final file = File(path);
  List<Entry> entries = [];
  if (!await file.exists()) return entries;

  try {
    final lines = await file.readAsLines();
    for (var line in lines) {
      // Expecting: Original: ..., Manipulated: ..., Timestamp: yyyy-MM-dd HH:mm:ss
      final regex = RegExp(r'Original: (.*), Manipulated: (.*), Timestamp: (.*)');
      final match = regex.firstMatch(line);
      if (match != null) {
        entries.add(Entry(
          match.group(1)!,
          match.group(2)!,
          DateFormat('yyyy-MM-dd HH:mm:ss').parse(match.group(3)!),
        ));
      }
    }
  } catch (e) {
    print('Error reading existing entries: $e');
  }
  return entries;
}

Future<void> writeFile(String path, List<Entry> entries) async {
  try {
    final file = File(path);
    final content = entries.map((e) => e.toString()).join('\n');
    await file.writeAsString(content);
  } catch (e) {
    print('Error writing file: $e');
  }
}

void displayEntries(List<Entry> entries) {
  if (entries.isEmpty) {
    print('No entries yet.');
    return;
  }
  print('Current Entries:');
  for (var entry in entries) {
    print('${entry.toString()} (${entry.timeElapsed()})');
  }
}

Future<void> main() async {
  const filePath = 'entries_log.txt';
  List<Entry> entries = await readEntriesFromFile(filePath);

  print('Welcome to the String Manipulation Utility!');
  displayEntries(entries);

  print('\nEnter strings to manipulate (empty input to finish):');

  while (true) {
    stdout.write('> ');
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print('Finished input.');
      break;
    }

    String manipulated = manipulateString(input);
    if (manipulated.isEmpty) {
      print('Invalid input, please enter non-empty text.');
      continue;
    }

    var newEntry = Entry(input.trim(), manipulated, DateTime.now());
    entries.add(newEntry);

    print('Manipulated: $manipulated');
  }

  await writeFile(filePath, entries);
  print('\nEntries saved to $filePath');
  displayEntries(entries);
}

