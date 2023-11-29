import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/ui/screens/confrim_order/confrim_order_screen.dart';
import 'package:forte_life/ui/screens/sms/sms_bloc.dart';
import 'package:forte_life/ui/screens/sms/widgets/sms_input_widget.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widgets/sms_repeat_widget.dart';

class SMSConfrimScreen extends StatefulWidget {
  const SMSConfrimScreen({
    Key key,
    this.title,
    this.phone,
    this.orderMap,
    this.detail,
  }) : super(key: key);

  final String title;
  final String phone;
  final Map<String, dynamic> orderMap;
  final Map<String, String> detail;
  @override
  _SMSConfrimScreenState createState() => _SMSConfrimScreenState();
}

class _SMSConfrimScreenState extends State<SMSConfrimScreen> {
  SMSInputBloc _bloc;
  bool _isCheckingNow = false;
  @override
  void initState() {
    _bloc = SMSInputBloc(
      Provider.of<DI>(
        context,
        listen: false,
      ).programService,
      phone: widget.phone,
      orderMap: widget.orderMap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar("${Strings.program} «${widget.title}»"),
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
                  'Введіть код перевірки',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SMSInputWidget(
                  clearError: _bloc.clearError,
                  isError: snapshot.data,
                  onFinished: validatePin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: snapshot.data
                    ? Text(
                        'Введено невірний код',
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          color: StandardColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        'Не прийшло смс?',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
              SMSRepeatWidget(
                sendSMS: _bloc.sendSMS,
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
          onPressed: () {},
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
    super.dispose();
  }

  void validatePin(String pin) {
    if (!_isCheckingNow) {
      _isCheckingNow = true;
      _bloc.validatePin(pin).then(
        (value) {
          if (value.isNotEmpty) {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (_) => ConfrimOrderScreen(
                      title: widget.title,
                      oderID: value,
                      detail: widget.detail,
                    ),
                  ),
                )
                .then(
                  (value) => _isCheckingNow = false,
                );
          } else {
            _isCheckingNow = false;
          }
        },
      );
    }
  }
}
