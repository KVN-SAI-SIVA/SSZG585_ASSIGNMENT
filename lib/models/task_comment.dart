import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskComment extends ParseObject implements ParseCloneable {
  TaskComment() : super(_keyTableName);
  TaskComment.clone() : this();

  @override
  TaskComment clone(Map<String, dynamic> map) => TaskComment.clone()..fromJson(map);

  static const String _keyTableName = 'TaskComment';
  static const String keyText = 'text';
  static const String keyCreatedBy = 'createdBy';
  static const String keyTask = 'task';

  @override
  String? get objectId => get<String>('objectId');

  String? get text => get<String>(keyText);
  set text(String? value) => set<String?>(keyText, value);

  ParseUser? get createdBy => get<ParseUser>(keyCreatedBy);
  set createdBy(ParseUser? value) => set<ParseUser?>(keyCreatedBy, value);

  ParseObject? get task => get<ParseObject>(keyTask);
  set task(ParseObject? value) => set<ParseObject?>(keyTask, value);

  @override
  DateTime? get createdAt => get<DateTime>('createdAt');
}
