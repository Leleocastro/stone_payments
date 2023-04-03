/// Enum to define the type of transaction
/// This enum is used to define the type of transaction
/// Credit or Debit
/// The value is used as a flag to define the type of transaction
/// 1 = Credit
/// 0 = Debit
enum TypeTransactionEnum {
  credit(1),
  debit(0);

  final int value;

  const TypeTransactionEnum(this.value);
}
