class NoNextPageException implements Exception {
  String? msg;

  NoNextPageException({this.msg});

  String get message => msg ?? '';

  @override
  String toString() => 'NoNextPageException' + (msg != null ? ': $msg' : '');
}
