import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listaContatos.dart';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:Agenda_de_Lembretes/notificacao/listaNotificacao.dart';
import 'package:Agenda_de_Lembretes/sql/databaseNotificar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificar extends StatefulWidget {
  final User notificarUser;
  const Notificar({Key key, this.notificarUser}) : super(key: key);

  @override
  _NotificarState createState() => new _NotificarState();
}

class _NotificarState extends State<Notificar> {
  //Inicio do codigo => Realizar o agendamento do lembrete
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String _selectedParam;
  int val;
  String d;

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

    //Comando referente ao Database/SQFlite
    _dbNoti = DatabaseNoti.instance;
    _refreshContactList();
    //fim do comando
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
    flutterLocalNotificationsPlugin.schedule(1, "Ligar Para:",
        widget.notificarUser.name, scheduledTime, platformChannelSpecifics);
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
  //Final do codigo

  final formkeyNotif = GlobalKey<FormState>();

  //Inico do comando relacionado a Persistencia dos dados
  NotificarUser notif = NotificarUser();
  DatabaseNoti _dbNoti;

  _refreshContactList() async {
    List<NotificarUser> x = await _dbNoti.fetchContacts();
    setState(() {
      notificarr = x;
    });
  }
  //Fim do comando

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Adicionar Lembrete'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListContat();
                },
              ),
            );
          },
        ),
      ),
      body: Form(
        key: formkeyNotif,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 40, right: 5, left: 5, bottom: 40),
            alignment: Alignment.center,
            height: 550,
            width: 300,
            child: Card(
              shadowColor: Colors.purple,
              margin: EdgeInsets.all(15),
              color: Colors.blue[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      enabled: false,
                      onSaved: (value) =>
                          setState(() => notif.userNotific = value),
                      controller: TextEditingController(
                          text: widget.notificarUser.name),
                      decoration: InputDecoration(
                        labelText: "Contato:",
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Divider(indent: 40),
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
                                color: Colors.purple,
                              ),
                            ),
                            onChanged: (_val) {
                              setState(
                                () {
                                  _selectedParam = _val;
                                  notif.timeNotific = _val;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25, right: 25, bottom: 15, top: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value) =>
                              setState(() => notif.quandoNotific = value),
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Digite o tempo";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Tempo:",
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 11, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (_val) {
                            setState(() {
                              val = int.parse(_val);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: FloatingActionButton.extended(
                      label: Text("Enviar"),
                      backgroundColor: Colors.purple,
                      icon: Icon(Icons.notifications_active),
                      onPressed: () async {
                        if (_selectedParam.isEmpty) {
                          return null;
                        } else {
                          _showNotificationWithSound();
                          // notificarr.add(NotificarUser(
                          //     whenNotific: '$_selectedParam',
                          //     timeNotific: '$val',
                          //     userNotific: widget.notificarUser.name));

                          var form = formkeyNotif.currentState;
                          form.save();
                          await _dbNoti.insertContact(notif);
                          form.reset();
                          await _refreshContactList();

                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ListContat();
                            },
                          ));
                        }

                        Navigator.of(context).pop();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
