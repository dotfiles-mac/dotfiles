// SPDX-FileCopyrightText: 2025-2026 Niladri Das
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

import 'dart:io';

void main(List<String> args) {
  final bumpType = args.isNotEmpty ? args[0] : 'patch';

  final versionFile = File('VERSION');
  if (!versionFile.existsSync()) {
    print('VERSION file not found');
    exit(1);
  }

  final currentVersion = versionFile.readAsStringSync().trim();
  final parts = currentVersion.split('.');
  if (parts.length != 3) {
    print('Invalid version format');
    exit(1);
  }

  var major = int.parse(parts[0]);
  var minor = int.parse(parts[1]);
  var patch = int.parse(parts[2]);

  switch (bumpType) {
    case 'major':
      major++;
      minor = 0;
      patch = 0;
      break;
    case 'minor':
      minor++;
      patch = 0;
      break;
    case 'patch':
    default:
      patch++;
      break;
  }

  final newVersion = '$major.$minor.$patch';
  versionFile.writeAsStringSync('$newVersion\n');

  // Update pubspec.yaml if it exists
  final pubspecFile = File('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final content = pubspecFile.readAsStringSync();
    final updatedContent = content.replaceFirst(
      RegExp(r'version: \d+\.\d+\.\d+'),
      'version: $newVersion'
    );
    pubspecFile.writeAsStringSync(updatedContent);
  }

  print('Version bumped from $currentVersion to $newVersion ($bumpType)');
}
