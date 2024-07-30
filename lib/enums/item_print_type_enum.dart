/// This enum is used to define the type of item print.
enum ItemPrintTypeEnum {
  /// Text type
  text(0),

  /// Image type
  image(1);

  /// Values of the enum
  final int value;

  const ItemPrintTypeEnum(this.value);
}
