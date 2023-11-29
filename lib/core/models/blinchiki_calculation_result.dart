class BlinckikiCalculationResult {
  Calculate calculate;
  Content content;

  BlinckikiCalculationResult({this.calculate, this.content});

  BlinckikiCalculationResult.fromJson(Map<String, dynamic> json) {
    calculate = json['calculate'] != null
        ? new Calculate.fromJson(json['calculate'])
        : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calculate != null) {
      data['calculate'] = this.calculate.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class Calculate {
  SummForte summForte;
  SummForte summ11Personal;
  SummForte summ11Consultant;
  PayInvest payInvest;

  Calculate(
      {this.summForte,
      this.summ11Personal,
      this.summ11Consultant,
      this.payInvest});

  Calculate.fromJson(Map<String, dynamic> json) {
    summForte = json['summ_forte'] != null
        ? new SummForte.fromJson(json['summ_forte'])
        : null;
    summ11Personal = json['summ_11_personal'] != null
        ? new SummForte.fromJson(json['summ_11_personal'])
        : null;
    summ11Consultant = json['summ_11_consultant'] != null
        ? new SummForte.fromJson(json['summ_11_consultant'])
        : null;
    payInvest = json['pay_invest'] != null
        ? new PayInvest.fromJson(json['pay_invest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summForte != null) {
      data['summ_forte'] = this.summForte.toJson();
    }
    if (this.summ11Personal != null) {
      data['summ_11_personal'] = this.summ11Personal.toJson();
    }
    if (this.summ11Consultant != null) {
      data['summ_11_consultant'] = this.summ11Consultant.toJson();
    }
    if (this.payInvest != null) {
      data['pay_invest'] = this.payInvest.toJson();
    }
    return data;
  }
}

class SummForte {
  String title;
  int number;

  SummForte({this.title, this.number});

  SummForte.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['number'] = this.number;
    return data;
  }
}

class PayInvest {
  String title;
  String title2;
  int number;

  PayInvest({this.title, this.title2, this.number});

  PayInvest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    title2 = json['title_2'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_2'] = this.title2;
    data['number'] = this.number;
    return data;
  }
}

class Content {
  Blinchik blinchik0;
  Blinchik blinchik1;

  Content({this.blinchik0, this.blinchik1});

  Content.fromJson(Map<String, dynamic> json) {
    blinchik0 = json['blinchik0'] != null
        ? new Blinchik.fromJson(json['blinchik0'])
        : null;
    blinchik1 = json['blinchik1'] != null
        ? new Blinchik.fromJson(json['blinchik1'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blinchik0 != null) {
      data['Blinchik'] = this.blinchik0.toJson();
    }
    if (this.blinchik1 != null) {
      data['blinchik1'] = this.blinchik1.toJson();
    }
    return data;
  }
}

class Blinchik {
  String image;
  String title;

  Blinchik({this.image, this.title});

  Blinchik.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
