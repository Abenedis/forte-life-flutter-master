import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/order/order_info.dart';
import 'package:forte_life/ui/screens/confrim_order/widgets/confirm_info_label.dart';
import 'package:forte_life/ui/screens/payment/payment_error_screen.dart';
import 'package:forte_life/ui/screens/payment/payment_success_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/easy_stream_builder.dart';
import 'package:forte_life/utils/constants/api_constants.dart';
import 'package:forte_life/utils/constants/asset_images.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'confirm_order_bloc.dart';

class ConfrimOrderScreen extends StatefulWidget {
  const ConfrimOrderScreen({
    Key key,
    this.title,
    this.detail,
    this.oderID,
  }) : super(key: key);
  final String title;
  final String oderID;
  final Map<String, String> detail;
  @override
  _ConfrimOrderScreenState createState() => _ConfrimOrderScreenState();
}

class _ConfrimOrderScreenState extends State<ConfrimOrderScreen> {
  ConfirmOrderBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = ConfirmOrderBloc(widget.detail, widget.oderID);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar("${Strings.program} «${widget.title}»"),
      body: EasyStreamBuilder<OrderInfo>(
        stream: _bloc.subject.stream,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(StandardDimensions.edge),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        AssetsImages.ic_credit_card,
                        color: StandardColors.primaryColor,
                      ),
                      SizedBox(width: StandardDimensions.edge),
                      Flexible(
                        child: Text(
                          'Оплатити картою будь якого банку',
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(StandardDimensions.edge),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) => ConfirmInfoLabel(
                      title: snapshot.data.labels[index].title,
                      value: snapshot.data.labels[index].value,
                    ),
                    childCount: snapshot.data.labels.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 144,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: StandardDimensions.edge,
              ),
              child: RaisedButton(
                onPressed: _pay,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text('Оплатити'),
                  ),
                ),
              ),
            ),
            SizedBox(height: StandardDimensions.edge),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: StandardDimensions.edge,
              ),
              child: OutlineButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                borderSide: BorderSide(
                  color: StandardColors.selectedColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                textColor: StandardColors.selectedColor,
                highlightedBorderColor: StandardColors.selectedColor,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text('Виправити'),
                  ),
                ),
              ),
            ),
            SizedBox(height: StandardDimensions.edge),
          ],
        ),
      ),
    );
  }

  void _pay() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WebScreen(
          title: 'Оплата',
          isWithPadding: false,
          url: ApiConstants.paymentURL(widget.oderID),
          urlListener: (String url, WebViewController controller) async {
            if (url.startsWith(
                'https://forte-life.com.ua/index.php?dispatch=api.mobile_pay_response')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentSuccessScreen(
                    title: widget.title,
                  ),
                ),
              );
            } else {
              final html = await controller.evaluateJavascript(
                  'window.document.getElementsByTagName("html")[0].outerHTML;');
              final convertedHtml = String.fromCharCodes(html.codeUnits);
              if (convertedHtml
                  .contains(r'error-block alert alert-error msg-error')) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentErrorScreen(
                      title: widget.title,
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
