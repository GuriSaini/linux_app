class SubTask {
  int? id;
  String? name;
  bool? like;
  SubTask({this.id, this.name, this.like});
}

class Task {
  int? id;
  String? name;
  List<SubTask>? sublist;
  Task({this.id, this.name, this.sublist});
}
