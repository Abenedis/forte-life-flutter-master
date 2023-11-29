abstract class Validator {
  static const String emptyError = 'Поле не може бути порожнім';
  static const String badData = 'Невірно введені дані';

  static String _lengthFormat(List<int> length) =>
      'Поле може містити лише ${length.join(',')} символів';

  static final RegExp _numberRegExp = RegExp(r'^[0-9]+$');
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static String empty(String value) => value.isNotEmpty ? null : emptyError;

  static String number(String value) => empty(value) == null
      ? (_numberRegExp.hasMatch(value)
          ? value.startsWith('0')
              ? badData
              : null
          : badData)
      : emptyError;

  static String numberWithMin(String value, int min) {
    if (empty(value) == null) {
      if (_numberRegExp.hasMatch(value)) {
        if (value.startsWith('0')) {
          return badData;
        } else {
          try {
            final res = int.tryParse(value);
            if (res == null) {
              throw Exception();
            }
            if (min != 0) {
              if (res >= min) {
                return null;
              }
              return 'Мінімальне значення $min';
            } else {
              return null;
            }
          } catch (e) {
            return badData;
          }
        }
      } else {
        return badData;
      }
    } else {
      return emptyError;
    }
  }

  static String phone(String value) => empty(value) == null
      ? (_numberRegExp.hasMatch(value)
          ? value.length != 9
              ? badData
              : null
          : badData)
      : emptyError;

  static String _isNumRegex(String value) => empty(value) == null
      ? (_numberRegExp.hasMatch(value) ? null : badData)
      : emptyError;

  static String length(String value, List<int> length) =>
      length.contains(0) && value.isEmpty
          ? null
          : _isNumRegex(value) == null
              ? (length.contains(value.length) ? null : _lengthFormat(length))
              : emptyError;

  static String email(String value) => empty(value) == null
      ? (_emailRegExp.hasMatch(value) ? null : badData)
      : emptyError;

  static String emailLength(String value, List<int> length) {
    if (length == null || length.isEmpty) {
      return email(value);
    }
    return length.contains(0) && value.isEmpty ? null : email(value);
  }

  static String phoneLength(String value, List<int> length) {
    if (length == null || length.isEmpty) {
      return phone(value);
    }
    return length.contains(0) && value.isEmpty ? null : phone(value);
  }

  static String emptyLength(String value, List<int> length) {
    if (length == null || length.isEmpty) {
      return empty(value);
    }
    return length.contains(0) && value.isEmpty ? null : empty(value);
  }
}
