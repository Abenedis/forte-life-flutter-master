import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/contact/widgets/contact_textfield.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/utils/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController _nameTec;
  TextEditingController _phoneTec;
  TextEditingController _emailTec;
  TextEditingController _messageTec;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameTec = TextEditingController();
    _phoneTec = TextEditingController();
    _emailTec = TextEditingController();
    _messageTec = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar('Інформація'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                child: Text(
                  'У вас є питання?',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    fontSize: StandardDimensions.text_big_title,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ContactInputField(
                controller: _nameTec,
                keyboardType: TextInputType.name,
                validator: Validator.empty,
                label: 'Ім\'я',
              ),
              ContactInputField(
                controller: _phoneTec,
                keyboardType: TextInputType.phone,
                validator: Validator.phone,
                label: 'Телефон',
                hint: '123456789',
                maxLength: 9,
                prefix: Text(
                  '+380',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ContactInputField(
                controller: _emailTec,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.email,
                label: 'Email',
              ),
              ContactInputField(
                controller: _messageTec,
                keyboardType: TextInputType.name,
                validator: Validator.empty,
                minLines: 5,
                label: 'Повідомлення',
              ),
              Padding(
                padding: const EdgeInsets.all(
                  StandardDimensions.edge,
                ),
                child: RaisedButton(
                  onPressed: _onNextPressed,
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 56,
                    child: Center(
                      child: Text('Відправити'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onNextPressed() async {
    if (_formKey.currentState.validate()) {
      showDialog(
        context: context,
        builder: (_) => Loading(
          color: StandardColors.primaryColor,
        ),
      );
      final url =
          'https://forte-life.com.ua/index.php?dispatch=api.get_callback_data&api_key=EhkL2ftCX3YsA4zM5wQYQ4FTD9JGEKeEAR5WSjWBwjJ2m5Pr4h';
      await (Dio()
            ..interceptors.add(
              LogInterceptor(
                responseBody: true,
                requestHeader: false,
                responseHeader: false,
                requestBody: true,
              ),
            ))
          .post(
        url,
        data: <String, dynamic>{
          'name': _nameTec.text,
          'phone': '+380' + _phoneTec.text,
          'email': _emailTec.text,
          'message': _messageTec.text,
        },
      ).whenComplete(
        () => Navigator.of(context).pop(),
      );
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Text('Повідомлення успішно відправлено'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            )
          ],
        ),
      );

      _nameTec?.clear();
      _phoneTec?.clear();
      _emailTec?.clear();
      _messageTec?.clear();
    }
  }

  @override
  void dispose() {
    _nameTec?.dispose();
    _phoneTec?.dispose();
    _emailTec?.dispose();
    _messageTec?.dispose();
    super.dispose();
  }
}
