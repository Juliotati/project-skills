import 'dart:async';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// [Golden Eye Configuration]
///
/// This file centralizes the Alchemist configuration for the project.
/// It ensures that all golden tests are stored in a standard `local_goldens` directory
/// and follow a consistent mirroring pattern.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Replace with your project's brand theme or just keep it default.
  const theme = ThemeData.light(); 

  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock path_provider to prevent crashes during tests that access storage
  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/path_provider',
  );
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return '.'; // Return current directory for all path requests
  });

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: theme,
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: true,
        theme: theme,
        filePathResolver: (fileName, _) {
          // Automatic Directory Mirroring:
          // Resolves the path to the current test file and mirrors its 
          // location into the `local_goldens` directory.
          final scriptPath = File(Platform.script.toFilePath()).path;
          final pathParts = p.split(scriptPath);
          final testIndex = pathParts.lastIndexOf('test');

          final relativeParts = pathParts.sublist(
            testIndex + 1,
            pathParts.length - 1,
          );
          final String subPath = p.joinAll(relativeParts);

          // Calculate levels to go back to reached the project root
          final int levelsToRoot = relativeParts.length + 1;
          final String backToRoot = List.generate(
            levelsToRoot,
            (_) => '..',
          ).join('/');

          // Output: project_root/local_goldens/<sub_path>/<file_name>.png
          return p.join(backToRoot, 'local_goldens', subPath, '$fileName.png');
        },
      ),
      ciGoldensConfig: CiGoldensConfig(
        enabled: false,
        theme: theme,
        filePathResolver: (filename, environmentName) {
          return 'local_goldens/$filename.png';
        },
      ),
    ),
    run: testMain,
  );
}
