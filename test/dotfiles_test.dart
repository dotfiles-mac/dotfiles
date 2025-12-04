import 'package:test/test.dart';
import 'package:args/args.dart';

void main() {
  group('ArgParser', () {
    test('parses help flag', () {
      final parser = ArgParser()
        ..addFlag('help', abbr: 'h', help: 'Show help')
        ..addCommand('version');

      final results = parser.parse(['--help']);
      expect(results['help'], true);
    });

    test('parses version command', () {
      final parser = ArgParser()
        ..addFlag('help', abbr: 'h', help: 'Show help')
        ..addCommand('version');

      final results = parser.parse(['version']);
      expect(results.command?.name, 'version');
    });
  });
}
