import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rowing_log/bloc/activities_bloc.dart';
import 'package:rowing_log/bloc/strava_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:rowing_log/pages/concept2_page.dart';
import 'package:rowing_log/pages/strava_page.dart';

import 'pages/home_page.dart';

class RowingLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StravaBloc>(
          create: (context) => kiwi.Container().resolve<StravaBloc>(),
        ),
        BlocProvider<ActivitiesBloc>(
          create: (context) => kiwi.Container().resolve<ActivitiesBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        home: HomePage(),
        routes: {
          '/home': (context) => HomePage(),
          '/concept2': (context) => Concept2Page(),
          '/strava': (context) => StravaPage(),
        },
      ),
    );
  }
}
