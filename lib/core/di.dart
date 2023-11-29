import 'package:forte_life/core/services/blinchiki_service.dart';
import 'package:forte_life/core/services/info_service.dart';
import 'package:forte_life/core/services/news_service.dart';
import 'package:forte_life/core/services/program_service.dart';
import 'package:forte_life/core/web/blinchiki_ws_impl.dart';
import 'package:forte_life/core/web/info_ws_impl.dart';
import 'package:forte_life/core/web/news_ws_impl.dart';
import 'package:forte_life/core/web/program_ws_impl.dart';

class DI {
  final InfoService infoService;
  final NewsService newsService;
  final ProgramService programService;
  final BlinchikiService blinchikiService;

  DI(client)
      : infoService = InfoWebServiceImpl(client),
        programService = ProgramWebServiceImpl(client),
        blinchikiService = BlinchikiWSImpl(client),
        newsService = NewsWebServiceImpl(client);
}
