import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/models/item_print_model.dart';
import 'package:stone_payments/models/transaction.dart';

import 'stone_payments_method_channel.dart';

/// The interface that implementations of stone_payments must implement.
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

  /// Stream of messages
  Stream<String> get onMessage;

  /// Payment
  Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) {
    throw UnimplementedError('payment() has not been implemented.');
  }

  /// Transaction
  Future<Transaction?> transaction({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
    ValueChanged<String>? onPixQrCode,
  }) {
    throw UnimplementedError('payment() has not been implemented.');
  }

  /// Activate Stone
  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
    String? qrCodeProviderId,
    String? qrCodeAuthorization,
  }) {
    throw UnimplementedError('activateStone() has not been implemented.');
  }

  /// Print
  Future<String?> print(List<ItemPrintModel> items) {
    throw UnimplementedError('print() has not been implemented.');
  }

  /// Print Receipt
  Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    throw UnimplementedError('printReceipt() has not been implemented.');
  }

  /// Abort
  Future<String?> abort() {
    throw UnimplementedError('abort() has not been implemented.');
  }
}
