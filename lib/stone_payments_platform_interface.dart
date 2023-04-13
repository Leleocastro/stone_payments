import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';

import 'stone_payments_method_channel.dart';

abstract class StonePaymentsPlatform extends PlatformInterface {
  /// Constructs a StonePaymentsPlatform.
  StonePaymentsPlatform() : super(token: _token);

  static final Object _token = Object();

  static StonePaymentsPlatform _instance = MethodChannelStonePayments();

  /// The default instance of [StonePaymentsPlatform] to use.
  ///
  /// Defaults to [MethodChannelStonePayments].
  static StonePaymentsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StonePaymentsPlatform] when
  /// they register themselves.
  static set instance(StonePaymentsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<String> get onMessage;

  Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) {
    throw UnimplementedError('payment() has not been implemented.');
  }

  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
  }) {
    throw UnimplementedError('activateStone() has not been implemented.');
  }

  Future<String?> printFile(String imgBase64) {
    throw UnimplementedError('printFile() has not been implemented.');
  }

  Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    throw UnimplementedError('printReceipt() has not been implemented.');
  }

  Future printLineToLine(List<String> lines){
    throw UnimplementedError('printLineToLine() has not been implemented.');
  }
}
