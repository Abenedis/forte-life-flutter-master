class RangeNum {
  int min;
  int max;
  int multiplicity;

  RangeNum({this.min, this.max, this.multiplicity});

  RangeNum.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    multiplicity = json['multiplicity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    data['multiplicity'] = this.multiplicity;
    return data;
  }

  bool get isHasValue => max != 0 && multiplicity != 0;
}
