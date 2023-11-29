import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/core/models/news_model.dart';
import 'package:forte_life/ui/widget/easy_stream_builder.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:provider/provider.dart';

import 'news_bloc.dart';
import 'news_list_item.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateNewsScreen();
}

class _StateNewsScreen extends State<NewsScreen> {
  NewsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<NewsBloc>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: StandardColors.accentColor,
        body: EasyStreamBuilder<List<News>>(
          stream: _bloc.subject.stream,
          builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 100, top: 16),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  NewsListItem(snapshot.data[index]),
            );
          },
          withoudData: (context) => Loading(color: StandardColors.primaryColor),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
