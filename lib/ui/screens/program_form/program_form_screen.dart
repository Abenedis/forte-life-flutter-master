import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/di.dart';
import 'package:forte_life/core/models/program/field_object.dart';
import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/core/models/program/photo.dart';
import 'package:forte_life/core/models/program/zayava_request.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/ui/screens/program_form/program_form_bloc.dart';
import 'package:forte_life/ui/screens/program_form/widget/general_field_widget.dart';
import 'package:forte_life/ui/screens/program_form/widget/passport_radio.dart';
import 'package:forte_life/ui/screens/sms/sms_confirm_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/date/date_controlled.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/ui/widget/photo/photo_controller.dart';
import 'package:forte_life/ui/widget/photo/photo_widget.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:forte_life/utils/url_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../error_widget_mixin.dart';

enum Passport {
  OLD,
  IDCARD,
}

class ProgramFormScreen extends StatefulWidget {
  const ProgramFormScreen({
    Key key,
    this.program,
    this.zayava,
    this.photo,
    this.dateTitle = '',
    this.birthday,
    this.payload,
    this.url,
    this.detail,
  }) : super(key: key);

  final Program program;
  final Map<String, FieldObject> zayava;
  final Photo photo;
  final String dateTitle;
  final DateTime birthday;
  final Map<String, dynamic> payload;
  final String url;
  final Map<String, String> detail;
  @override
  _ProgramFormScreenState createState() => _ProgramFormScreenState();
}

