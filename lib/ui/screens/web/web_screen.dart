import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/info/info_fab.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/utils/url_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  final String title;
  final String url;
  final void Function(String, WebViewController controller) urlListener;
  final bool isWithPadding;
  final bool isCallback;
  const WebScreen({
    Key key,
    @required this.title,
    this.url,
    this.urlListener,
    this.isWithPadding = true,
    this.isCallback = false,
  }) : super(key: key);

  @override
  WebScreenState createState() => WebScreenState();
}

class WebScreenState extends State<WebScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  StreamController<bool> _loadingStremController;

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
          title: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Text(widget.title),
          ),
        ),
        body: StreamBuilder<bool>(
            stream: _loadingStremController.stream,
            initialData: true,
            builder: (context, snapshot) {
              final bool isInProgress = snapshot.hasData && snapshot.data;
              return Stack(
                children: <Widget>[
                  Opacity(
                    opacity: isInProgress ? 0.0 : 1.0,
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      debuggingEnabled: false,
                      onWebResourceError: (err) {
                        debugPrint(err.toString());
                      },
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                        webViewController.currentUrl().then((value) {
                          if (value == null) {
                            webViewController
                                .loadUrl(Uri.encodeFull(widget.url));
                          }
                        });
                      },
                      navigationDelegate: (NavigationRequest request) {
                        debugPrint('NAVIGATE TO: ${request.url}');

                        if (widget.urlListener == null) {
                          if (widget.url.contains(
                              'https://forte-life.com.ua/ua/pay/?mobile=1')) {
                            if (request.url.endsWith('.pdf')) {
                              UrlHelper.open(request.url);
                              return null;
                            }
                            return NavigationDecision.navigate;
                          }

                          if (request.url != widget.url &&
                              !request.url
                                  .startsWith('https://www.google.com/')) {
                            UrlHelper.open(request.url);
                            return null;
                          }
                        }
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (url) {
                        debugPrint('PAGE STARTED FINISHED: $url');

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
                        if (widget.urlListener != null) {
                          final controller = await _controller.future;
                          widget.urlListener(url, controller);
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
        floatingActionButton:
            widget.isCallback ? InfoFab() : const SizedBox.shrink(),
      );

  @override
  void dispose() {
    _loadingStremController?.close();
    super.dispose();
  }
}
