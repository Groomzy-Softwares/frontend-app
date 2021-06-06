import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './android/main.dart';
import './ios/main.dart';
import './web/main.dart';
import './api/utils/utils.dart';

Future main() async {
  await dotenv.load();
  await initHiveForFlutter();

  runApp(App());
}

Widget getAppAccordingToCurrentPlatform() {
  if (Platform.isIOS) {
    // iOS application
    return IOSApp();
  } else if (kIsWeb) {
    // Web application
    return WebApp();
  }
  // Android application
  return AndroidApp();
}

class App extends StatefulWidget {
  // This widget is the root of the application.
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      '${dotenv.env['BACKEND_URL']}',
    );

    final WebSocketLink webSocketLink = new WebSocketLink(
      '${dotenv.env['BACKEND_WEB_SOCKET_URL']}',
    );

    String token;

    final AuthLink authLink = AuthLink(
      getToken: () async {
        token = await AuthUtil().getToken();

        return token != null ? 'Bearer $token' : null;
      },
    );

    final Link link = authLink.concat(httpLink).concat(webSocketLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: getAppAccordingToCurrentPlatform(),
    );
  }
}
