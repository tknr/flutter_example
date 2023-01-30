/// Stacktrace tool for logging
class CurrentInfo {
  StackTrace? current;

  /// @param Stacktrace current
  CurrentInfo(StackTrace current) {
    this.current = current;
  }

  /// get className,functionName,fileName,LineNumber for logging
  String? getString() {
    final now = DateTime.now();
    if (this.current == null) {
      return '${now.toString()}';
    }
    String currentStr = this.current.toString().split('\n')[0];
    currentStr = currentStr.split('      ')[1];
    String ret = '${now.toString()} ${currentStr}';
    return ret;
  }
}
