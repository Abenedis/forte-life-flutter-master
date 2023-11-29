import 'package:forte_life/core/models/calculate_program_entity.dart';
import 'package:forte_life/core/models/label_model.dart';
import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/core/models/program/popup_program_response.dart';
import 'package:forte_life/core/models/program/program_detail.dart';
import 'package:forte_life/core/models/program_calculation_response_model.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/core/services/program_service.dart';
import 'package:forte_life/ui/base_bloc.dart';
import 'package:forte_life/utils/program_id.dart';
import 'package:rxdart/subjects.dart';

class ProgramDetailBloc extends BaseBloc<ProgramDetail> {
  ProgramDetailBloc(this._programService, this._program) {
    _fetch();
  }

  final ProgramService _programService;
  final Program _program;

  Future<void> _fetch() async {
    final res = await _programService.getProgramById(_program.id);
    if (res.contentData != null) {
      subject.add(res);
      if (res.fields.calc?.type?.type == FieldType.radio ?? false) {
        if (res.fields.calc.type.fields != null) {
          _payType.add(res.fields.calc.type.fields.first);
          if (res.fields.calc.type.fields.first.isHasPay) {
            _paySum.add(res.fields.calc.type.fields[0].pay?.min ?? 0);
          } else if (res.fields.calc.type.fields[1].isHasPay) {
            _paySum.add(res.fields?.calc?.type?.fields[1]?.pay?.min ?? 0);
          }
        }
      }
      if (res.fields.calc?.termin != null)
        _terminType.add(res.fields.calc.termin.min);
    } else
      subject.addError(Exception('Invalidate data from server'));
  }

  CalculateProgramEntity payload;
  final BehaviorSubject<int> _paySum = BehaviorSubject<int>();
  Stream<int> get paySumValue => _paySum.stream;
  void onUpdatePaySum(int value) => _paySum.add(value);

  final BehaviorSubject<FieldSelectData> _payType =
      BehaviorSubject<FieldSelectData>();
  Stream<FieldSelectData> get payTypeValue => _payType.stream;
  void onUpdatePayType(FieldSelectData value) => _payType.add(value);

  final BehaviorSubject<FieldSelectData> _periodType =
      BehaviorSubject<FieldSelectData>();
  Stream<FieldSelectData> get periodTypeValue => _periodType.stream;
  void onUpdatePeriodType(FieldSelectData value) => _periodType.add(value);

  final BehaviorSubject<FieldSelectData> _sumType =
      BehaviorSubject<FieldSelectData>();
  Stream<FieldSelectData> get sumTypeValue => _sumType.stream;
  void onUpdateSumType(FieldSelectData value) => _sumType.add(value);

  final BehaviorSubject<int> _terminType = BehaviorSubject<int>();
  Stream<int> get terminTypeValue => _terminType.stream;
  void onUpdateTerminType(int value) => _terminType.add(value);

  Future<CalculationResponse> calculateInfo(
      String strahSuma, String birthday) async {
    payload = getCalculation(strahSuma, birthday);
    final PopupProgramResponse price =
        await _programService.calculateProgram(payload);

    return CalculationResponse(
      image: subject.value.contentData.banner,
      title: 'Програма «${_program.name}»',
      labels: getLabelsForPopup(strahSuma, price),
      price: _getPrice(strahSuma, price),
    );
  }

  String _getPrice(String strahSuma, PopupProgramResponse price) {
    if (subject.value.fields.calc?.type?.type == FieldType.radio) {
      if ((_payType.value == subject.value.fields.calc?.type?.fields?.first) ??
          false) {
        return price.price.toString();
      } else {
        return subject.value.fields.calc.type.fields.first.isHasPay
            ? strahSuma
            : _paySum?.value?.toString();
      }
    } else
      return price.price.toString();
  }

  CalculateProgramEntity getCalculation(String strahSuma, String birthday) =>
      CalculateProgramEntity(
        period: _periodType.value?.value,
        strahSumm: subject.value.fields.calc.type.fields.first.isHasPay
            ? _paySum?.value
            : int.tryParse(strahSuma),
        termin: _terminType?.value,
        type: _payType.value?.value,
        vnesok: (subject.value.fields.calc?.type?.type == FieldType.radio)
            ? subject.value.fields.calc.type.fields.first.isHasPay
                ? int.tryParse(strahSuma)
                : _paySum?.value
            : _sumType?.value?.value,
        birthday: birthday,
        programmId: _program.id,
      );

  @override
  void dispose() {
    super.dispose();
    _paySum.close();
    _payType.close();
  }

  List<Label> getLabelsForPopup(String strahSuma, PopupProgramResponse price) {
    final String currency = subject.value.currency;
    if (_program.id == ProgramID.wels || _program.id == ProgramID.obligatcii) {
      return <Label>[
        Label('Термін дії договору, років', price.termin.toStringAsFixed(0)),
        if (_program.id == ProgramID.wels)
          Label('Період оплати, років', price.terminPay.toString()),
        Label('Періодичність оплати', price.period.toString()),
        Label('Страховий внесок', price.price.toString() + ' $currency'),
        Label('Ризик Дожиття', price.ruzukLife.toString() + ' $currency'),
        Label('Ризик Смерть', price.ruzukDeath.toString()),
      ];
    }
    final list = <Label>[
      if ((_terminType?.value?.toString() ?? '').isNotEmpty)
        Label(
          'Термін дії договору, років',
          _terminType.value.toStringAsFixed(0),
        ),
      if ((_terminType?.value?.toString() ?? '').isNotEmpty)
        Label('Періодичність оплати', _periodType.value?.name),
      if (subject.value.fields.calc?.type?.type == FieldType.radio)
        if ((_payType.value ==
                subject.value.fields.calc?.type?.fields?.first) ??
            false) ...[
          Label('Страховий внесок', '${price.price} $currency'),
          Label('Ризик Дожиття',
              '${subject.value.fields.calc.type.fields.first.isHasPay ? _paySum?.value : int.tryParse(strahSuma)} $currency'),
        ] else ...[
          Label('Страховий внесок',
              '${subject.value.fields.calc.type.fields.first.isHasPay ? int.tryParse(strahSuma) : _paySum?.value} $currency'),
          Label('Ризик Дожиття', '${price.price} $currency'),
        ]
      else ...[
        Label('Страховий внесок', '${price.price} $currency'),
      ],
      Label(
        'Ризик Смерть',
        _program.id == ProgramID.wels ? '\$200' : 'Повернення внесків',
      ),
      if (price.trauma != null && _program.id == ProgramID.kids)
        Label(
          'Тілесні ушкодження',
          '${price.trauma} $currency',
        ),
    ];

    return list;
  }
}
