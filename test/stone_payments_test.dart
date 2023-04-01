import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/stone_payments.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';
import 'package:stone_payments/stone_payments_platform_interface.dart';

class MockStonePaymentsPlatform
    with MockPlatformInterfaceMixin
    implements StonePaymentsPlatform {
  @override
  Future<String?> payment() => Future.value('42');
}

void main() {
  final StonePaymentsPlatform initialPlatform = StonePaymentsPlatform.instance;

  test('$MethodChannelStonePayments is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStonePayments>());
  });

  test('getPlatformVersion', () async {
    StonePayments stonePaymentsPlugin = StonePayments();
    MockStonePaymentsPlatform fakePlatform = MockStonePaymentsPlatform();
    StonePaymentsPlatform.instance = fakePlatform;

    expect(await stonePaymentsPlugin.getPlatformVersion(), '42');
  });
}
