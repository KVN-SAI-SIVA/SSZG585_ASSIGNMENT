import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Task extends ParseObject implements ParseCloneable {
  Task() : super(_keyTableName);
  Task.clone() : this();

  @override
  Task clone(Map<String, dynamic> map) => Task.clone()..fromJson(map);

  static const String _keyTableName = 'Task';
  static const String keyTitle = 'title';
  static const String keyDescription = 'description';
  static const String keyIsCompleted = 'isCompleted';
  static const String keyCreatedBy = 'createdBy';
  static const String keyStatus = 'status';
  static const String keyStartDate = 'startDate';
  static const String keyEndDate = 'endDate';
  static const String keyDiscussion = 'discussion';

  @override
  String? get objectId => get<String>('objectId');
  
  String? get title => get<String>(keyTitle);
  set title(String? value) => set<String?>(keyTitle, value);

  String? get description => get<String>(keyDescription);
  set description(String? value) => set<String?>(keyDescription, value);

  bool get isCompleted => get<bool>(keyIsCompleted) ?? false;
  set isCompleted(bool value) => set<bool>(keyIsCompleted, value);

  String? get status => get<String>(keyStatus);
  set status(String? value) => set<String?>(keyStatus, value);

  DateTime? get startDate => get<DateTime?>(keyStartDate);
  set startDate(DateTime? value) => set<DateTime?>(keyStartDate, value);

  DateTime? get endDate => get<DateTime?>(keyEndDate);
  set endDate(DateTime? value) => set<DateTime?>(keyEndDate, value);

  String? get discussion => get<String>(keyDiscussion);
  set discussion(String? value) => set<String?>(keyDiscussion, value);

  ParseUser? get createdBy => get<ParseUser>(keyCreatedBy);
  set createdBy(ParseUser? value) => set<ParseUser?>(keyCreatedBy, value);

  @override
  DateTime? get createdAt => get<DateTime>('createdAt');

  @override
  DateTime? get updatedAt => get<DateTime>('updatedAt');
}
