class EnumHelper {
  static String getValue(dynamic enumInstance) {
    return enumInstance.toString().split('.').last;
  }
}
