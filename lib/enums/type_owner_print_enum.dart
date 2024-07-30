/// Enum to define the type of owner of the print
/// [TypeOwnerPrintEnum.merchant] = 1
/// [TypeOwnerPrintEnum.client] = 0
enum TypeOwnerPrintEnum {
  /// Merchant
  merchant(1),

  /// Client
  client(0);

  /// Values of the enum
  final int value;

  const TypeOwnerPrintEnum(this.value);
}
