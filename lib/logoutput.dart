import 'dart:io';
import 'package:logger/logger.dart';

class FileLogOutput extends LogOutput 
{
  final File logFile;

  FileLogOutput(this.logFile);

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      logFile.writeAsStringSync('$line\n', mode: FileMode.append);
    }
  }
}