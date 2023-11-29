class CalculateProgramEntity {
  int period;
  int termin;
  int type;
  int vnesok;
  int strahSumm;
  int programmId;
  String birthday;
  CalculateProgramEntity({
    this.period,
    this.termin,
    this.type,
    this.vnesok,
    this.strahSumm,
    this.programmId,
    this.birthday,
  });

  CalculateProgramEntity.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    termin = json['termin'];
    type = json['type'];
    vnesok = json['vnesok'];
    strahSumm = json['strah_summ'];
    programmId = json['programm_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['termin'] = this.termin;
    data['type'] = this.type;
    data['vnesok'] = this.vnesok;
    data['strah_summ'] = this.strahSumm;
    data['programm_id'] = this.programmId;
    data['birthday'] = this.birthday;
    return data..removeWhere((key, value) => key == null || value == null);
  }
}
