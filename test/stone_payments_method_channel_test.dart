import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelStonePayments platform = MethodChannelStonePayments();
  const MethodChannel channel = MethodChannel('stone_payments');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('payment', () async {
    expect(
      await platform.payment(
        typeTransaction: TypeTransactionEnum.debit,
        value: 10,
      ),
      '42',
    );
  });
}
