import 'package:cooking_app/constants/db_constants.dart';

class Dish {
  int? id;
  String? name;
  int? ovenTem;
  int? cookDuration;
  String? reminder;
  String? serveTime;
  String? notes;

  Dish(
      {this.id,
      this.name,
      this.ovenTem,
      this.cookDuration,
      this.reminder,
      this.serveTime,
      this.notes});

  Map<String, dynamic> toMap() => {
        DbConstants.colId: id,
        DbConstants.colName: name,
        DbConstants.colOvenTem: ovenTem,
        DbConstants.colDuration: cookDuration,
        DbConstants.colReminder: reminder,
        DbConstants.colServeTime: serveTime,
        DbConstants.colNotes: notes
      };
  Map<String, dynamic> toMapToInsert() => {
        DbConstants.colName: name,
        DbConstants.colOvenTem: ovenTem,
        DbConstants.colDuration: cookDuration,
        DbConstants.colReminder: reminder,
        DbConstants.colServeTime: serveTime,
        DbConstants.colNotes: notes
      };
  Map<String, dynamic> toMapToUpdate() => {
        DbConstants.colName: name,
        DbConstants.colOvenTem: ovenTem,
        DbConstants.colDuration: cookDuration,
        DbConstants.colReminder: reminder,
        DbConstants.colServeTime:serveTime,
        DbConstants.colNotes: notes
      };
  static Dish fromMap(Map<String, dynamic> map) {
    return Dish(
        id: map[DbConstants.colId],
        name: map[DbConstants.colName],
        ovenTem: map[DbConstants.colOvenTem],
        cookDuration: map[DbConstants.colDuration],
        reminder: map[DbConstants.colReminder],
        serveTime: map[DbConstants.colServeTime],
        notes: map[DbConstants.colNotes]);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Dish ($id,  $name , $ovenTem  $cookDuration, $reminder,$serveTime, $notes)';
  }
}
