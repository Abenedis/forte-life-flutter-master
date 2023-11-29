import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:forte_life/core/models/news_model.dart';
import 'package:forte_life/core/services/news_service.dart';
import 'package:forte_life/ui/base_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsBloc extends BaseBloc<List<News>> {
  final NewsService newsService;
  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();

  NewsBloc(this.newsService);

  Stream<int> get count => _countSubject.stream;

  Future<void> initNews() async {
    final List<News> info = await newsService.getNews();
    subject.add(info);
    updateCaunter();
  }

  void updateCaunter([bool isRemoveIconBadge]) {
    SharedPreferences.getInstance().then(
      (prefs) {
        final List<String> oldListString =
            prefs.getStringList('count_list') ?? <String>[];
        final List<int> cached = oldListString.map<int>(int.parse).toList();
        int badge = _getBadge(cached, prefs);
        if (badge > subject.value.length) {
          badge = subject.value.length;
        }
        _countSubject.add(badge);
        FlutterAppBadger.updateBadgeCount(badge);

        if (isRemoveIconBadge ?? false) {
          FlutterAppBadger.removeBadge();
          prefs.setStringList(
            'count_list',
            subject.value.map<String>((n) => n.pageId.toString()).toList(),
          );
        }
      },
    );
  }

  int _getBadge(List<int> cached, SharedPreferences prefs) {
    int count = 0;
    subject.value.forEach((News n) {
      if (cached.contains(n.pageId)) {
        count++;
      }
    });
    if (count > 0) return subject.value.length - count;
    return prefs.getInt('count') ?? 0;
  }

  // void updateCaunter([bool isRemoveIconBadge]) {
  //   SharedPreferences.getInstance().then(
  //     (prefs) {
  //       final oldCount = prefs.getInt('count') ?? 0;
  //       final badge = subject.value.length - oldCount;
  //       _countSubject.add(badge);
  //       FlutterAppBadger.updateBadgeCount(badge);
  //       prefs.setInt(
  //         'count',
  //         subject.value.length,
  //       );
  //       if (isRemoveIconBadge ?? false) FlutterAppBadger.removeBadge();
  //     },
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    _countSubject?.close();
  }
}
