import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutternativeaccess/flutternativeaccess.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutternativeaccess');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Flutternativeaccess.platformVersion, '42');
  });
}
