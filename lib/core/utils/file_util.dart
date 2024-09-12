import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class FileUtil {
  static Future<List<T>> readJsonFile<T>(
    String filePath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        throw Exception('File not found at path: $filePath');
      }
      if (kDebugMode) {
        print('read file success!');
      }
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);

      return data
          .map<T>((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading or parsing JSON file: $e');
      }
      return []; // Return an empty list on error
    }
  }
}
