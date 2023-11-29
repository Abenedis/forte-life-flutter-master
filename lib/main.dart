import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/ui/screens/news/news_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app/theme.dart';
import 'core/client/http_client.dart';
import 'core/di.dart';
import 'ui/screens/main/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    await Firebase.initializeApp();
    runApp(new MyApp());
  });
}

final Connectivity connectivity = Connectivity();

class MyApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<DI>(
          create: (_) => DI(AppHttpClient()),
        ),
      ],
      child: Provider<NewsBloc>(
        create: (ctx) {
          final bloc = NewsBloc(
            ctx.read<DI>().newsService,
          );
          return bloc;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: StandardTheme.create(),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: MainScreen(),
          ),
        ),
      ),
    );
  }
}
