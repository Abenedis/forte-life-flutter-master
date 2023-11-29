import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class DateController {
  DateController(this.minYears, this.maxYears);
  final int minYears;
  final int maxYears;

  final TextEditingController dayTec = TextEditingController();
  final TextEditingController monthTec = TextEditingController();
  final TextEditingController yearTec = TextEditingController();

  final BehaviorSubject<String> _validationError = BehaviorSubject<String>()
    ..add('');

  String get getDate =>
      '${dayTec.text.padLeft(2, '0')}.${monthTec.text.padLeft(2, '0')}.${yearTec.text.padLeft(2, '0')}';
  DateTime get getDateTime => DateTime(
        int.tryParse(yearTec.text),
        int.tryParse(monthTec.text),
        int.tryParse(dayTec.text),
      );
  Stream<String> get validationError => _validationError.stream;

  bool validate() {
    if (dayTec.text.isEmpty && monthTec.text.isEmpty && yearTec.text.isEmpty) {
      _validationError.add('Поле не може бути порожнім');
      return false;
    } else {
      try {
        int day = int.tryParse(dayTec.text);
        int month = int.tryParse(monthTec.text);
        int year = int.tryParse(yearTec.text);
        if (day > 31 || day < 1 || month > 12 || month < 1 || year < 1) {
          throw Exception();
        }
        if (day != null && month != null && year != null) {
          final DateTime input = DateTime(year, month, day);
          if (input.month != month) {
            _validationError.add('Невірно введені дані');
            return false;
          }
          final DateTime now = DateTime.now();
          // final int daysDiffs = now.difference(input).inDays;
          final int yearDifference = now.year - year;
          print(yearDifference);
          if (yearDifference <= maxYears && yearDifference >= minYears) {
            if (yearDifference != maxYears && yearDifference != minYears) {
              _validationError.add('');
              return true;
            } else {
              // if (yearDifference == maxYears) {
              final minDate = DateTime(now.year - maxYears, now.month, now.day);
              final maxDate = DateTime(now.year - minYears, now.month, now.day);
              if (minDate.isBefore(input) && maxDate.isAfter(input)) {
                _validationError.add('');
                return true;
              } else {
                _validationError
                    .add('Значення повинне бути $minYears - $maxYears років');
                return false;
              }
            }
          } else {
            _validationError
                .add('Значення повинне бути $minYears - $maxYears років');
            return false;
          }
        }
        _validationError.add('Невірно введені дані');
        return false;
      } catch (e) {
        _validationError.add('Невірно введені дані');
        return false;
      }
    }
  }

  void dispose() {
    dayTec?.dispose();
    monthTec?.dispose();
    yearTec?.dispose();
  }
}
