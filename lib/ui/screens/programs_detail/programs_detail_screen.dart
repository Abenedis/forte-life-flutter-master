import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/core/models/program/program_detail.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/ui/screens/calculation/calculation_result_popup.dart';
import 'package:forte_life/ui/screens/program_form/program_form_screen.dart';
import 'package:forte_life/ui/screens/programs_detail/program_detail_bloc.dart';
import 'package:forte_life/ui/screens/programs_detail/widgets/program_detail_content.dart';
import 'package:forte_life/ui/screens/programs_detail/widgets/program_detail_fields.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/date/date_controlled.dart';
import 'package:forte_life/ui/widget/easy_stream_builder.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:forte_life/utils/program_id.dart';
import 'package:provider/provider.dart';

import '../../error_widget_mixin.dart';

class ProgramDetailsScreen extends StatefulWidget {
  const ProgramDetailsScreen({Key key, this.program}) : super(key: key);
  final Program program;
  @override
  _ProgramDetailsScreenState createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen>
    with ErrorWidgetMixin {
  ProgramDetailBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateController _dateController;
  TextEditingController _sumTec;
  @override
  void initState() {
    _bloc = ProgramDetailBloc(
      Provider.of<DI>(context, listen: false).programService,
      widget.program,
    );
    initErrorTimer();
    _sumTec = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar(
        "${Strings.program} «${widget.program.name}»",
      ),
      body: Provider<ProgramDetailBloc>(
        create: (_) => _bloc,
        child: EasyStreamBuilder<ProgramDetail>(
          stream: _bloc.subject.stream,
          error: (_) => Center(
            child: Text('Немає данних на сервері'),
          ),
          withoudData: (_) => const Loading(
            color: StandardColors.primaryColor,
          ),
          builder: (context, snapshot) {
            if (_dateController ==
                null) if (snapshot.data.fields.calc?.birthday != null)
              _dateController = DateController(
                snapshot.data.fields.calc.birthday.min,
                snapshot.data.fields.calc.birthday.max,
              );
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: <Widget>[
                    ProgramDetailContent(
                      content: snapshot.data.contentData,
                      programName: widget.program?.name ?? '',
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(StandardDimensions.edge),
                      child: Text(
                        Strings.calculate_insurance,
                        style: TextStyle(
                          fontSize: StandardDimensions.text_big,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: StandardDimensions.edge),
                      child: ProgramDetailFields(
                        container: snapshot.data.fields?.calc,
                        sumTec: _sumTec,
                        dateController: _dateController,
                      ),
                    ),
                    errorWidget,
                    Padding(
                      padding: const EdgeInsets.all(StandardDimensions.edge),
                      child: RaisedButton(
                        onPressed: _onCalculatePressed,
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(child: Text(Strings.calculate)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: StandardDimensions.edge,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc?.dispose();
    _sumTec?.dispose();
    super.dispose();
  }

  Future<void> _onCalculatePressed() async {
    FocusScope.of(context).unfocus();
    final bool isDateValidated = _dateController?.validate() ?? true;
    if (_formKey.currentState.validate() && isDateValidated) {
      showDialog(
        context: context,
        builder: (_) => Loading(
          color: StandardColors.primaryColor,
        ),
      );
      await _bloc
          .calculateInfo(
        _sumTec.text,
        _dateController?.getDateTime?.toIso8601String(),
      )
          .then(
        (value) {
          return showDialog(
            context: context,
            builder: (_) => CalculationResult(
              calculationResponse: value,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgramFormScreen(
                      program: widget.program,
                      zayava: _bloc.subject.value.fields.zayava,
                      photo: _bloc.subject.value.fields.photo,
                      dateTitle: _dateController?.getDate,
                      birthday: _dateController?.getDateTime,
                      payload: _bloc.payload.toJson(),
                      url: _bloc.subject.value.ofertaUrl,
                      detail: widget.program.id == ProgramID.wels
                          ? <String, String>{
                              'Сума в доларах': value.price,
                            }
                          : <String, String>{
                              'Сума в гривнях': value.price,
                            },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ).whenComplete(
        () => Navigator.of(context).pop(),
      );
    } else
      showError();
  }
}