class _ProgramFormScreenState extends State<ProgramFormScreen>
    with ErrorWidgetMixin {
  Map<String, dynamic> controllersMap;
  PhotoController _passportController;
  PhotoController _idCardController;
  PhotoController _innController;
  PhotoController _birthdayController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BehaviorSubject<Passport> _passportSubj = BehaviorSubject<Passport>()
    ..add(Passport.OLD);

  ProgramFormBloc _bloc;
  static List<FieldSelectData> _pasportValues = <FieldSelectData>[
    FieldSelectData(name: 'Паспорт', value: 0),
    FieldSelectData(name: 'ID паспорт', value: 1),
  ];

  @override
  void initState() {
    initErrorTimer();

    controllersMap = widget.zayava.map<String, dynamic>((key, value) {
      dynamic controller;
      switch (value.type) {
        case FieldType.input:
        case FieldType.email:
        case FieldType.phone:
        case FieldType.textArea:
        case FieldType.number:
          controller = TextEditingController();
          break;
        case FieldType.date:
          controller = DateController(
            value?.min ?? 0,
            value?.max ?? 100,
          );
          break;
        default:
          break;
      }
      if (controller != null) return MapEntry(key, controller);
      return MapEntry(null, null);
    })
      ..removeWhere((key, value) => key == null || value == null);
    _passportController = PhotoController(10);
    _idCardController = PhotoController(3);
    _birthdayController = PhotoController(2);
    _innController = PhotoController(2);
    super.initState();
    _bloc = ProgramFormBloc(context.read<DI>().programService);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar("${Strings.program} «${widget.program.name}»"),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Заповніть поля для продовження',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              if (widget.dateTitle != null && widget.dateTitle.isNotEmpty)
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                        'Дата народження Застрахованої особи',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        widget.dateTitle,
                      ),
                    ),
                  ],
                ),
              ...widget.zayava.keys
                  .map<Widget>(
                    (key) => GeneralFieldWidget(
                      field: widget.zayava[key],
                      controller: controllersMap[key],
                    ),
                  )
                  .toList(),
              Padding(
                padding: const EdgeInsets.all(
                  StandardDimensions.normal,
                ).copyWith(bottom: 0.0),
                child: StreamBuilder<Passport>(
                  stream: _passportSubj.stream,
                  initialData: Passport.OLD,
                  builder: (context, snapshot) {
                    return PassportRadio(
                      first: _pasportValues[0],
                      second: _pasportValues[1],
                      selected: _pasportValues[snapshot.data.index],
                      onSelect: (select) => _passportSubj.add(
                        Passport.values[_pasportValues.indexOf(select)],
                      ),
                      child: snapshot.data == Passport.OLD
                          ? PhotoWidget(
                              title: 'Додайте фото паспорта',
                              description:
                                  '1 сторінка, 2-3 сторінка, 4-5 сторінка (якщо є)11-13 сторінка (поточне місце проживання)',
                              controller: _passportController,
                            )
                          : PhotoWidget(
                              title: 'Додайте фото паспорта',
                              description: 'ID паспорт 1-2 сторінка + витяг',
                              controller: _idCardController,
                            ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: StandardDimensions.edge,
                ),
                child: PhotoWidget(
                  title: 'Додайте фото ІНН',
                  description: '',
                  controller: _innController,
                ),
              ),
              if (widget.photo != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: StandardDimensions.edge,
                  ),
                  child: PhotoWidget(
                    title: widget.photo.title,
                    description: '',
                    controller: _birthdayController,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(
                  StandardDimensions.edge,
                ),
                child: Wrap(
                  children: [
                    Text(' З '),
                    ...'умовами договору страхування'.split(' ').map<Widget>(
                          (s) => GestureDetector(
                            onTap: () {
                              if (widget.url.endsWith('.pdf')) {
                                UrlHelper.open(widget.url);
                              } else
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => WebScreen(
                                      url: widget.url,
                                      title: 'Умови страхування',
                                    ),
                                  ),
                                );
                            },
                            child: Text(
                              '$s ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                    ...'ознайомлений. Погоджуюся отримувати кореспонденцію на електронну адресу'
                        .split(' ')
                        .map<Widget>(
                          (s) => Text(' $s'),
                        ),
                  ],
                ),
              ),
              errorWidget,
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
                      child: Text(Strings.Continue),
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

  @override
  void dispose() {
    controllersMap.forEach((key, value) {
      value?.dispose();
    });
    _passportController?.dispose();
    _innController?.dispose();
    _birthdayController?.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    final bool isValidForm = _formKey.currentState.validate();

    final setResult = controllersMap.values.map<bool>((c) {
      try {
        return c.validate();
      } catch (e) {
        return true;
      }
    }).toSet();

    if (isValidForm && setResult.length == 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Loading(
          color: StandardColors.primaryColor,
        ),
      );
      if (controllersMap.containsKey('surname_strah') &&
          controllersMap.containsKey('name_strah') &&
          controllersMap.containsKey('patronymic_strah')) {
        widget.detail['ПІБ Страхувальника'] =
            controllersMap['surname_strah'].text +
                ' ' +
                controllersMap['name_strah'].text +
                ' ' +
                controllersMap['patronymic_strah'].text;
      }
      if (controllersMap.containsKey('surname') &&
          controllersMap.containsKey('name') &&
          controllersMap.containsKey('patronymic')) {
        widget.detail['ПІБ Застрахованої особи'] =
            controllersMap['surname'].text +
                ' ' +
                controllersMap['name'].text +
                ' ' +
                controllersMap['patronymic'].text;
      }
      if (controllersMap.containsKey('email')) {
        widget.detail['Email'] = controllersMap['email'].text;
      }
      if (!isNotEmptyDateTitle) {
        widget.detail['Дата народження Застрахованої особи'] =
            controllersMap['birthday'].getDate;
      }
      _bloc
          .requestCode(
        ZayavaRequest(
          fields: controllersMap.map((key, value) {
            if (widget.zayava[key].type == FieldType.date)
              return MapEntry(key, value.getDateTime.toIso8601String());
            else {
              if (widget.zayava[key].type == FieldType.phone) {
                return MapEntry(key, '+380' + value.text);
              } else
                return MapEntry(key, value.text);
            }
          })
            ..addAll(widget.payload)
            ..['inn'] = _innController.getBase64Images()
            ..['passport'] = _passportSubj.value == Passport.OLD
                ? _passportController.getBase64Images()
                : _idCardController.getBase64Images()
            ..['photo'] = _birthdayController?.getBase64Images(),
          birthday:
              isNotEmptyDateTitle ? widget.birthday.toIso8601String() : null,
        ),
      )
          .then(
        (value) {
          Navigator.of(context).pop();
          if (value != null ?? false) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SMSConfrimScreen(
                  title: widget.program.name,
                  phone: '+380' + controllersMap['phone'].text,
                  orderMap: value,
                  detail: widget.detail,
                ),
              ),
            );
          }
        },
      );
    } else
      showError();
  }

  bool get isNotEmptyDateTitle =>
      widget.dateTitle != null && widget.dateTitle.isNotEmpty;
}
