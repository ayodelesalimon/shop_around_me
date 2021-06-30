class StateModel {
  String name;
  String img;
  List<String> lines;

  StateModel({this.name, this.img, this.lines});

  StateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    lines = json['lines'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['lines'] = this.lines;
    return data;
  }
}
