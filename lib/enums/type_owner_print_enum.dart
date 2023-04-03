/// Enum to define the type of owner of the print
/// [TypeOwnerPrintEnum.merchant] = 1
/// [TypeOwnerPrintEnum.client] = 0
enum TypeOwnerPrintEnum {
  merchant(1),
  client(0);

  final int value;

  const TypeOwnerPrintEnum(this.value);
}
