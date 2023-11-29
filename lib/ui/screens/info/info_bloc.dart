import 'dart:async';

import 'package:forte_life/core/models/info_model.dart';
import 'package:forte_life/core/services/info_service.dart';
import 'package:forte_life/ui/base_bloc.dart';

class InfoScreenBloc extends BaseBloc<List<Info>> {
  final InfoService infoService;

  InfoScreenBloc(this.infoService) {
    _initInfo();
  }

  Future<void> _initInfo() async {
    final List<Info> info = await infoService.getInfo();
    if (!subject.isClosed) subject.add(info);
  }
}
