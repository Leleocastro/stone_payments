import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';

void main() {
  MethodChannelStonePayments platform = MethodChannelStonePayments();
  const MethodChannel channel = MethodChannel('stone_payments');

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
    expect(await platform.payment(), '42');
  });
}
