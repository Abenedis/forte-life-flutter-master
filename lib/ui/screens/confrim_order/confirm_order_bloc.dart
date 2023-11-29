import 'package:forte_life/core/models/order/order_info.dart';
import 'package:forte_life/core/models/order/order_label.dart';
import 'package:forte_life/ui/base_bloc.dart';

class ConfirmOrderBloc extends BaseBloc<OrderInfo> {
  final Map<String, String> detail;
  final String orderID;
  ConfirmOrderBloc(this.detail, this.orderID) {
    _fetchData();
  }
  void _fetchData() {
    final List<OrderLabel> labels = <OrderLabel>[];
    labels.add(OrderLabel(
      title: 'Перевірте дані',
      value:
          'Натисніть "оплатити" - якщо все вірно або “Виправити”  для виправлення даних.',
    ));
    detail.forEach((key, value) {
      labels.add(
        OrderLabel(title: key, value: value),
      );
    });
    final DateTime now = DateTime.now();
    labels.add(OrderLabel(
      title: 'Дата з якої діє договір',
      value:
          '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year.toString().padLeft(2, '0')}',
    ));

    labels.add(OrderLabel(
      title: 'Номер договору',
      value: orderID,
    ));

    subject.add(
      OrderInfo(labels),
    );
  }
}
