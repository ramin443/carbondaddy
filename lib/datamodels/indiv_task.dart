class TaskModel{
  int? _id;
  String? _image;
  String? _title;
  String? _description;
  String? _points;
  String? _status;


  TaskModel(this._image,this._title,this._description,this._points,this._status);

  int? get id => _id;
  String? get image => _image;
  String? get title => _title;
  String? get description => _description;
  String? get points => _points;
  String? get status => _status;

  set image(String? newimage) {
    this._image = newimage;
  }
  set title(String? newexercisetype) {
    this._title = newexercisetype;
  }
  set description(String? newdescription) {
    this._description = newdescription;
  }
  set points(String? newduration) {
    this._points = newduration;
  }
  set status(String? newduration) {
    this._status = newduration;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['points'] = _description;
    map['status'] = _status;



    return map;
  }

  // Extract a Note object from a Map object
  TaskModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._image = map['image'];
    this._title = map['title'];
    this._description = map['description'];
    this._points = map['points'];
    this._status = map['status'];

  }

}
