/// Stacktrace tool for logging<br />
/// example : <br />
/// print(CurrentInfo(StackTrace.current).getString() + 'fizz buzz');
class CurrentInfo {
  /// [current] : StackTrace.current<br />
  /// [showTimestamp] : show timestamp or not
  CurrentInfo(StackTrace this.current, {this.showTimestamp = false});
  StackTrace? current;
  bool showTimestamp = false;

  /// get className,functionName,fileName,LineNumber for logging
  String getString() {
    String now = '';
    if (showTimestamp) {
      now = DateTime.now().toString() + ' ';
    }
    if (current == null) {
      return '$now';
    }
    String currentStr = current.toString().split('\n')[0];
    currentStr = currentStr.split('      ')[1];
    final String ret = '$now$currentStr';
    return ret;
  }
}
