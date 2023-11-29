import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/utils/url_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreenCache extends StatefulWidget {
  final String title;
  final int objectId;
  final bool isWithPadding;
  final String path;
  const WebScreenCache({
    Key key,
    this.title = '',
    this.isWithPadding = true,
    this.objectId,
    this.path = '',
  }) : super(key: key);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreenCache> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  StreamController<bool> _loadingStremController;
  String htmlText;
  @override
  void initState() {
    super.initState();
    _loadingStremController = StreamController<bool>()..add(true);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) => ConnectivityScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<bool>(
            stream: _loadingStremController.stream,
            initialData: true,
            builder: (context, snapshot) {
              final bool isInProgress = snapshot.hasData && snapshot.data;
              return Stack(
                children: [
                  Opacity(
                    opacity: isInProgress ? 0.0 : 1.0,
                    child: WebView(
                      initialUrl: '',
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                        _loadHtmlFromAssets();
                      },
                      navigationDelegate: (NavigationRequest request) {
                        if (!request.url
                            .startsWith('data:text/html;charset=utf-8')) {
                          UrlHelper.open(request.url);
                          return null;
                        }
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (url) {
                        if (widget.isWithPadding) {
                          _controller.future.then(
                            (value) => value.evaluateJavascript(
                                'window.document.body.style.padding = "16px";'),
                          );
                        }
                      },
                      onPageFinished: (String url) async {
                        _loadingStremController.add(false);
                        debugPrint('PAGE LOADING FINISHED: $url');
                        if (widget.isWithPadding) {
                          _controller.future.then(
                            (value) => value.evaluateJavascript(
                                'window.document.body.style.padding = "16px";'),
                          );
                        }
                      },
                    ),
                  ),
                  if (isInProgress)
                    Center(
                      child: Loading(
                        color: StandardColors.primaryColor,
                      ),
                    ),
                ],
              );
            }),
      );

  Future<void> _loadHtmlFromAssets() async {
    String fileText =
        await rootBundle.loadString('assets/$path/${widget.objectId}.html');
    _controller.future.then(
      (value) => value.loadUrl(
        Uri.dataFromString(
          fileText,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
      ),
    );
  }

  @override
  void dispose() {
    _loadingStremController?.close();
    super.dispose();
  }

  String get path => widget.path.isEmpty ? 'info' : 'news';
}
