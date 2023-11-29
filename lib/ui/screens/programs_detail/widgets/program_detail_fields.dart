import 'package:flutter/material.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/core/models/program/program_detail.dart';
import 'package:forte_life/core/models/program/range_num.dart';
import 'package:forte_life/ui/screens/programs_detail/widgets/selector_widget.dart';
import 'package:forte_life/ui/widget/date/date_controlled.dart';
import 'package:forte_life/ui/widget/date/date_widget.dart';
import 'package:provider/provider.dart';
import '../program_detail_bloc.dart';
import 'radio_widget.dart';
import 'slider_widget.dart';

class ProgramDetailFields extends StatelessWidget {
  const ProgramDetailFields({
    Key key,
    this.container,
    this.sumTec,
    this.dateController,
  }) : super(key: key);

  final Calc container;
  final DateController dateController;
  final TextEditingController sumTec;
  @override
  Widget build(BuildContext context) {
    var divider = SizedBox(
      height: StandardDimensions.smaller,
      width: StandardDimensions.smaller,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (container?.birthday != null)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: StandardDimensions.edge),
            child: DateWidget(
              controller: dateController,
              title: container.birthday.name,
            ),
          ),
        if (container?.period != null)
          StreamBuilder<FieldSelectData>(
            stream: context.watch<ProgramDetailBloc>().periodTypeValue,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: StandardDimensions.edge),
                child: SelectorWidget(
                  divider: divider,
                  data: container.period,
                  title: container.period.name,
                  onChange:
                      context.watch<ProgramDetailBloc>().onUpdatePeriodType,
                ),
              );
            },
          ),
        if (container?.termin != null)
          StreamBuilder<int>(
              stream: context.watch<ProgramDetailBloc>().terminTypeValue,
              initialData: container.termin.min,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: StandardDimensions.edge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(container.termin.name),
                      divider,
                      SliderWidget(
                        pay: RangeNum(
                          multiplicity: 1,
                          min: container.termin.min,
                          max: container.termin.max,
                        ),
                        value: snapshot.data,
                        onChange: context
                            .watch<ProgramDetailBloc>()
                            .onUpdateTerminType,
                      ),
                    ],
                  ),
                );
              }),
        if (container?.type != null)
          container.type.type == FieldType.radio
              ? StreamBuilder<FieldSelectData>(
                  stream: context.watch<ProgramDetailBloc>().payTypeValue,
                  initialData: container.type.fields.first,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: StandardDimensions.edge),
                      child: RadioWidget(
                        divider: divider,
                        field: container.type,
                        selected: snapshot.data,
                        onSelect:
                            context.watch<ProgramDetailBloc>().onUpdatePayType,
                        sum: sumTec,
                      ),
                    );
                  },
                )
              : StreamBuilder<FieldSelectData>(
                  stream: context.watch<ProgramDetailBloc>().sumTypeValue,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: StandardDimensions.edge),
                      child: SelectorWidget(
                        divider: divider,
                        data: container.type,
                        title: container.type.name,
                        onChange:
                            context.watch<ProgramDetailBloc>().onUpdateSumType,
                      ),
                    );
                  },
                ),
      ],
    );
  }
}
