import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/ui/screens/programs/program_list_item.dart';
import 'package:forte_life/ui/widget/easy_stream_builder.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:provider/provider.dart';

import 'programs_bloc.dart';

class ProgramsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateProgramsScreen();
}

class _StateProgramsScreen extends State<ProgramsScreen> {
  ProgramsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc =
        ProgramsBloc(Provider.of<DI>(context, listen: false).programService);
  }

  @override
  Widget build(BuildContext context) => Ink(
        color: StandardColors.primaryColor,
        child: EasyStreamBuilder<List<Program>>(
          stream: _bloc.subject.stream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Program>> snapshot) {
            if (snapshot.data.length == 6) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: ProgramListItem(snapshot.data[0])),
                          Expanded(child: ProgramListItem(snapshot.data[1])),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: ProgramListItem(snapshot.data[2])),
                          Expanded(child: ProgramListItem(snapshot.data[3])),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: ProgramListItem(snapshot.data[4])),
                          Expanded(child: ProgramListItem(snapshot.data[5])),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.symmetric(
                vertical: 50,
              ),
              childAspectRatio: 1.3,
              children: snapshot.data.map((e) => ProgramListItem(e)).toList(),
            );
          },
          withoudData: (context) => Loading(),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
