/// Enum to define the type of transaction
/// This enum is used to define the type of transaction
/// Credit or Debit
/// The value is used as a flag to define the type of transaction
/// 0 = Debit
/// 1 = Credit
/// 2 = Voucher
/// 4 = PIX
enum TypeTransactionEnum {
  debit(0),
  credit(1),
  voucher(2),
  pix(4);

  final int value;

  const TypeTransactionEnum(this.value);
}
