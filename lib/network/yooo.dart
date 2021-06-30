import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_around_me/network/model2.dart';
import 'package:shop_around_me/network/models.dart';

class Addoffers extends StatefulWidget {
  static const String id = "offers";
  @override
  State<StatefulWidget> createState() => _AddoffersState();
}

class _AddoffersState extends State<Addoffers> {
  List<String> _companies = [];
  bool _isLoading = false;

  String _selectedCompany;
  @override
  void initState() {
    super.initState();
    _selectedCompany = null;
    _getcompanylist();
  }

  Future<String> loadFromAssets() async {
    return await rootBundle.loadString('json/parse.json');
  }

  _getcompanylist() async {
    setState(() {
      _isLoading = true;
    });
    print("getting..");
    /* final response =
        await http.get('http://10.0.2.2/Flutter/GetCompanieslist.php'); */
    String responseStr = await loadFromAssets();

    final listData = youModelFromJson(responseStr);
    for (int i = 0; i < listData.length; i++) {
      print('this is the list :' + listData[i].columnName);
      // _companies.add(listData[i].columnName);
    }

    // above method is the standard method to get creating a model class and then get the list of strings
    // I have just shown you but example is according to you code .

    // this above loadFromAssets is that you hit the api and you get the json string response
    // i have created a dummy json file where i can the String.

    // Else everything is the same as below you just have to pass the response.body to the json.decode method.

    var jsonData = json.decode(responseStr);

    for (var u in jsonData) {
      _companies.add(u.toString().substring(14, u.toString().length - 1));
    }

    for (int i = 0; i < _companies.length; i++) {
      print(_companies[i].toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
//double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      //color: Colors.red,
      home: Scaffold(
          backgroundColor: Colors.red,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text("Add.."),
          ),
          body: Container(
            color: Colors.blue,
            // just put your height i have modified it replace it by height / 8
            child: _isLoading
                ? CircularProgressIndicator()
                : Center(
                    child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //MainAxisAlignment: MainAxisAlignment.spaceBetween,
                              Text('Choose..'),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  // hint: Text('Choose Company'), // Not necessary for Option 1
                                  value: _selectedCompany,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCompany = newValue;

                                      // here i have taken the boolen variable to show and hide the list if you have not seleted the value from the dropdown the it will show the text and if selected the it will show you the list.
                                    });
                                    print(_selectedCompany);
                                  },
                                  items: _companies.map((company) {
                                    return DropdownMenuItem(
                                      child: new Text(company.toString()),
                                      value: company,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // this is to to check for the initial if string is null then show the text widget.
                      // else if the value is selected then it will show the listview
                      _selectedCompany == null
                          ? Text(
                              'Select the dropdown value for list to appear.') // sample text you can modify
                          : Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                height: 100,
                                color: Theme.of(context).backgroundColor,
                                child: new FutureBuilder(
                                    future: _getUsers(
                                        _selectedCompany), // a Future<String> or null
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                            child: Center(
                                          child: new CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ),
                                        ));
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: new Text(
                                              'Error ${snapshot.error}'),
                                        );
                                      } else {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5.0, 8.0, 5.0, 8.0),
                                            child: ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  List<UserModel> user =
                                                      snapshot.data;

                                                  var username =
                                                      user[index].username;
                                                  var stuname =
                                                      user[index].name;
                                                  print(
                                                      'This is the user name :$username');
                                                  print(
                                                      'This is the name : $stuname');

                                                  //var title=snapshot.data[index]["Title"];
                                                  // new Text(parsedDate.toString());
                                                  return StudentList2(
                                                      regdNo: username,
                                                      name: stuname);
                                                }),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
                    ],
                  )),
          )),
    );
  }
}

Future<String> loadFromAssets2() async {
  return await rootBundle.loadString('json/parse2.json');
}
// the above method is just for the sample purpose where you get you json String  after hitting the api call for _getUsers method

Future<List<UserModel>> _getUsers(String selectedcompany) async {
  /* var data = await http.post("http://10.0.2.2/Flutter/getstdata.php", body: {
    "company": selectedcompany,
    //print(data.body);
  }); */
  // here you call you api and you get the response

  String responseStr = await loadFromAssets2();

  final userModel = userModelFromJson(responseStr);
  // I have just made the model class for where fromt he below you get the complete object and then added to the list and returned.

  List<UserModel> users = [];

  users.add(userModel);

  print('This is the name : ${users[0].name}');

//final x=users.length.toString();
  //debugPrint("records:" + users.length.toString());
  //debugPrint("kkk:" + absentees.length.toString());

  return users;
}

class StudentList2 extends StatefulWidget {
  //MyHomePage(String branch);

  final regdNo;
  final name;

  const StudentList2({
    Key key,
    this.regdNo,
    this.name,
  }) : super(key: key);

  //final String branch;

  //const StudentList({Key key, this.branch}) : super(key: key);
  //MyHomePage(String branch);

  //  final String title;
  // final String branch="";
  // MyHomePage(String branch, {Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<StudentList2> {
  bool visible = false;
//bool _btnEnabled = false;
  //bool _validate = false;
  // var _firstPress = true ;

  //Color _iconColor = Colors.yellow;
  //Color _iconColor2 = Colors.white;

  //var poll;

  //DateTime parsedDate;

  @override
  Widget build(BuildContext context) {
    print(widget.regdNo.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new Card(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                child: Container(
                  child: new Text(
                    widget.regdNo.toUpperCase(),
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: new Text(
                  widget.regdNo,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                subtitle: new Text(
                  (widget.name),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),

//
            ],
          )),
    );
  }
}

// This is not the good approach to create a model class just check the sample model class that i have created.
class User {
  //final int index;
  final String username;
  final String name;

  //final Float cgpa;

  User(
    this.username,
    this.name,
  );
}
