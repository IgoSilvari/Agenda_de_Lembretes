class NotificarUsuario {
  int id;
  String userNoti;
  var quandoNoti;
  var timeNoti;

  NotificarUsuario({
    this.id,
    this.userNoti,
    this.quandoNoti,
    this.timeNoti,
  });

  static const Notificatable = 'notificar';
  static const colunId = 'id';
  static const colunNomeUser = 'userNoti';
  static const coluntempo = 'timeNoti';
  static const colunquando = 'quandoNoti';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'userNoti': userNoti,
      'timeNoti': timeNoti,
      'quandoNoti': quandoNoti,
    };
    if (id != null) {
      map[colunId] = id;
    }
    return map;
  }

  NotificarUsuario.fromMap(Map<String, dynamic> map) {
    id = map[colunId];
    userNoti = map[colunNomeUser];
    timeNoti = map[coluntempo];
    quandoNoti = map[colunquando];
  }
}
