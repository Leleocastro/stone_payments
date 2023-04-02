import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/stone_payments.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';
import 'package:stone_payments/stone_payments_platform_interface.dart';

class MockStonePaymentsPlatform
    with MockPlatformInterfaceMixin
    implements StonePaymentsPlatform {
  @override
  Future<String?> activateStone(
      {required String appName, required String stoneCode}) {
    // TODO: implement activateStone
    throw UnimplementedError();
  }

  @override
  // TODO: implement onMessage
  Stream<String> get onMessage => throw UnimplementedError();

  @override
  Future<String?> printFile(String imgBase64) {
    // TODO: implement printFile
    throw UnimplementedError();
  }

  @override
  Future<String?> payment(
      {required double value,
      required TypeTransactionEnum typeTransaction,
      int installment = 1,
      bool? printReceipt}) {
    return Future.value('42');
  }
}

void main() {
  late StonePaymentsPlatform initialPlatform;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    initialPlatform = StonePaymentsPlatform.instance;
  });

  test('$MethodChannelStonePayments is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStonePayments>());
  });

  test('payment', () async {
    StonePayments stonePaymentsPlugin = StonePayments();
    MockStonePaymentsPlatform fakePlatform = MockStonePaymentsPlatform();
    StonePaymentsPlatform.instance = fakePlatform;

    expect(
      await stonePaymentsPlugin.payment(
        typeTransaction: TypeTransactionEnum.credit,
        value: 10,
      ),
      '42',
    );
  });
}
