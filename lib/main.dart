import 'package:Agenda_de_Lembretes/notificacao/listaNotificacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agenda de Lembretes",
      debugShowCheckedModeBanner: false,
      home: SplashScreene(),
    );
  }
}

class SplashScreene extends StatefulWidget {
  @override
  _SplashScreeneState createState() => _SplashScreeneState();
}

class _SplashScreeneState extends State<SplashScreene> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }

  Widget _introScreen() {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.transparent, Colors.transparent],
          ),
          navigateAfterSeconds: ListNotificarcao(),
          loaderColor: Colors.transparent,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.black45,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
