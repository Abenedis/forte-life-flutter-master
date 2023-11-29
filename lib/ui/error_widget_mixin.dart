import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin ErrorWidgetMixin {
  final ScrollController scrollController = ScrollController();
  final BehaviorSubject<bool> _errorSubject = BehaviorSubject<bool>();
  Timer _errorTimer;

  void showError() {
    _errorSubject.add(true);

    Future.delayed(
      const Duration(milliseconds: 50),
      () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
  }

  void initErrorTimer() {
    _errorSubject?.listen((value) {
      _errorTimer?.cancel();
      _errorTimer = Timer(
        const Duration(seconds: 7),
        () => _errorSubject.add(false),
      );
    });
  }

  Widget get errorWidget => StreamBuilder<bool>(
      stream: _errorSubject.stream,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Text(
              'Будь ласка, заповніть всі поля правильно',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      });

  void disposeErrorWidget() {
    _errorSubject?.close();
    _errorTimer?.cancel();
    scrollController?.dispose();
  }
}
