import 'dart:async';
import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listContato.dart';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:Agenda_de_Lembretes/notificacao/listaNotificacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificar extends StatefulWidget {
  final User notificarUser;
  const Notificar({Key key, this.notificarUser}) : super(key: key);

  @override
  _NotificarState createState() => new _NotificarState();
}

class _NotificarState extends State<Notificar> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String _selectedParam;
  var task;
  int val;

  @override
  initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        //'slow_spring_board',
        importance: Importance.max,
        priority: Priority.max);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var scheduledTime;
    if (_selectedParam == "Dias") {
      scheduledTime = DateTime.now().add(Duration(days: val));
    } else if (_selectedParam == "Horas") {
      scheduledTime = DateTime.now().add(Duration(hours: val));
    } else if (_selectedParam == "Minutos") {
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    }

    // ignore: deprecated_member_use
    flutterLocalNotificationsPlugin.schedule(
        1, "Ligar Para:", task, scheduledTime, platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  final formkeyNotif = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String nome = widget.notificarUser.name;

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Adicionar Lembrete'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListNotificarcao();
                },
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Form(
          key: formkeyNotif,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    initialValue: "test", //nome,
                    onChanged: (_val) {
                      setState(() {
                        task = _val;
                      });
                    },
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Divider(indent: 70),
                      Text(
                        "Notificar em:    ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        value: _selectedParam,
                        items: [
                          DropdownMenuItem(
                            child: Text("Minutos"),
                            value: "Minutos",
                          ),
                          DropdownMenuItem(
                            child: Text("Horas"),
                            value: "Horas",
                          ),
                          DropdownMenuItem(
                            child: Text("Dias"),
                            value: "Dias",
                          ),
                        ],
                        hint: Text(
                          "Selecione",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onChanged: (_val) {
                          setState(
                            () {
                              _selectedParam = _val;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Divider(indent: 70),
                      Text(
                        "Tempo:   ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        value: val,
                        items: [
                          DropdownMenuItem(
                            child: Text("1"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("2"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("3"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("4"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("5"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("6"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("7"),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text("8"),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text("9"),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text("10"),
                            value: 10,
                          ),
                        ],
                        hint: Text(
                          "Selecione",
                          style: TextStyle(color: Colors.red),
                        ),
                        onChanged: (_val) {
                          setState(() {
                            val = _val;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: FloatingActionButton.extended(
                  label: Text("Enviar"),
                  icon: Icon(Icons.notifications_active),
                  onPressed: () {
                    setState(() {
                      print(task);
                      _showNotificationWithSound();
                      notificarr.add(NotificarUser(
                          whenNotific: '$_selectedParam',
                          timeNotific: '$val',
                          userNotific: '$task'));
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListNotificarcao();
                          },
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
