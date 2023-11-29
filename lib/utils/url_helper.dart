import 'package:url_launcher/url_launcher.dart';

abstract class UrlHelper {
  static void open(String url) => launch(url);
}
