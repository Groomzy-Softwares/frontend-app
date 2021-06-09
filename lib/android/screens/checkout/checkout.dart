import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../client/main.dart';
import '../../widgets/loading/loading.dart';

class Checkout extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final double price;
  final int bookingId;
  final Function bookingStatusMutation;

  const Checkout({
    this.bookingId,
    this.bookingStatusMutation,
    this.description,
    this.name,
    this.price,
    this.category,
    Key key,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final _webViewController = new FlutterWebviewPlugin();

    final bool isProduction = kReleaseMode;
    final String payFastUrl = isProduction
        ? dotenv.env['PAYFAST_SANDBOX']
        : dotenv.env['PAYFAST_SANDBOX'];
    final String payFastMerchantId = isProduction
        ? dotenv.env['MERCHANT_ID_SANDBOX']
        : dotenv.env['MERCHANT_ID_SANDBOX'];
    final String payFastMerchantKey = isProduction
        ? dotenv.env['MERCHANT_KEY_SANDBOX']
        : dotenv.env['MERCHANT_KEY_SANDBOX'];
    final String successUrl = dotenv.env['SUCCESS_URL'];
    final String cancelUrl = dotenv.env['CANCEL_URL'];

    final String url = Uri.encodeFull(
        '$payFastUrl?merchant_id=$payFastMerchantId&merchant_key=$payFastMerchantKey&item_name=$name&item_description=$description&amount=$price&return_url=$successUrl&cancel_url=$cancelUrl');
    Future<void> _submit(bool status) async {
      try {
        await bookingStatusMutation({
          'bookingId': bookingId,
          'status': status,
        });
      } catch (error) {
        return;
      }
    }

    _webViewController.onUrlChanged.listen((String url) async {
      if (url == cancelUrl) {
        await _submit(false);
        _webViewController.close();
        Navigator.of(context).pop();
      }

      if (url == successUrl) {
        await _submit(true);
        _webViewController.close();
        Navigator.of(context).pushReplacementNamed(ClientScreen.routeName);
      }
    });

    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        elevation: 0,
        title: Text('Make payment'),
      ),
      initialChild: AndroidLoading(),
      withJavascript: true,
    );
  }
}
