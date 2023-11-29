import 'package:forte_life/core/models/label_model.dart';

class CalculationResponse {
  final String title;
  final String image;
  final List<Label> labels;
  final String price;
  CalculationResponse({
    this.title,
    this.labels,
    this.image,
    this.price,
  });
}
