import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/core/models/blinchiki_calculation_result.dart';
import 'package:forte_life/core/models/program/range_num.dart';
import 'package:forte_life/ui/screens/programs_detail/widgets/slider_widget.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'blinchiki_calculate_bloc.dart';
import 'widgets/blinchiki_content_data.dart';

class BlinchikiCalculateScreen extends StatefulWidget {
  BlinchikiCalculateScreen({Key key}) : super(key: key);

  @override
  _BlinchikiCalculateScreenState createState() =>
      _BlinchikiCalculateScreenState();
}

class _BlinchikiCalculateScreenState extends State<BlinchikiCalculateScreen> {
  BlinchikiCalculateBloc _bloc;
  @override
  void initState() {
    _bloc = BlinchikiCalculateBloc(
      Provider.of<DI>(
        context,
        listen: false,
      ).blinchikiService,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar('Розрахувати'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Виберіть вартість нерухомості, ГРН',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: StreamBuilder<int>(
                  stream: _bloc.sum,
                  initialData: 500000,
                  builder: (context, snapshot) {
                    return SliderWidget(
                      onChange: _bloc.updateSum,
                      pay: RangeNum(
                        min: 500000,
                        max: 2000000,
                        multiplicity: 250000,
                      ),
                      value: snapshot.data,
                      width: 60,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(
                StandardDimensions.edge,
              ),
              child: RaisedButton(
                onPressed: _calculate,
                elevation: 8.0,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text('Розрахувати'),
                  ),
                ),
              ),
            ),
            StreamBuilder<BlinckikiCalculationResult>(
              stream: _bloc.subject.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return BlinchikiContentData(
                  result: snapshot.data,
                  lastSum: _bloc.lastCalculatedSum,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() {
    showDialog(
      context: context,
      builder: (_) => Loading(
        color: StandardColors.primaryColor,
      ),
    );
    _bloc.calculate().whenComplete(() => Navigator.of(context).pop());
  }
}
