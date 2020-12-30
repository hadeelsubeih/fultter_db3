class Todo {
  int _id;
  String name;
  bool isComplete;

  Todo({this.name, this.isComplete = false});

  Todo.withId(
    this._id,
    this.name,
    this.isComplete,
  );

  int get id => _id;

  String get title => name;

  bool get checkBoxValue => isComplete;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this.name = newTitle;
    }
  }

  set checkBoxValue(bool newcheckBoxValue) {
    this.isComplete = newcheckBoxValue;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = name;

    map['isComplete'] = isComplete;

    return map;
  }

  Todo.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this.name = map['name'];
    this.isComplete = map['isComplete'] == 0 ? false : true;
  }

  toList() {}

  void toggleCompleted() {
    isComplete = !isComplete;
  }
}
