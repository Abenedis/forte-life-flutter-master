class PopupProgramResponse {
  double price;
  double trauma;
  double ruzukLife;
  String ruzukDeath;
  String terminPay;
  double termin;
  String period;
  PopupProgramResponse({this.price, this.trauma});

  PopupProgramResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) {
    } else {
      price = json['price']?.toDouble() ?? 0;
      trauma = json['trauma']?.toDouble() ?? 0;
      ruzukLife = json['ruzuk_life']?.toDouble() ?? 0;
      ruzukDeath = json['ruzuk_death']?.toString();
      terminPay = json['termin_pay']?.toString();
      termin = json['termin']?.toDouble() ?? 0;
      period = json['period'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['trauma'] = this.trauma;
    return data;
  }
}
