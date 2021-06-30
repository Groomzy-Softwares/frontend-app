import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../../common/constants/constants.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    if (errorMessage != null) {
      return AndroidAlertDialog(
        title: 'Error',
        message: Text(
          errorMessage,
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white12,
          ),
          child: Image.asset(
            LOGO_IMAGE,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: mediaQuery.size.height * 0.02),
        Card(
          child: GestureDetector(
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.whatsappSquare,
                color: Colors.lightGreen,
              ),
              title: Text(
                '+27 67 135 0513',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              if (await canLaunch(
                  'https://api.whatsapp.com/send?phone=+27671350513')) {
                await launch(
                    'https://api.whatsapp.com/send?phone=+27671350513');
                setState(() {
                  errorMessage = null;
                });
              } else {
                setState(() {
                  errorMessage = 'Could not launch whatsapp';
                });
              }
            },
          ),
        ),
        Divider(),
        Card(
          child: GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.redAccent,
              ),
              title: Text(
                'helpme@groomzy.co.za',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              if (await canLaunch('mailto:helpme@groomzy.co.za')) {
                await launch('mailto:helpme@groomzy.co.za');
                setState(() {
                  errorMessage = null;
                });
              } else {
                setState(() {
                  errorMessage = 'Could not launch mail';
                });
              }
            },
          ),
        ),
        Divider(),
        Card(
          child: GestureDetector(
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.instagramSquare,
                color: Colors.pinkAccent,
              ),
              title: Text(
                'groomzy_',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              if (await canLaunch('https://instagram.com/groomzy_')) {
                await launch('https://instagram.com/groomzy_');
                setState(() {
                  errorMessage = null;
                });
              } else {
                setState(() {
                  errorMessage = 'Could not launch instagram';
                });
              }
            },
          ),
        ),
        Divider(),
        Card(
          child: GestureDetector(
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.twitterSquare,
                color: Colors.lightBlueAccent,
              ),
              title: Text(
                '@groomzy_',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              if (await canLaunch('https://twitter.com/groomzy_')) {
                await launch('https://twitter.com/groomzy_');
                setState(() {
                  errorMessage = null;
                });
              } else {
                setState(() {
                  errorMessage = 'Could not launch twitter';
                });
              }
            },
          ),
        ),
        Divider(),
        Card(
          child: GestureDetector(
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.facebookSquare,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Groomzy',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              if (await canLaunch('https://facebook.com/groomzy')) {
                await launch('https://facebook.com/groomzy');
                setState(() {
                  errorMessage = null;
                });
              } else {
                setState(() {
                  errorMessage = 'Could not launch facebook';
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
