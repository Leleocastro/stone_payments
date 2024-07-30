/// Enum to define the type of transaction
/// This enum is used to define the type of transaction
/// Credit or Debit
/// The value is used as a flag to define the type of transaction
/// 0 = Debit
/// 1 = Credit
/// 2 = Voucher
/// 4 = PIX
enum TypeTransactionEnum {
  /// Debit
  debit(0),

  /// Credit
  credit(1),

  /// Voucher
  voucher(2),

  /// PIX
  pix(4);

  /// Values of the enum
  final int value;

  const TypeTransactionEnum(this.value);
}
