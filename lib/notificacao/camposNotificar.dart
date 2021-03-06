class NotificarUser {
  int id;
  String userNotific;
  var quandoNotific;
  var timeNotific;

  NotificarUser({
    this.id,
    this.userNotific,
    this.quandoNotific,
    this.timeNotific,
  });

  static const Notificartable = 'notific';
  static const colId = 'id';
  static const colNomeUser = 'userNotific';
  static const coltempo = 'timeNotific';
  static const colquando = 'quandoNotific';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'colId': id,
      'colNomeUser': userNotific,
      'coltempo': timeNotific,
      'colquando': quandoNotific,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }

  NotificarUser.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    userNotific = map[colNomeUser];
    timeNotific = map[coltempo];
    quandoNotific = map[colquando];
  }
}
