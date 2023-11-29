import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/core/models/info_model.dart';
import 'package:forte_life/ui/screens/info/info_bloc.dart';
import 'package:forte_life/ui/screens/info/info_fab.dart';
import 'package:forte_life/ui/widget/easy_stream_builder.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:provider/provider.dart';

import 'info_list_item.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateInfoScreen();
}

class _StateInfoScreen extends State<InfoScreen> {
  InfoScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = InfoScreenBloc(Provider.of<DI>(context, listen: false).infoService);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: StandardColors.accentColor,
        body: EasyStreamBuilder<List<Info>>(
          stream: _bloc.subject.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Info>> snapshot) {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 100, top: 16),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InfoListItem(snapshot.data[index]);
              },
            );
          },
          withoudData: (context) => Loading(color: StandardColors.primaryColor),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 95.0),
          child: const InfoFab(),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
