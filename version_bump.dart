import 'dart:io';

void main() {
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

  final major = int.parse(parts[0]);
  final minor = int.parse(parts[1]);
  final patch = int.parse(parts[2]) + 1;

  final newVersion = '$major.$minor.$patch';
  versionFile.writeAsStringSync('$newVersion\n');

  print('Version bumped from $currentVersion to $newVersion');
}
