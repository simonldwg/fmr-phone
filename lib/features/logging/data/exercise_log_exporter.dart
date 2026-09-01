import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import '../domain/models/exercise_log.dart';

class ExerciseLogExporter {
  const ExerciseLogExporter._();

  static Future<bool> export(ExerciseLog log) async {
    final bytes = Uint8List.fromList(utf8.encode(toJsonString(log)));

    final result = await FilePicker.saveFile(
      dialogTitle: 'Trainingsprotokoll exportieren',
      fileName: _fileNameFor(log),
      bytes: bytes,
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    return result != null;
  }

  static String _fileNameFor(ExerciseLog log) {
    final timestamp = log.startTime.toIso8601String().replaceAll(':', '-');
    return 'training_$timestamp.json';
  }

  static String toJsonString(ExerciseLog log) =>
      const JsonEncoder.withIndent('  ').convert(log.toJson());
}
