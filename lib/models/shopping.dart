//create a model class and a getter

class ShoopingModel {
String id;
  String title;
  String details;
  int price;

 

  ShoopingModel({this.id, this.title, this.details, this.price});
String get getId => id;
  String get getTitle => title;
  String get getDetail => details;
  int get getPrice => price;

  
}
