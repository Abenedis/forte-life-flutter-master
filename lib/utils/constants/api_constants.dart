abstract class ApiConstants {
  static const String baseUrl = "https://forte-life.com.ua/";

  /*
   * timeout in milliseconds
   */
  static const int timeout = 15000;

  static const String apiKey =
      "EhkL2ftCX3YsA4zM5wQYQ4FTD9JGEKeEAR5WSjWBwjJ2m5Pr4h";

  static const String info = "api.get_pages";
  static const String programs = "api.get_programs";
  static const String program = "api.get_program";
  static const String calc = "api.get_calc_data";
  static const String request_code = "api.request_code";
  static const String confirm_code = "api.confirm_code";
  static const String news = "api.get_news";
  static const String confirm_code_blinchiki = "api.confirm_forton_dom";
  static const String calculate_blinchiki = "api.calculate_forton_dom";

  static const String single_info_url =
      "https://forte-life.com.ua/index.php?dispatch=pages.get_api_view&page_id=";

  static String paymentURL(String orderID) =>
      'https://forte-life.com.ua/index.php?dispatch=api.mobile_pay&nom_dog=$orderID&api_key=EhkL2ftCX3YsA4zM5wQYQ4FTD9JGEKeEAR5WSjWBwjJ2m5Pr4h';
}
