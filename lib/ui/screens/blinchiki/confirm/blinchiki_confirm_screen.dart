import 'package:flutter/material.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/ui/screens/blinchiki/calculate/blinchiki_calculate_screen.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'blinchiki_confirm_bloc.dart';
import 'widgets/blinchiki_code_widget.dart';

class BlinchikiConfirmScreen extends StatefulWidget {
  BlinchikiConfirmScreen({Key key}) : super(key: key);

  @override
  _BlinchikiConfirmScreenState createState() => _BlinchikiConfirmScreenState();
}

class _BlinchikiConfirmScreenState extends State<BlinchikiConfirmScreen> {
  BlinchikiConfirmBloc _bloc;
  TextEditingController _pinController;
  @override
  void initState() {
    _bloc = BlinchikiConfirmBloc(
      Provider.of<DI>(
        context,
        listen: false,
      ).blinchikiService,
    );
    _pinController = TextEditingController();
    _pinController.addListener(() {
      if (_pinController.text.length >= 7) {
        validatePin(_pinController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar('Код входу'),
      body: StreamBuilder<bool>(
        stream: _bloc.isHasError,
        initialData: false,
        builder: (context, snapshot) => AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Введіть код входу',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: BlinchikiCodeWidget(
                  clearError: _bloc.clearError,
                  controller: _pinController,
                  isError: snapshot.data,
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          StandardDimensions.edge,
        ),
        child: RaisedButton(
          onPressed: () => validatePin(_pinController.text),
          elevation: 8.0,
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Text(Strings.Continue),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _pinController?.dispose();
    super.dispose();
  }

  void validatePin(String pin) {
    _bloc.validatePin(pin).then((value) {
      if (value ?? false) {
        _pinController.clear();
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (_) => BlinchikiCalculateScreen(),
              ),
            )
            .then(
              (value) => _bloc.isSuccess = false,
            );
      }
    });
  }
}
