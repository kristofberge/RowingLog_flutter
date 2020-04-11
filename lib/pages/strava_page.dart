import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rowing_log/bloc/bloc.dart';
import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

class StravaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strava data'),
      ),
      body: BlocBuilder<StravaBloc, StravaState>(
        builder: (BuildContext context, StravaState state) {
          if (state is InitialStravaState) {
            BlocProvider.of<StravaBloc>(context).add(StravaPageOpenedEvent());
            return _loadingView();
          } else if (state is StravaNotLoggedInState) {
            return _webView(context);
          } else if (state is StravaLoggedInState) {
            return _stravaContent(state);
          }
          return Text('Invalid state');
        },
      ),
    );
  }

  Widget _stravaContent(StravaLoggedInState state) {
    var user = state.user;
    return Column(
      children: [
        _loggedInHeader(user),
        BlocBuilder<ActivitiesBloc, ActivitiesState>(
          builder: (BuildContext context, ActivitiesState state) {
            if (state is InitialActivitiesState) {
              BlocProvider.of<ActivitiesBloc>(context).add(ActivitiesListDisplayed());
              return _loadingView();
            }
            if (state is FirstPageLoadedState) {
              var items = state.activities.toList();
              return Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(user.avatar),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].name,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _getIcon(items[index].type),
                                          size: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: Text(
                                            _formatDateTime(items[index].startTime),
                                            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 20.0, color: Colors.grey),
                ),
              );
            }
            return Text('Invalid state');
          },
        )
      ],
    );
  }

  IconData _getIcon(ActivityType type) {
    switch (type) {
      case ActivityType.RoadCycling:
        return Icons.directions_bike;
      case ActivityType.Run:
        return Icons.directions_run;
      case ActivityType.WaterRowing:
        return Icons.rowing;
      case ActivityType.Hike:
        return Icons.landscape;
      case ActivityType.Walk:
        return Icons.directions_walk;
      default:
        return Icons.tag_faces;
    }
  }

  Padding _loggedInHeader(StravaUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('${user.firstName} ${user.lastName}'),
                    ),
                    Text(
                      '@${user.userName}',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'YOUR ACTIVITIES',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Center _webView(BuildContext context) {
    return Center(
      child: WebView(
        initialUrl:
            'https://www.strava.com/oauth/authorize?client_id=40941&response_type=code&redirect_uri=https://rowinglog&approval_prompt=auto&scope=read,activity:read',
        userAgent:
            'Mozilla/5.0 (Linux; Android 4.1.1; Galaxy Nexus Build/JRO03C) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19',
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (urlString) {
          var uri = Uri.parse(urlString);
          if (urlString.startsWith('https://rowinglog')) {
            var code = uri.queryParameters['code'];
            BlocProvider.of<StravaBloc>(context).add(StravaCodeReceivedEvent(code));
          }
        },
      ),
    );
  }

  Widget _loadingView() => Center(child: new CircularProgressIndicator());

  String _formatDateTime(DateTime dateTime) {
    var timeAgo = DateTime.now().difference(dateTime);
    if (timeAgo.inDays == 0) {
      return 'Today at  ${DateFormat('HH:mm').format(dateTime)}';
    } else if (timeAgo.inDays == 1) {
      return 'Yesterday at ${DateFormat('HH:mm').format(dateTime)}';
    }
    return '${DateFormat('MMMM d, yyyy').format(dateTime)} at ${DateFormat('H:mm').format(dateTime)}';
  }
}
