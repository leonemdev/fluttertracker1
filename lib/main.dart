import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
//import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'helpers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnDone = "done";

const histStyle = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

void main() {
  runApp(new DatabaseTrial());
}

//*********************************
//******   Main Thread of App
//*********************************
class DatabaseTrial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Myasthenia Symptom Tracker",
      home: new MGMain(),
      theme: new ThemeData.light(

        //brightness: Brightness.light,
        //primaryColor: Colors.blueGrey,
        //accentColor: Colors.white,
      ),
    );
  }
}

//*********************************
//************  Front Page of App
//*********************************

class MGMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("MG Tracker")),
      body: new GridView.count(
        primary: true,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 0.1,
        crossAxisCount: 2,
        children: <Widget>[
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow1a(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow1b(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow2a(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow2b(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow3a(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow3b(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow4a(context),
          ),
          new Container(
            color: Theme.of(context).accentColor,
            child: _buildRow4b(context),
          ),
        ],
      ),
    );
  }
}

Widget _buildRow1a(BuildContext context) {
  return new Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
      Widget>[
    new Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      child: new FlatButton(
          child:
          new Image.asset('med128.png', height: 128.0, fit: BoxFit.cover),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new DailySymptom()),
            );
          }),
    ),
    new Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: new Text(
        "Symptom Tracking",
        style: Theme.of(context).textTheme.body1,
      ),
    ),
    new Divider(
      height: 1.0,
    ),
  ]);
}

Widget _buildRow1b(BuildContext context) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
          //margin: const EdgeInsets.only(left: 16.0),
            child: new Image.asset(
              'hospital.png',
              height: 128.0, /*fit: BoxFit.cover*/
            ),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new PageEmergencyDisplay()),
              );
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Emergency",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

Widget _buildRow2a(BuildContext context) {
  return new Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
      Widget>[
    new FlatButton(
        child: new Image.asset('hist128.png', height: 128.0, fit: BoxFit.cover),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new PageHistory()),
          );
        }),
    new Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: new Text(
        "Symptom History",
        style: Theme.of(context).textTheme.body1,
      ),
    ),
    new Divider(
      height: 1.0,
    ),
  ]);
}

Widget _buildRow2b(BuildContext context) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
            child:
            new Image.asset('graph.png', height: 128.0, fit: BoxFit.cover),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new BreathCountResults()),
              );
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Location Test",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

Widget _buildRow3a(BuildContext context) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
            child:
            new Image.asset('breath.png', height: 128.0, fit: BoxFit.cover),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new SBCTest()),
              );
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Single Breath Count",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

Widget _buildRow3b(BuildContext context) {




  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
            child: new Image.asset('checklist.png',
                height: 128.0, fit: BoxFit.cover),
            onPressed: () {
              DailyDatabaseClient dbp = new DailyDatabaseClient();
              dbp.create();
              //String dbPath = dbp.dbPath;
              Future<List> temper = dbp.idConvert();
              print(temper);
              /*Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new PageSurveys()),
              );*/
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Surveys",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

Widget _buildRow4a(BuildContext context) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
            child: new Image.asset('warning128.png',
                height: 128.0, fit: BoxFit.cover),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new PageWarning()),
              );
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Drug Warnings",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

Widget _buildRow4b(BuildContext context) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
            child: new Image.asset('tools128.png',
                height: 128.0, fit: BoxFit.cover),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new PageUtilMain()),
              );
            }),
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: new Text(
            "Utilities",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
      ]);
}

//*********************************
//******   Breath Count Results Thread - This page needs to be nested into the graphs/charts main button
//*********************************

class BreathCountResults extends StatefulWidget {
  BreathCountResults({Key key}) : super(key: key);

  @override
  PageSymptomState createState() => new PageSymptomState();
}

class PageSymptomState extends State<BreathCountResults> {
  DatabaseClient db = new DatabaseClient();
  List listSBC;
  List<Widget> tiles;
  var number;
  String tabName = 'sbcTracking';

  createdb() async {
    await db.create();
    String dbPathx = db.dbPath;
    Database _db = await openDatabase(dbPathx);
    List templistSBC =
    await _db.rawQuery('SELECT date, time, count FROM $tabName');
    var tempnumber = Sqflite
        .firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tabName"));
    setState(() {
      listSBC = templistSBC;
      number = tempnumber;
    });
    _db.close();
  }

  @override
  void initState() {
    super.initState();
    createdb();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildTilex(var counter) {
      this.tiles = [];
      //for(var i = 0; i < counter; i++)
      for (var i = counter - 1; i >= 0; i--) {
        this.tiles.add(new ListTilex(
          date: this.listSBC[i]['date'],
          time: this.listSBC[i]['time'],
          count: this.listSBC[i]['count'],
        ));
      }
      return this.tiles;
    }

    return new Scaffold(
        appBar: new AppBar(title: new Text("Single Breath Test History")),
        body: new ListView(
          children: buildTilex(this.number),
        ));
  }
}

class ListTilex extends StatelessWidget {
  ListTilex({Key key, this.date, this.time, this.count}) : super(key: key);

  final String date;
  final String time;
  final String count;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      dense: true,
      title: new Text(
        '$date  $time',
        textScaleFactor: 1.5,
      ),
      subtitle: new Text(
        '$count',
        textScaleFactor: 1.5,
      ),
      isThreeLine: true,
    );
    /*
    return new Center(
     child: new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          new Container(
            child: new Container(
              child: new Text(date),
            )
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(time),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(count),
          ),
        ]
      )
    )
    );
    */
  }
}

//*********************************
//******   Emergency info display
//*********************************

class PageEmergencyDisplay extends StatefulWidget {
  @override
  _PageEmergencyDisplay createState() => _PageEmergencyDisplay();
}

class _PageEmergencyDisplay extends State<PageEmergencyDisplay> {
  //********  Location declarations ********
  Map<String, double> _currentLocation;
  StreamSubscription<Map<String, double>> _locationSubscription;
  Location _location = new Location();
  String error;
  double latnow;
  double longnow;
  static String lat;
  static String long;
  bool currentWidget = true;
  bool enable911;

//********   Patient info declarations  *******
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String patname, pataddress, patphone, patdob, patblood;
  String ec1name, ec1home, ec1cell, ec1relat;
  String ec2name, ec2home, ec2cell, ec2relat;
  String neuroName, neuroPhone, livingWill, poaExists, poaName;
  String drugAllergies, otherAllergies, medConditions, meds, addInfo;

  //********   SMS declarations and functions  ******
  static const platform = const MethodChannel('sendSms');

  Future<Null> sendSms() async {
    print("SendSMS");
    try {
      String fullmessage =
          "This is $patname. I have an emergency and cannot speak. Please send help. My location is 'https://www.google.com/maps?q=$lat,$long'";
      final String result = await platform.invokeMethod('send',
          <String, dynamic>{"phone": "$ec1cell", "msg": "$fullmessage"});

      print(result);
      if (enable911 == true) {
        final String result911 = await platform.invokeMethod('send',
            <String, dynamic>{"phone": "6038333536", "msg": "$fullmessage"});
        print(result911);
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  //********   Location initialization   *******
  @override
  void initState() {
    super.initState();
    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged.listen((Map<String, double> result) {
          setState(() {
            _currentLocation = result;
          });
        });
    _locationSubscription.cancel();
  }

  initPlatformState() async {
    Map<String, double> location;

    try {
      location = await _location.getLocation;
      error = null;
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied = please ask the user to enable it from the app settings';
      }
      location = null;
    }

    if (!mounted) return;

    setState(() {
      _currentLocation = location;
    });
  }

  converter() async {
    latnow = (_currentLocation["latitude"]);
    longnow = (_currentLocation["longitude"]);
    lat = latnow.toStringAsFixed(7);
    long = longnow.toStringAsFixed(7);
  }

  //**********     Build of page   *******

  @override
  Widget build(BuildContext context) {
    converter();

    return new Scaffold(
        appBar: new AppBar(title: new Text("Emergency Info")),
        body: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading');
                patname = snapshot.requireData.getString('pat_name');
                pataddress = snapshot.requireData.getString('pat_address');
                patphone = snapshot.requireData.getString('pat_phone');
                patdob = snapshot.requireData.getString('pat_dob');
                patblood = snapshot.requireData.getString('pat_blood');
                ec1name = snapshot.requireData.getString('ec1_name');
                ec1home = snapshot.requireData.get('ec1_home');
                ec1cell = snapshot.requireData.get('ec1_cell');
                ec1relat = snapshot.requireData.get('ec1_relat');
                ec2name = snapshot.requireData.getString('ec2_name');
                ec2home = snapshot.requireData.get('ec2_home');
                ec2cell = snapshot.requireData.get('ec2_cell');
                ec2relat = snapshot.requireData.get('ec2_relat');
                neuroName = snapshot.requireData.getString('neuro_name');
                neuroPhone = snapshot.requireData.get('neuro_phone');
                livingWill = snapshot.requireData.get('livingwill');
                poaExists = snapshot.requireData.get('poaexists');
                poaName = snapshot.requireData.get('poaname');
                drugAllergies = snapshot.requireData.getString('drug_allergy');
                otherAllergies = snapshot.requireData.get('other_allergy');
                medConditions = snapshot.requireData.get('med_cond');
                meds = snapshot.requireData.get('meds');
                addInfo = snapshot.requireData.get('add_info');

                return new CustomScrollView(
                  shrinkWrap: true,
                  slivers: <Widget>[
                    new SliverPadding(
                      padding: const EdgeInsets.all(20.0),
                      sliver: new SliverList(
                        delegate: new SliverChildListDelegate(
                          <Widget>[
                            new RaisedButton(
                                onPressed: () => sendSms(),
                                child: const Text(
                                  "Emergency - Send Help",
                                )),
                            new Text(
                              "Patient Name",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$patname'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Patient Address",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$pataddress'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Patient Phone Number",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$patphone'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Patient Date of Birth",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$patdob'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Patient Blood Type",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$patblood'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 1",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec1name'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 1 Home Phone",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec1home'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 1 Cell Phone",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec1cell'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 1 Relationship",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec1relat'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 2",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec2name'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 2 Home Phone",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec2home'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 2 Cell Phone",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec2cell'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Emergency Contact 2 Relationship",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$ec2relat'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Neurologist Name",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$neuroName'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Neurologist Phone",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$neuroPhone'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Living Will Exists",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$livingWill'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Medical Power of Attorney Exists",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$poaExists'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Medical Power of Attorney Name",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$poaName'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Drug Allergies",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$drugAllergies'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Other Allergies",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$otherAllergies'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Important Medical Conditions",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$medConditions'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "List of Current Medications",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$meds'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              "Additional Information",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text('$addInfo'),
                            new Divider(height: 1.0),
                            const Text(" "),
                            new Text(
                              ' ',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                            new Text(''),
                            new Divider(height: 1.0),
                            new Text('Latconvert1 = $lat'),
                            new Text('Longconvert1 = $long'),
                            new Text(''),
                            new Divider(height: 1.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}

//*********************************
//******    Emergency info thread multipage for data entry
//*********************************

class PageEmergencyMulti extends StatefulWidget {
  PageEmergencyMulti({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PageEmergencyMultiState createState() => new _PageEmergencyMultiState();
}

class _PageEmergencyMultiState extends State<PageEmergencyMulti>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey1 = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
  }

  String _name, patname;
//  final TextEditingController _cName = new TextEditingController();
  String _address, pataddress;
//  final TextEditingController _cAddress = new TextEditingController();
  String _phone, patphone;
//  final TextEditingController _cPhone = new TextEditingController();
  String _dob, patdob;
//  final TextEditingController _cDob = new TextEditingController();
  String _blood, patblood;
//  final TextEditingController _cBlood = new TextEditingController();

  void _submit1() {
    final form = formKey1.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page2Emergency()));
  }

  void _saveit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pat_name', _name);
    prefs.setString('pat_address', _address);
    prefs.setString('pat_phone', _phone);
    prefs.setString('pat_dob', _dob);
    prefs.setString('pat_blood', _blood);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Emergency Information Entry'),
        ),
        body: new Center(
            child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading...');
                patname = snapshot.requireData.getString('pat_name') ?? '';
                pataddress = snapshot.requireData.getString('pat_address') ?? '';
                patphone = snapshot.requireData.getString('pat_phone') ?? '';
                patdob = snapshot.requireData.getString('pat_dob') ?? '';
                patblood = snapshot.requireData.getString('pat_blood') ?? '';

                return new Form(
                  key: formKey1,
                  child: new ListView(
                    children: <Widget>[
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Patient Name',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$patname',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cName,
                          decoration: new InputDecoration(
                            hintText: "Patient Name",
                          ),
                          onFieldSubmitted: (val) => _name = val,
                          onSaved: (val) => _name = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Patient Phone',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$patphone',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cPhone,
                          decoration: new InputDecoration(
                            hintText: "Patient Phone",
                          ),
                          onFieldSubmitted: (val) => _phone = val,
                          onSaved: (val) => _phone = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Patient Address',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$pataddress',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cAddress,
                          decoration: new InputDecoration(
                            hintText: "Patient Address",
                          ),
                          onFieldSubmitted: (val) => _address = val,
                          onSaved: (val) => _address = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'DOB',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$patdob',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cDob,
                          decoration: new InputDecoration(
                            hintText: "Patient DOB",
                          ),
                          onFieldSubmitted: (val) => _dob = val,
                          onSaved: (val) => _dob = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Blood Type',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$patblood',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cBlood,
                          decoration: new InputDecoration(
                            hintText: "Patient Blood Type",
                          ),
                          onFieldSubmitted: (val) => _blood = val,
                          onSaved: (val) => _blood = val,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: new FlatButton(
                          onPressed: _submit1,
                          color: Colors.black38,
                          child: new Text('Next Page'),
                        ),
                      ),
                    ],
                  ),
                );
              }, //builder:
            )),
      ),
    );
  }
}

class Page2Emergency extends StatefulWidget {
  Page2Emergency({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Page2EmergencyMultiState createState() => new _Page2EmergencyMultiState();
}

class _Page2EmergencyMultiState extends State<Page2Emergency>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey2 = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
  }

  String _ec1name, ec1name;
  //final TextEditingController _cEc1name = new TextEditingController();
  String _ec1home, ec1home;
  //final TextEditingController _cEc1home = new TextEditingController();
  String _ec1cell, ec1cell;
  //final TextEditingController _cEc1cell = new TextEditingController();
  String _ec1relat, ec1relat;
  //final TextEditingController _cEc1relat = new TextEditingController();

  void _submit2() {
    final form = formKey2.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page3Emergency()));
  }

  void _gotoPage1() {
    final form = formKey2.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new PageEmergencyMulti()));
  }

  void _saveit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ec1_name', _ec1name);
    prefs.setString('ec1_home', _ec1home);
    prefs.setString('ec1_cell', _ec1cell);
    prefs.setString('ec1_relat', _ec1relat);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Emergency Info Entry Page 2'),
        ),
        body: new Center(
            child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading...');
                ec1name = snapshot.requireData.getString('ec1_name') ?? '';
                ec1home = snapshot.requireData.get('ec1_home') ?? '';
                ec1cell = snapshot.requireData.get('ec1_cell') ?? '';
                ec1relat = snapshot.requireData.get('ec1_relat') ?? '';

                return new Form(
                  key: formKey2,
                  child: new ListView(
                    children: <Widget>[
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 1',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec1name',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          // controller: _cEc1name,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 1 Name",
                          ),
                          onFieldSubmitted: (val) => _ec1name = val,
                          onSaved: (val) => _ec1name = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 1 Home',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec1home',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc1home,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 1 Home Phone",
                          ),
                          onFieldSubmitted: (val) => _ec1home = val,
                          onSaved: (val) => _ec1home = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 1 Cell',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec1cell',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc1cell,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 1 Cell Phone",
                          ),
                          onFieldSubmitted: (val) => _ec1cell = val,
                          onSaved: (val) => _ec1cell = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact Relationship',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec1relat',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc1relat,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 1 Relationship",
                          ),
                          onFieldSubmitted: (val) => _ec1relat = val,
                          onSaved: (val) => _ec1relat = val,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: new FlatButton(
                          onPressed: _gotoPage1,
                          color: Colors.black38,
                          child: new Text('Previous Page'),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: new FlatButton(
                          onPressed: _submit2,
                          color: Colors.black38,
                          child: new Text('Next Page'),
                        ),
                      ),
                    ],
                  ),
                );
              }, //builder:
            )),
      ),
    );
  }
}

class Page3Emergency extends StatefulWidget {
  Page3Emergency({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Page3EmergencyMultiState createState() => new _Page3EmergencyMultiState();
}

class _Page3EmergencyMultiState extends State<Page3Emergency>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey3 = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
  }

  String _ec2name, ec2name;
  //final TextEditingController _cEc2name = new TextEditingController();
  String _ec2home, ec2home;
  //final TextEditingController _cEc2home = new TextEditingController();
  String _ec2cell, ec2cell;
  //final TextEditingController _cEc2cell = new TextEditingController();
  String _ec2relat, ec2relat;
  //final TextEditingController _cEc2relat = new TextEditingController();

  void _submit3() {
    final form = formKey3.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page4Emergency()));
  }

  void _gotoPage2() {
    final form = formKey3.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page2Emergency()));
  }

  void _saveit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ec2_name', _ec2name);
    prefs.setString('ec2_home', _ec2home);
    prefs.setString('ec2_cell', _ec2cell);
    prefs.setString('ec2_relat', _ec2relat);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Emergency Info Entry Page 3'),
        ),
        body: new Center(
            child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading...');
                ec2name = snapshot.requireData.getString('ec2_name') ?? '';
                ec2home = snapshot.requireData.get('ec2_home') ?? '';
                ec2cell = snapshot.requireData.get('ec2_cell') ?? '';
                ec2relat = snapshot.requireData.get('ec2_relat') ?? '';

                return new Form(
                  key: formKey3,
                  child: new ListView(
                    children: <Widget>[
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 2',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec2name',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc2name,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 2 Name",
                          ),
                          onFieldSubmitted: (val) => _ec2name = val,
                          onSaved: (val) => _ec2name = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 2 Home',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec2home',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc2home,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 2 Home Phone",
                          ),
                          onFieldSubmitted: (val) => _ec2home = val,
                          onSaved: (val) => _ec2home = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact 2 Cell',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec2cell',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc2cell,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 2 Cell Phone",
                          ),
                          onFieldSubmitted: (val) => _ec2cell = val,
                          onSaved: (val) => _ec2cell = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Emergency Contact Relationship',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$ec2relat',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cEc2relat,
                          decoration: new InputDecoration(
                            hintText: "Emergency Contact 2 Relationship",
                          ),
                          onFieldSubmitted: (val) => _ec2relat = val,
                          onSaved: (val) => _ec2relat = val,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: new FlatButton(
                          onPressed: _gotoPage2,
                          color: Colors.black38,
                          child: new Text('Previous Page'),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: new FlatButton(
                          onPressed: _submit3,
                          color: Colors.black38,
                          child: new Text('Next Page'),
                        ),
                      )
                    ],
                  ),
                );
              }, //builder:
            )),
      ),
    );
  }
}

class Page4Emergency extends StatefulWidget {
  Page4Emergency({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Page4EmergencyMultiState createState() => new _Page4EmergencyMultiState();
}

class _Page4EmergencyMultiState extends State<Page4Emergency>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey4 = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
  }

  String _neuroName, neuroName;
  //final TextEditingController _cNeuroName = new TextEditingController();
  String _neuroPhone, neuroPhone;
  //final TextEditingController _cNeuroPhone = new TextEditingController();
  String _livingWill, livingWill;
  //final TextEditingController _clivingWill = new TextEditingController();
  String _poaExists, poaExists;
  //final TextEditingController _cpoaExists = new TextEditingController();
  String _poaName, poaName;
  //final TextEditingController _cpoaName = new TextEditingController();

  void _submit4() {
    final form = formKey4.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page5Emergency()));
  }

  void _gotoPage3() {
    final form = formKey4.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page3Emergency()));
  }

  void _saveit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('neuro_name', _neuroName);
    prefs.setString('neuro_phone', _neuroPhone);
    prefs.setString('livingwill', _livingWill);
    prefs.setString('poaexists', _poaExists);
    prefs.setString('poaname', _poaName);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Emergency Info Entry Page 4'),
        ),
        body: new Center(
            child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading...');
                neuroName = snapshot.requireData.getString('neuro_name') ?? '';
                neuroPhone = snapshot.requireData.get('neuro_phone') ?? '';
                livingWill = snapshot.requireData.get('livingwill') ?? '';
                poaExists = snapshot.requireData.get('poaexists') ?? '';
                poaName = snapshot.requireData.get('poaname') ?? '';

                return new Form(
                  key: formKey4,
                  child: new ListView(
                    children: <Widget>[
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Neurologist Name',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$neuroName',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cNeuroName,
                          decoration: new InputDecoration(
                            hintText: "Neurologist Name",
                          ),
                          onFieldSubmitted: (val) => _neuroName = val,
                          onSaved: (val) => _neuroName = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Neurologist Phone Number',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$neuroPhone',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cNeuroPhone,
                          decoration: new InputDecoration(
                            hintText: "Neurologist Phone Number",
                          ),
                          onFieldSubmitted: (val) => _neuroPhone = val,
                          onSaved: (val) => _neuroPhone = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Advanced Directive Exists',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$livingWill',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _clivingWill,
                          decoration: new InputDecoration(
                            hintText: "Yes or No",
                          ),
                          onFieldSubmitted: (val) => _livingWill = val,
                          onSaved: (val) => _livingWill = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Medical Power of Attorney Exists',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$poaExists',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cpoaExists,
                          decoration: new InputDecoration(
                            hintText: "Yes or No",
                          ),
                          onFieldSubmitted: (val) => _poaExists = val,
                          onSaved: (val) => _poaExists = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Medical Power of Attorney Name',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$poaName',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cpoaName,
                          decoration: new InputDecoration(
                            hintText: "Name of Medical Power of Attorney",
                          ),
                          onFieldSubmitted: (val) => _poaName = val,
                          onSaved: (val) => _poaName = val,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: new FlatButton(
                          onPressed: _gotoPage3,
                          color: Colors.black38,
                          child: new Text('Previous Page'),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: new FlatButton(
                          onPressed: _submit4,
                          color: Colors.black38,
                          child: new Text('Next Page'),
                        ),
                      )
                    ],
                  ),
                );
              }, //builder:
            )),
      ),
    );
  }
}

class Page5Emergency extends StatefulWidget {
  Page5Emergency({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Page5EmergencyMultiState createState() => new _Page5EmergencyMultiState();
}

class _Page5EmergencyMultiState extends State<Page5Emergency>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey5 = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
  }

  String _drugAllergies, drugAllergies;
  //final TextEditingController _cdrugAllergies = new TextEditingController();
  String _otherAllergies, otherAllergies;
  //final TextEditingController _cotherAllergies = new TextEditingController();
  String _medConditions, medConditions;
  //final TextEditingController _cmedConditions = new TextEditingController();
  String _meds, meds;
  //final TextEditingController _cmeds = new TextEditingController();
  String _addInfo, addInfo;
  //final TextEditingController _caddInfo = new TextEditingController();

  void _submit5() {
    final form = formKey5.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
//    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Page2Emergency()));
  }

  void _gotoPage4() {
    final form = formKey5.currentState;
    form.save();
    _saveit();
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Page4Emergency()));
  }

  void _saveit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drug_allergy', _drugAllergies);
    prefs.setString('other_allergy', _otherAllergies);
    prefs.setString('med_cond', _medConditions);
    prefs.setString('meds', _meds);
    prefs.setString('add_info', _addInfo);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Emergency Info Entry Page 5'),
        ),
        body: new Center(
            child: new FutureBuilder<SharedPreferences>(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Text('Loading...');
                drugAllergies =
                    snapshot.requireData.getString('drug_allergy') ?? '';
                otherAllergies = snapshot.requireData.get('other_allergy') ?? '';
                medConditions = snapshot.requireData.get('med_cond') ?? '';
                meds = snapshot.requireData.get('meds') ?? '';
                addInfo = snapshot.requireData.get('add_info') ?? '';

                return new Form(
                  key: formKey5,
                  child: new ListView(
                    children: <Widget>[
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Drug Allergies',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$drugAllergies',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cdrugAllergies,
                          decoration: new InputDecoration(
                            hintText: "List of drug allergies",
                          ),
                          onFieldSubmitted: (val) => _drugAllergies = val,
                          onSaved: (val) => _drugAllergies = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Other Allergies',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$otherAllergies',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cotherAllergies,
                          decoration: new InputDecoration(
                            hintText: "List of other allergies",
                          ),
                          onFieldSubmitted: (val) => _otherAllergies = val,
                          onSaved: (val) => _otherAllergies = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Medical Conditions',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$medConditions',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cmedConditions,
                          decoration: new InputDecoration(
                            hintText: "List of Medical Conditions",
                          ),
                          onFieldSubmitted: (val) => _medConditions = val,
                          onSaved: (val) => _medConditions = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Medications',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$meds',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _cmeds,
                          decoration: new InputDecoration(
                            hintText: "List of Medications",
                          ),
                          onFieldSubmitted: (val) => _meds = val,
                          onSaved: (val) => _meds = val,
                        ),
                      ),
                      new ListTile(
                        dense: true,
                        subtitle: const Text(
                          'Additional Info',
                          textScaleFactor: 1.0,
                        ),
                        title: new TextFormField(
                          initialValue: '$addInfo',
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                          //controller: _caddInfo,
                          decoration: new InputDecoration(
                            hintText: "Any additional pertinent info",
                          ),
                          onFieldSubmitted: (val) => _addInfo = val,
                          onSaved: (val) => _addInfo = val,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: new FlatButton(
                          onPressed: _gotoPage4,
                          color: Colors.black38,
                          child: new Text('Previous Page'),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: new FlatButton(
                          onPressed: _submit5,
                          color: Colors.black38,
                          child: new Text('Done'),
                        ),
                      ),
                    ],
                  ),
                );
              }, //builder:
            )),
      ),
    );
  }
}

//*********************************
//******   Symptom History thread
//*********************************

class PageHistory extends StatefulWidget {
  PageHistory({Key key}) : super(key: key);

  @override
  PageHistoryState createState() => new PageHistoryState();
}

class PageHistoryState extends State<PageHistory> {
  DailyDatabaseClient dbh = new DailyDatabaseClient();
  final histFormKey = new GlobalKey<FormState>();

  bool _loading = false;
  List listDaySymptom, lastDay, listme;
  var number, count;
  String symTableName = 'symptomTrackingTest5';
  int sid, ssteps, srelease, sunixtime, maxId;
  int initialMaxId;
  String sdate, scomment, sremember;
  double sswallow, sneck, scoughs;
  String snasal, stingle, sptosis;
  double sappetite, slip, scheek, sbreath, sextrem, sbalance, sslur, sfatigue;
  String sregurg, sresidue, sdiplopia, ssorethroat;
  double sixty, spred, sweight;
  double spcfat, ssleephrs;
  String mestDose = '60';
  bool prevTrue = true;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 2), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  delRecord() async {
    await dbh.create();
    String dbPathy = dbh.dbPath;
    Database _dbh = await openDatabase(dbPathy);
    await _dbh.delete(symTableName, where: "id = ?", whereArgs: [sid]);
    _dbh.close();
    gotoPrevRecord();
  }

  gotoPrevRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prevTrue = true;
      prefs.setBool('prevTrue', prevTrue);
      new Future.delayed(new Duration(seconds: 1));
    });
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new PageTwoHistory()));
  }

  gotoFirstRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prevTrue = false;
      prefs.setBool('prevTrue', prevTrue);
      new Future.delayed(new Duration(seconds: 1));
    });
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new PageTwoHistory()));
  }

  idPlusOne() async {
    await dbh.create();
    String dbPathz = dbh.dbPath;
    Database _dbi = await openDatabase(dbPathz);

    if (sid == initialMaxId) {
      List next = await _dbi.query(symTableName,
          columns: SymMapper.columns,
          limit: 1,
          where: "id = ?",
          whereArgs: [1]);
      setState(() {
        listme = next;
        _loading = true;
        new Future.delayed(new Duration(seconds: 2), _login);
      });
    } else {
      List next = await _dbi.query(symTableName,
          columns: SymMapper.columns,
          limit: 1,
          where: "id = ?",
          whereArgs: [sid + 1]);
      setState(() {
        listme = next;
      });
    }
  }

  idMinusOne() async {
    await dbh.create();
    String dbPathz = dbh.dbPath;
    Database _dbi = await openDatabase(dbPathz);

    if (sid == 1) {
      List prev = await _dbi.query(symTableName,
          columns: SymMapper.columns,
          limit: 1,
          where: "id = ?",
          whereArgs: [initialMaxId]);
      setState(() {
        listme = prev;
        _loading = true;
        new Future.delayed(new Duration(seconds: 2), _login);
      });
    } else {
      List prev = await _dbi.query(symTableName,
          columns: SymMapper.columns,
          limit: 1,
          where: "id = ?",
          whereArgs: [sid - 1]);
      setState(() {
        listme = prev;
      });
    }
  }

  @override
  void initState() {
    _onLoading();
    super.initState();

    createSymDB();
  }

  createSymDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    new Future.delayed(new Duration(seconds: 1));
    await dbh.create();
    String dbPathy = dbh.dbPath;
    Database _dbh = await openDatabase(dbPathy);
    var tempnumber = Sqflite.firstIntValue(
        await _dbh.rawQuery('SELECT COUNT(*) FROM $symTableName'));
    List templistSym = await _dbh.rawQuery('SELECT * FROM $symTableName');
    List recents = await _dbh.query(symTableName,
        columns: SymMapper.columns, limit: 1, orderBy: "id DESC");

    lastDay = await dbh.fetchLatestSymptoms(1);



    setState(() {
      listDaySymptom = templistSym;
      number = tempnumber;
      listme = recents;
      count = listme.length;
      mestDose = (prefs.getString('mestD') ?? '60');
      initialMaxId = listme.last['id'];
      maxId = listme.last['id'];
      prefs.setInt('maxId', maxId);
      prefs.setInt('initialMax', initialMaxId);
      print("Page 1 initialMaxId = $initialMaxId");

    });

    _dbh.close();

  }

  void saveHistory() async {
    await dbh.create();
    SymMapper sympHis = new SymMapper();
    final histform = histFormKey.currentState;
    histform.save();
    sympHis.id = sid;
    sympHis.date = sdate;
    sympHis.swallow = sswallow;
    sympHis.neck = sneck;
    sympHis.cheek = scheek;
    sympHis.breath = sbreath;
    sympHis.extrem = sextrem;
    sympHis.balance = sbalance;
    sympHis.slur = sslur;
    sympHis.fatigue = sfatigue;
    sympHis.appetite = sappetite;
    sympHis.lip = slip;
    sympHis.nasal = snasal;
    sympHis.tingle = stingle;
    sympHis.ptosis = sdiplopia;
    sympHis.regurg = sregurg;
    sympHis.residue = sresidue;
    sympHis.sorethroat = ssorethroat;
    sympHis.diplopia = sdiplopia;
    sympHis.coughs = scoughs;
    sympHis.sixty = sixty;
    sympHis.release = srelease;
    sympHis.pred = spred;
    sympHis.weight = sweight;
    sympHis.pcfat = spcfat;
    sympHis.steps = ssteps;
    sympHis.sleephrs = ssleephrs;
    sympHis.comment = scomment;
    sympHis.remember = sremember;
    sympHis.unixtime = sunixtime;

    sympHis = await dbh.updateSym(sympHis);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var body = new ListView.builder(
        itemCount: count,
        reverse: false,
        itemBuilder: (BuildContext context, int position) {
          //return Text("Loaded");}
          return getRow(position);
        });

    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[
          body,
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("History"),
      ),
      body: new Container(child: _loading ? bodyProgress : body),
    );
  }

  Widget getRow(int i) {
    sunixtime = listme[i]["unixtime"];
    sid = listme[i]['id'];
    //initialMaxId = listme[i]['id'];
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: Form(
        key: histFormKey,
        child: Column(
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed: gotoPrevRecord,
                      child: new Text('Previous Record')),
                  new RaisedButton(
                      onPressed: gotoFirstRecord,
                      child: new Text('Next Record')),
                ]),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed: delRecord, child: new Text('Delete Record')),
                ]),
            new Text("ID: ${listme[i]["id"]}"),
            new Text("Date: ${listme[i]["date"]}"),
            new TextFormField(
              initialValue: listme[i]["date"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              // controller: _dateControl ,
              decoration: new InputDecoration(
                  labelText: 'Date:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sdate = val,
              onSaved: (val) => sdate = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["swallow"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Swallow:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sswallow = double.parse(val),
              onSaved: (val) => sswallow = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["neck"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Neck Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sneck = double.parse(val),
              onSaved: (val) => sneck = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["cheek"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Cheek Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scheek = double.parse(val),
              onSaved: (val) => scheek = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["breath"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Breathing Ability:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sbreath = double.parse(val),
              onSaved: (val) => sbreath = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["extrem"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Extremity Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sextrem = double.parse(val),
              onSaved: (val) => sextrem = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["balance"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Balance:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sbalance = double.parse(val),
              onSaved: (val) => sbalance = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["slur"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Altered Speech:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sslur = double.parse(val),
              onSaved: (val) => sslur = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["fatigue"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Fatigue Impact:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sfatigue = double.parse(val),
              onSaved: (val) => sfatigue = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["appetite"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Appetite:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sappetite = double.parse(val),
              onSaved: (val) => sappetite = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["lip"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Lip Closure Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => slip = double.parse(val),
              onSaved: (val) => slip = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["nasal"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Nasality:', labelStyle: histStyle),
              onFieldSubmitted: (val) => snasal = val,
              onSaved: (val) => snasal = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["tingle"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Tingle:', labelStyle: histStyle),
              onFieldSubmitted: (val) => stingle = val,
              onSaved: (val) => stingle = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["ptosis"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Ptosis:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sptosis = val,
              onSaved: (val) => sptosis = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["regurg"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Nasal Regurgitation:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sregurg = val,
              onSaved: (val) => sregurg = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["residue"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Residue Issues:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sresidue = val,
              onSaved: (val) => sresidue = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["sorethroat"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Sore Throat:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssorethroat = val,
              onSaved: (val) => ssorethroat = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["diplopia"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Double Vision:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sdiplopia = val,
              onSaved: (val) => sdiplopia = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["coughs"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Cough Incidents:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scoughs = double.parse(val),
              onSaved: (val) => scoughs = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["sixty"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: '$mestDose mg Mestinons taken:',
                  labelStyle: histStyle),
              onFieldSubmitted: (val) => sixty = double.parse(val),
              onSaved: (val) => sixty = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["release"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: '180mg Mestinons:', labelStyle: histStyle),
              onFieldSubmitted: (val) => srelease = int.parse(val),
              onSaved: (val) => srelease = int.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["pred"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Steroids:', labelStyle: histStyle),
              onFieldSubmitted: (val) => spred = double.parse(val),
              onSaved: (val) => spred = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["weight"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Weight:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sweight = double.parse(val),
              onSaved: (val) => sweight = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["pcfat"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Percent Fat:', labelStyle: histStyle),
              onFieldSubmitted: (val) => spcfat = double.parse(val),
              onSaved: (val) => spcfat = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["steps"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Daily Steps:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssteps = int.parse(val),
              onSaved: (val) => ssteps = int.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["sleephrs"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Sleep Hours:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssleephrs = double.parse(val),
              onSaved: (val) => ssleephrs = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["comment"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Comments:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scomment = val,
              onSaved: (val) => scomment = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme[i]["remember"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Speak to Doctor:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sremember = val,
              onSaved: (val) => sremember = val,
              textAlign: TextAlign.center,
            ),
            new RaisedButton(
              onPressed: saveHistory,
              child: new Text('Save'),
            ),
          ],
        ),
      ), //
    );
  }
}

//******* Second page display of symptom history

class PageTwoHistory extends StatefulWidget {
  PageTwoHistory({Key key}) : super(key: key);

  @override
  PageTwoHistoryState createState() => new PageTwoHistoryState();
}

class PageTwoHistoryState extends State<PageTwoHistory> {
  DailyDatabaseClient dbh = new DailyDatabaseClient();
  final histFormKey2 = new GlobalKey<FormState>();

  bool _loading = false;
  List listDaySymptom2, lastDay2, listme2;
  var number, count;
  String symTableName = 'symptomTrackingTest5';
  int sid, ssteps, srelease, sunixtime, maxId;
  int initialMaxId2, downAgain;
  String sdate, scomment, sremember;
  double sswallow, sneck, scoughs;
  String snasal, stingle, sptosis;
  double sappetite, slip, scheek, sbreath, sextrem, sbalance, sslur, sfatigue;
  String sregurg, sresidue, sdiplopia, ssorethroat;
  double sixty, spred, sweight;
  double spcfat, ssleephrs;
  String mestDose = '60';
  int receiveID, recPlusOne, recMinusOne;
  bool prevTrue;
  List page2, upList, downList;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 3), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  checkNullUp(int upOne) async {
    await dbh.create();
    String dbPath = dbh.dbPath;
    Database _dbh = await openDatabase(dbPath);
    List upListTemp = await _dbh.query(symTableName,
        columns: SymMapper.columns,
        limit: 1,
        where: "id = ?",
        whereArgs: [upOne + 1]);
    if (upListTemp = null) {
      int upAgain = upOne + 1;
      checkNullUp(upAgain);
    } else {
      upList = upListTemp;
      return upList;
    }
  }

  checkNullDown(int downOne) async {
    //await dbh.create();
    String dbPath = dbh.dbPath;
    Database _dbh = await openDatabase(dbPath);
    List downListTemp = await _dbh.query(symTableName,
        columns: SymMapper.columns,
        limit: 1,
        where: "id = ?",
        whereArgs: [downOne - 1]);
    _dbh.close();
    print("Inside checkNullDown downListTemp = $downListTemp");

    /*if (downListTemp = null) {
      //downAgain = downOne - 1;
      checkNullDown(downAgain);
    } else {
      downList = downListTemp;
      return [downList, downAgain];
    }*/
    setState(() {
      downList = downListTemp;
      downAgain = downOne - 1;
    });

    print ("Inside checkNullDown downList = $downList");
    print ("Inside checkNullDown downAgain = $downAgain");
    return [downList, downAgain];
  }

  @override
  void initState() {
    _onLoading();
    super.initState();

    createSymDB();
  }

  createSymDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    receiveID = (prefs.getInt(
        'initialMax')); //ID of the active record when the "next" or "previous" button was pressed.
    maxId = (prefs.getInt('maxId')); //database ID number for the last record
    prevTrue = (prefs.getBool(
        'prevTrue')); //identifies whether the demand by the user asked for previous or next record from a prior screen.
    new Future.delayed(new Duration(seconds: 1));
    await dbh.create();
    String dbPathy = dbh.dbPath;
    Database _dbh = await openDatabase(dbPathy);
    var tempnumber = Sqflite.firstIntValue(
        await _dbh.rawQuery('SELECT COUNT(*) FROM $symTableName'));
    List templistSym = await _dbh.rawQuery('SELECT * FROM $symTableName');
    //List recents = await _dbh.query(symTableName, columns: SymMapper.columns, limit: 1, orderBy: "id DESC");
    if (prevTrue == true) {
      if (receiveID == 1) {
        page2 = await _dbh.query(symTableName,
            columns: SymMapper.columns,
            limit: 1,
            where: "id = ?",
            whereArgs: [maxId]);
      } else {
        checkNullDown(receiveID);
        new Future.delayed(new Duration(seconds: 5));
        print("Inside createSymDB downList =  $downList");
        //checkNullDown(receiveID);
        page2 = downList;

        if (page2 == null) checkNullDown(downAgain);

        //page2 = await _dbh.query(symTableName,
        //columns: SymMapper.columns,
        //limit: 1,
        //where: "id = ?",
        //whereArgs: [receiveID - 1]);

      }
    } else {
      if (receiveID != maxId) {
        checkNullUp(receiveID);
        page2 = upList;
        //page2 = await _dbh.query(symTableName,
        //columns: SymMapper.columns,
        //limit:1,
        //where: "id = ?",
        //whereArgs: [receiveID + 1]);

      } else {
        checkNullUp(1);
        page2 = upList;
        //page2 = await _dbh.query(symTableName,
        //columns: SymMapper.columns,
        //limit: 1,
        //where: "id = ?",
        //whereArgs: [1]);

      }
    }
    lastDay2 = await dbh.fetchLatestSymptoms(1);

    setState(() {
      listDaySymptom2 = templistSym;
      number = tempnumber;
      listme2 = page2;
      //count = listme2.length;
      //mestDose = (prefs.getString('mestD') ?? '60');
      //initialMaxId2 = listme2.last['id'];
    });
    _dbh.close();
  }

  delRecord() async {
    await dbh.create();
    String dbPathy = dbh.dbPath;
    Database _dbh = await openDatabase(dbPathy);
    await _dbh.delete(symTableName, where: "id = ?", whereArgs: [sid]);
    _dbh.close();
    gotoPrevRecord();
  }

  gotoPrevRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prevTrue = true;
      prefs.setBool('prevTrue', prevTrue);
      prefs.setInt('initialMax', (sid));
    });
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new PageTwoHistory()));
  }

  gotoNextRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prevTrue = false;
      prefs.setBool('prevTrue', prevTrue);
      prefs.setInt('initialMax', (sid));
    });
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new PageTwoHistory()));
  }

  void saveHistory() async {
    await dbh.create();
    SymMapper sympHis = new SymMapper();
    final histform2 = histFormKey2.currentState;
    histform2.save();
    sympHis.id = sid;
    sympHis.date = sdate;
    sympHis.swallow = sswallow;
    sympHis.neck = sneck;
    sympHis.cheek = scheek;
    sympHis.breath = sbreath;
    sympHis.extrem = sextrem;
    sympHis.balance = sbalance;
    sympHis.slur = sslur;
    sympHis.fatigue = sfatigue;
    sympHis.appetite = sappetite;
    sympHis.lip = slip;
    sympHis.nasal = snasal;
    sympHis.tingle = stingle;
    sympHis.ptosis = sdiplopia;
    sympHis.regurg = sregurg;
    sympHis.residue = sresidue;
    sympHis.sorethroat = ssorethroat;
    sympHis.diplopia = sdiplopia;
    sympHis.coughs = scoughs;
    sympHis.sixty = sixty;
    sympHis.release = srelease;
    sympHis.pred = spred;
    sympHis.weight = sweight;
    sympHis.pcfat = spcfat;
    sympHis.steps = ssteps;
    sympHis.sleephrs = ssleephrs;
    sympHis.comment = scomment;
    sympHis.remember = sremember;
    sympHis.unixtime = sunixtime;

    sympHis = await dbh.updateSym(sympHis);

    Navigator.pop(context);
  }

  Widget histButtonsTop(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
        <Widget>[
          new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            new RaisedButton(
                onPressed: gotoPrevRecord, child: new Text('Previous Record')),
            new RaisedButton(
                onPressed: gotoNextRecord, child: new Text('Next Record')),
          ]),
          new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            new RaisedButton(onPressed: delRecord, child: new Text('Delete Record')),
          ]),
          new Text("ID: $sid"),

        ]
    );
  }

  Widget mainBody(BuildContext context) {
    return new ListView.builder(
        itemCount: count,
        reverse: false,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    var body = new ListView.builder(
        itemCount: count,
        reverse: false,
        itemBuilder: (BuildContext context, int position) {
          //return Text("Loaded");}
          return getRow(position);
        });

    var buttons = new Column(
      children: <Widget>[
        new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          new RaisedButton(
              onPressed: gotoPrevRecord, child: new Text('Previous Record')),
          new RaisedButton(
              onPressed: gotoNextRecord, child: new Text('Next Record')),
        ]),
        new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          new RaisedButton(
              onPressed: delRecord, child: new Text('Delete Record')),
        ]),
        new Text("ID: $sid"),
      ],
    );

    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[


          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      /*
      appBar: new AppBar(
        title: new Text("History"),
      ),*/

        body: new CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              expandedHeight: 50.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: const Text('History'),
              ),
            ),
            new SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400.0,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 3.5,
              ),
              delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return new Container(
                    alignment: Alignment.center,
                    //color: Colors.teal[100 * (index % 9)],
                    child: histButtonsTop(context),
                  );
                },
                childCount: 1,
              ),
            ),
            new SliverFixedExtentList(
              itemExtent: 400.0,
              delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return           new Container(
                    child: _loading ? bodyProgress : mainBody(context),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        )
      /*
      body: new GridView.count(
        primary: true,
        padding: const EdgeInsets.all(1.0),
        //shrinkWrap: true,
        childAspectRatio: 2.5,
        crossAxisSpacing: 0.1,
        crossAxisCount: 1,
        children: <Widget>[
          new Container(
            child: histButtonsTop(context),
          ),
          new Container(
            child: mainBody(context),
          ),
        ],
      ),*/
/*
      new ListView(
        shrinkWrap: true,
        //child:
        children:<Widget>[

            new RaisedButton(
                onPressed: gotoPrevRecord, child: new Text('Previous Record')),
            new RaisedButton(
                onPressed: gotoNextRecord, child: new Text('Next Record')),
            new RaisedButton(
                onPressed: delRecord, child: new Text('Delete Record')),

            new Text("ID: $sid"),
*/
      //_loading ? bodyProgress :
      //body,


      //],

      //),

    );
  }

  Widget getRow(int i) {
    sunixtime = listme2[i]["unixtime"];
    sid = listme2[i]['id'];
    //initialMaxId = listme[i]['id'];
    return new Padding(
      padding: new EdgeInsets.all(1.0),
      child: Form(
        key: histFormKey2,
        child: Column(
          children: <Widget>[
            /*  new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed: gotoPrevRecord,
                      child: new Text('Previous Record')),
                  new RaisedButton(
                      onPressed: gotoNextRecord,
                      child: new Text('Next Record')),
                ]),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed: delRecord, child: new Text('Delete Record')),
                ]),
            new Text("ID: ${listme[i]["id"]}"),*/
            //new Text("Date: ${listme[i]["date"]}"),
            new TextFormField(
              initialValue: listme2[i]["date"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              // controller: _dateControl ,
              decoration: new InputDecoration(
                  labelText: 'Date:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sdate = val,
              onSaved: (val) => sdate = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["swallow"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Swallow:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sswallow = double.parse(val),
              onSaved: (val) => sswallow = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["neck"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Neck Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sneck = double.parse(val),
              onSaved: (val) => sneck = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["cheek"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Cheek Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scheek = double.parse(val),
              onSaved: (val) => scheek = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["breath"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Breathing Ability:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sbreath = double.parse(val),
              onSaved: (val) => sbreath = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["extrem"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Extremity Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sextrem = double.parse(val),
              onSaved: (val) => sextrem = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["balance"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Balance:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sbalance = double.parse(val),
              onSaved: (val) => sbalance = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["slur"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Altered Speech:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sslur = double.parse(val),
              onSaved: (val) => sslur = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["fatigue"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Fatigue Impact:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sfatigue = double.parse(val),
              onSaved: (val) => sfatigue = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["appetite"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Appetite:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sappetite = double.parse(val),
              onSaved: (val) => sappetite = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["lip"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Lip Closure Strength:', labelStyle: histStyle),
              onFieldSubmitted: (val) => slip = double.parse(val),
              onSaved: (val) => slip = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["nasal"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Nasality:', labelStyle: histStyle),
              onFieldSubmitted: (val) => snasal = val,
              onSaved: (val) => snasal = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["tingle"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Tingle:', labelStyle: histStyle),
              onFieldSubmitted: (val) => stingle = val,
              onSaved: (val) => stingle = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["ptosis"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Ptosis:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sptosis = val,
              onSaved: (val) => sptosis = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["regurg"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Nasal Regurgitation:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sregurg = val,
              onSaved: (val) => sregurg = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["residue"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Residue Issues:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sresidue = val,
              onSaved: (val) => sresidue = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["sorethroat"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Sore Throat:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssorethroat = val,
              onSaved: (val) => ssorethroat = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["diplopia"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Double Vision:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sdiplopia = val,
              onSaved: (val) => sdiplopia = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["coughs"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Cough Incidents:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scoughs = double.parse(val),
              onSaved: (val) => scoughs = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["sixty"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: '$mestDose mg Mestinons taken:',
                  labelStyle: histStyle),
              onFieldSubmitted: (val) => sixty = double.parse(val),
              onSaved: (val) => sixty = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["release"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: '180mg Mestinons:', labelStyle: histStyle),
              onFieldSubmitted: (val) => srelease = int.parse(val),
              onSaved: (val) => srelease = int.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["pred"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Steroids:', labelStyle: histStyle),
              onFieldSubmitted: (val) => spred = double.parse(val),
              onSaved: (val) => spred = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["weight"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Weight:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sweight = double.parse(val),
              onSaved: (val) => sweight = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["pcfat"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Percent Fat:', labelStyle: histStyle),
              onFieldSubmitted: (val) => spcfat = double.parse(val),
              onSaved: (val) => spcfat = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["steps"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Daily Steps:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssteps = int.parse(val),
              onSaved: (val) => ssteps = int.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["sleephrs"].toString(),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Sleep Hours:', labelStyle: histStyle),
              onFieldSubmitted: (val) => ssleephrs = double.parse(val),
              onSaved: (val) => ssleephrs = double.parse(val),
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["comment"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Comments:', labelStyle: histStyle),
              onFieldSubmitted: (val) => scomment = val,
              onSaved: (val) => scomment = val,
              textAlign: TextAlign.center,
            ),
            new TextFormField(
              initialValue: listme2[i]["remember"],
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
              //controller: _commentControl ,
              decoration: new InputDecoration(
                  labelText: 'Speak to Doctor:', labelStyle: histStyle),
              onFieldSubmitted: (val) => sremember = val,
              onSaved: (val) => sremember = val,
              textAlign: TextAlign.center,
            ),
            new RaisedButton(
              onPressed: saveHistory,
              child: new Text('Save'),
            ),
          ],
        ),
      ), //
    );
  }
}

//*********************************
//******   Graphing thread
//*********************************

class PageGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Graphs")),
        body: new Row(
          children: <Widget>[
            new Flexible(
              child: new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Image.asset('med128.png',
                    height: 128.0, fit: BoxFit.cover),
              ),
            ),
            new Text(
              "Future Text Field",
              textScaleFactor: 2.0,
            )
          ],
        ));
  }
}

//*********************************
//******   Utilities Main Thread
//*********************************

class PageUtilMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Utilities")),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 100.0),
            child: new FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SymptomSelector()));
              },
              child: new Image.asset('tools128.png',
                  height: 128.0, fit: BoxFit.cover),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 100.0),
            child: new Text(
              "Settings",
              textScaleFactor: 1.0,
            ),
          ),
          new Container(
            child: new Text(' '),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PageEmergencyMulti()));
            },
            child: new Image.asset('hospital.png',
                height: 128.0, fit: BoxFit.cover),
          ),
          new Text(
            "Emergency Information Input",
            textScaleFactor: 1.0,
          ),
        ],
      ),
    );
  }
}

//*********************************
//******   Survey thread
//*********************************

class PageSurveys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Surveys")),
        body: new Row(
          children: <Widget>[
            new Flexible(
              child: new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Image.asset('med128.png',
                    height: 128.0, fit: BoxFit.cover),
              ),
            ),
            new Text(
              "Future Text Field",
              textScaleFactor: 2.0,
            )
          ],
        ));
  }
}

//*********************************
//******   Drug Warning thread
//*********************************

class PageWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Drug Warnings")),
      body: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: new CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      new Text(
                        "Important Message",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                      new Text(Strings.warning1),
                      new Divider(height: 1.0),
                      const Text(" "),
                      new Text(
                        Strings.commonscript,
                        textScaleFactor: 1.5,
                      ),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.ketek),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.fluoroq),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.zpack),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.neomycin),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.botox),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.steroids),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.quinine),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.procainamide),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.magnesium),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.dpen),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.beta),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      const Text(
                        "What is a Black Box Warning",
                        textScaleFactor: 1.5,
                      ),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.blackbox),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      const Text(
                        "Comments about vaccinations",
                        textScaleFactor: 1.5,
                      ),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.vaccine),
                      const Text(
                        " ",
                        textScaleFactor: 0.5,
                      ),
                      new Text(Strings.vacc2),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

//*********************************
//******   Breath Test Input Page thread
//*********************************
enum SBCResult { greaterforty, lessforty, lessthirty, lesstwenty, none }

class SBCTest extends StatefulWidget {
  SBCTest({Key key}) : super(key: key);

  @override
  SBCTestState createState() => new SBCTestState();
}

class SBCTestState extends State<SBCTest> {
  DatabaseClient db = new DatabaseClient();
  SBCResult _result = SBCResult.none;

  var nowreadable = new DateFormat.yMd().format(new DateTime.now());
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = new TimeOfDay.now();

  //var _toTime = new DateFormat.Hm().format(new DateTime.now());

  // function based on pressing the test button
  dbaseWork() async {
    await db.create();
    //Breath breath = new Breath();

    List<Breath> latestBreaths = await db.fetchLatestBreath(5);
    //Breath breathid = await db.fetchBreath(0);

    print(latestBreaths);
    //print(breathid);
  }

  saveSBC() async {
    await db.create();
    Breath breaths = new Breath();

    //do save evolution
    String breathcount = _result.toString();

    String result = "Not Performed";
    if (breathcount == "SBCResult.greaterforty") {
      result = ">40 - Stable";
    }
    if (breathcount == "SBCResult.lessforty") {
      result = "<40 - Stable but borderline";
    }
    if (breathcount == "SBCResult.lessthirty") {
      result = "<30 - Recommend call neurologist";
    }
    if (breathcount == "SBCResult.lesstwenty") {
      result = "<20 - Recommend seek immediate medical attention";
    }

    String updateTime = _fromTime.toString();
    String finalTime = updateTime.substring(10, 15);
    String updateDate = _fromDate.toString();
    String finalDate = updateDate.substring(0, 10);
    var unixdate = _fromDate.millisecondsSinceEpoch;

    print(breathcount);
    print('result = $result');
    print('nowreadable = $nowreadable');
    print('fromDate = $_fromDate');
    print('_fromTime = $_fromTime');
    print('updateTime = $updateTime');
    print('finalTime = $finalTime');
    print('updateDate = $updateDate');
    print('finalDate = $finalDate');
    print(unixdate);

    //assign values into db map to apply to database

    breaths.date = finalDate;
    breaths.time = finalTime;
    breaths.count = result;
    breaths.unixtime = unixdate;
    breaths = await db.upsertBreath(breaths);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Single Breath Test")),
      body: new Column(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text(Strings.sbcDirection),
        ),
        RadioListTile<SBCResult>(
          title: const Text('Not Performed'),
          activeColor: Colors.blueGrey,
          dense: true,
          //isThreeLine: true,
          value: SBCResult.none,
          groupValue: _result,
          onChanged: (SBCResult value) {
            setState(() {
              _result = value;
            });
          },
        ),
        RadioListTile<SBCResult>(
          title: const Text('>40 - Stable'),
          activeColor: Colors.blueGrey,
          dense: true,
          //isThreeLine: true,
          value: SBCResult.greaterforty,
          groupValue: _result,
          onChanged: (SBCResult value) {
            setState(() {
              _result = value;
            });
          },
        ),
        RadioListTile<SBCResult>(
          title: const Text('<40 - Stable but borderline'),
          activeColor: Colors.blueGrey,
          dense: true,
          //isThreeLine: true,
          value: SBCResult.lessforty,
          groupValue: _result,
          onChanged: (SBCResult value) {
            setState(() {
              _result = value;
            });
          },
        ),
        RadioListTile<SBCResult>(
          title: const Text('<30 - Recommend call neurologist'),
          activeColor: Colors.blueGrey,
          dense: true,
          //isThreeLine: true,
          value: SBCResult.lessthirty,
          groupValue: _result,
          onChanged: (SBCResult value) {
            setState(() {
              _result = value;
            });
          },
        ),
        RadioListTile<SBCResult>(
          title: const Text('<20 - Recommend seek immediate medical attention'),
          activeColor: Colors.blueGrey,
          dense: true,
          //isThreeLine: true,
          value: SBCResult.lesstwenty,
          groupValue: _result,
          onChanged: (SBCResult value) {
            setState(() {
              _result = value;
            });
          },
        ),
        new Expanded(
            child: new Container(
              padding: const EdgeInsets.only(bottom: 40.0),
              decoration: new BoxDecoration(
                  border:
                  new Border(bottom: new BorderSide(color: Colors.black45))),
              child: new DateTimePicker(
                labelText: 'From',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _fromTime = time;
                  });
                },
              ),
            )),
        new RaisedButton(
          onPressed: saveSBC,
          child: new Text('Done'),
        ),
        new RaisedButton(
          onPressed: dbaseWork,
          child: new Text('Test'),
        ),
      ]),
    );
  }
}

//*********************************
//******   This class determines the location of the user
//*********************************

class LocateMe extends StatefulWidget {
  @override
  _LocateMe createState() => new _LocateMe();
}

class _LocateMe extends State<LocateMe> {
  Map<String, double> _currentLocation;
  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  String error;

  double latnow;
  double longnow;
  static String lat;
  static String long;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    super.initState();

    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged.listen((Map<String, double> result) {
          setState(() {
            _currentLocation = result;
          });
        });
    _locationSubscription.cancel();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _currentLocation = location;
    });
  }

  converter() async {
    latnow = (_currentLocation["latitude"]);
    longnow = (_currentLocation["longitude"]);

    lat = latnow.toStringAsFixed(7);
    long = longnow.toStringAsFixed(7);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    if (_currentLocation == null) {
      widgets = new List();
    } else {
      converter();
      //latnow = (_currentLocation["latitude"]);
      //longnow = (_currentLocation["longitude"]);

      //String latconvert = latnow.toStringAsFixed(7);

      widgets = [
        new Text("Latitude=$latnow, Longitude=$longnow"),
        new Text('Latconvert1 = $lat'),
        new Text('Longconvert1 = $long'),
      ];
    }

    widgets.add(new Center(
        child: new Text(_currentLocation != null
            ? '$_currentLocation\n'
            : 'Error: $error\n')));

    widgets.add(new Center(
      child: new Text('\n Test Test Test'),
    ));

    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('Location Reporter'),
            ),
            body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            )));
  }
}

//**********************************
//*******  Daily Symptom Entry page
//**********************************

class DailySymptom extends StatefulWidget {
  @override
  DailySymptomState createState() => DailySymptomState();
}

class DailySymptomState extends State<DailySymptom> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  DailyDatabaseClient dbd = new DailyDatabaseClient();
  var nowreadable = new DateFormat.yMd().format(new DateTime.now());
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  double _swallow = 5.0;
  double _neck = 5.0;
  double _cheek = 5.0;
  double _breath = 5.0;
  double _extrem = 5.0;
  double _balance = 5.0;
  double _slur = 5.0;
  double _fatigue = 5.0;
  double _appetite = 5.0;
  double _lip = 5.0;
  bool _nasal = false;
  String nasal = "No";
  bool _tingle = false;
  String tingle = "No";
  bool _ptosis = false;
  String ptosis = "No";
  bool _regurg = false;
  String regurg = "No";
  bool _residue = false;
  String residue = "No";
  bool _sorethroat = false;
  String sorethroat = "No";
  bool _diplopia = false;
  String diplopia = "No";
  double _coughs = 0.0;
  String coughs;
  final TextEditingController _coughControl = new TextEditingController();
  double _sixty = 0.0;
  String sixty;
  final TextEditingController _sixtyControl = new TextEditingController();
  int _release = 0;
  String release;
  final TextEditingController _releaseControl = new TextEditingController();
  double _pred = 0.0;
  String pred;
  final TextEditingController _predControl = new TextEditingController();
  double _weight = 0.0;
  String weight;
  final TextEditingController _weightControl = new TextEditingController();
  double _pcfat = 0.0;
  String pcfat;
  final TextEditingController _fatpcControl = new TextEditingController();
  int _steps = 0;
  String steps;
  final TextEditingController _stepControl = new TextEditingController();
  double _sleephrs = 0.0;
  String sleephrs;
  final TextEditingController _sleephrsControl = new TextEditingController();
  String comment;
  final TextEditingController _commentControl = new TextEditingController();
  bool _remember = false;
  String remember = "No";
  bool showSwall = true;
  bool showNeck = true;
  bool showCheek = true;
  bool showBreath = true;
  bool showExtremity = true;
  bool showBalance = true;
  bool showSpeech = true;
  bool showFatigue = true;
  bool showAppetite = true;
  bool showLip = true;
  bool showPred = true;
  bool show180 = true;
  bool showSteps = true;
  bool showWeight = true;
  bool showFat = true;
  bool showSleep = true;
  String mestDose = '60';

  final symFormKey = new GlobalKey<FormState>();
  final commentFormKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    showFields();
  }

  showFields() async {
    SharedPreferences frefs = await SharedPreferences.getInstance();
    setState(() {
      showSwall = (frefs.getBool('swallowSel') ?? true);
      showNeck = (frefs.getBool('neckSel') ?? true);
      showCheek = (frefs.getBool('cheekSel') ?? true);
      showBreath = (frefs.getBool('breathSel') ?? true);
      showExtremity = (frefs.getBool('extremitySel') ?? true);
      showBalance = (frefs.getBool('balanceSel') ?? true);
      showSpeech = (frefs.getBool('speechSel') ?? true);
      showFatigue = (frefs.getBool('fatigueSel') ?? true);
      showAppetite = (frefs.getBool('appetiteSel') ?? true);
      showLip = (frefs.getBool('lipsSel') ?? true);

      showPred = (frefs.getBool('predSel') ?? true);
      show180 = (frefs.getBool('180Sel') ?? true);
      showSteps = (frefs.getBool('stepsSel') ?? true);
      showWeight = (frefs.getBool('weightSel') ?? true);
      showFat = (frefs.getBool('fatSel') ?? true);
      showSleep = (frefs.getBool('sleepSel') ?? true);
    });
  }

  saveDaily() async {
    await dbd.create();
    SymMapper symps = new SymMapper();
    String updateDate = _date.toString();
    String finalDate = updateDate.substring(0, 10);
    var unixdate = _date.millisecondsSinceEpoch;

    final form = symFormKey.currentState;
    final commform = commentFormKey.currentState;
    commform.save();
    form.save();
    if (coughs != null) {
      var _coughs = double.parse(coughs);
    } else {
      var _coughs = 0.0;
    }
    if (sixty != null) {
      var _sixty = double.parse(sixty);
    } else {
      var _sixty = 0.0;
    }
    if (pred != null) {
      var _pred = double.parse(pred);
    } else {
      var _pred = 0.0;
    }
    if (weight != null) {
      var _weight = double.parse(weight);
    } else {
      var _weight = 0.0;
    }
    if (pcfat != null) {
      var _pcfat = double.parse(pcfat);
    } else {
      var _pcfat = 0.0;
    }
    if (pcfat != null) {
      var _steps = int.parse(steps);
    } else {
      var _steps = 0.0;
    }
    if (sleephrs != null) {
      var _sleephrs = double.parse(sleephrs);
    } else {
      var _sleephrs = 0.0;
    }

    //assign values into db map to apply to database
    symps.date = finalDate;
    symps.swallow = _swallow;
    symps.neck = _neck;
    symps.cheek = _cheek;
    symps.breath = _breath;
    symps.extrem = _extrem;
    symps.balance = _balance;
    symps.slur = _slur;
    symps.fatigue = _fatigue;
    symps.appetite = _appetite;
    symps.lip = _lip;
    symps.nasal = nasal;
    symps.tingle = tingle;
    symps.ptosis = ptosis;
    symps.regurg = regurg;
    symps.residue = residue;
    symps.sorethroat = sorethroat;
    symps.diplopia = diplopia;
    symps.coughs = _coughs;
    symps.sixty = _sixty;
    symps.release = _release;
    symps.pred = _pred;
    symps.weight = _weight;
    symps.pcfat = _pcfat;
    symps.steps = _steps;
    symps.sleephrs = _sleephrs;
    symps.comment = comment;
    symps.remember = remember;
    symps.unixtime = unixdate;

    symps = await dbd.upsertSymptoms(symps);

    Navigator.pop(context);
  }

  void _onChangedSwallow(double value) {
    setState(() {
      _swallow = value;
    });
  }

  void _onChangedNeck(double value) {
    setState(() {
      _neck = value;
    });
  }

  void onChangedCheek(double value) {
    setState(() {
      _cheek = value;
    });
  }

  void onChangedBreath(double value) {
    setState(() {
      _breath = value;
    });
  }

  void onChangedExtrem(double value) {
    setState(() {
      _extrem = value;
    });
  }

  void onChangedBalance(double value) {
    setState(() {
      _balance = value;
    });
  }

  void onChangedSlur(double value) {
    setState(() {
      _slur = value;
    });
  }

  void onChangedFatigue(double value) {
    setState(() {
      _fatigue = value;
    });
  }

  void onChangedApp(double value) {
    setState(() {
      _appetite = value;
    });
  }

  void onChangedLip(double value) {
    setState(() {
      _lip = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Daily Symptom Tracking")),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            /*new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text("Symptom Details"),
          ),*/
            new Container(
              child: new Container(
                padding: const EdgeInsets.all(20.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: new BorderSide(color: Colors.black45))),
                child: new SymDateTimePicker(
                  labelText: 'Date',
                  selectedDate: _date,
                  selectDate: (DateTime date) {
                    setState(() {
                      _date = date;
                    });
                  },
                ),
              ),
            ),

            //Swallow Row
            showSwall
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Swallow"),
                ),
                new Slider(
                  label: "Swallow Rating",
                  value: _swallow,
                  onChanged: (double value) {
                    _onChangedSwallow(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_swallow'),
                ),
              ],
            )
                : new Container(),
            //Neck Row
            showNeck
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Neck"),
                ),
                new Slider(
                  label: "Neck Strength",
                  value: _neck,
                  onChanged: (double value) {
                    _onChangedNeck(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_neck'),
                ),
              ],
            )
                : new Container(),
            //Cheeks Row
            showCheek
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Cheeks"),
                ),
                new Slider(
                  label: "Cheek Strength",
                  value: _cheek,
                  onChanged: (double value) {
                    onChangedCheek(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_cheek'),
                ),
              ],
            )
                : new Container(),
            //Breathing Row
            showBreath
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Breathing"),
                ),
                new Slider(
                  label: "Breathing Ability",
                  value: _breath,
                  onChanged: (double value) {
                    onChangedBreath(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_breath'),
                ),
              ],
            )
                : new Container(),
            //Extremity Row
            showExtremity
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Extremity"),
                ),
                new Slider(
                  label: "Extremity Strength",
                  value: _extrem,
                  onChanged: (double value) {
                    onChangedExtrem(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_extrem'),
                ),
              ],
            )
                : new Container(),
            //Balance Row
            showBalance
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Balance"),
                ),
                new Slider(
                  label: "Balance",
                  value: _balance,
                  onChanged: (double value) {
                    onChangedBalance(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_balance'),
                ),
              ],
            )
                : new Container(),
            //Speech Row
            showSpeech
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Altered Speech"),
                ),
                new Slider(
                  label: "Altered Speech",
                  value: _slur,
                  onChanged: (double value) {
                    onChangedSlur(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_slur'),
                ),
              ],
            )
                : new Container(),
            //Fatigue Row
            showFatigue
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Fatigue Impact"),
                ),
                new Slider(
                  label: "Fatigue Impact",
                  value: _fatigue,
                  onChanged: (double value) {
                    onChangedFatigue(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_fatigue'),
                ),
              ],
            )
                : new Container(),
            //Appetite Row
            showAppetite
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Appetite"),
                ),
                new Slider(
                  label: "Appetite",
                  value: _appetite,
                  onChanged: (double value) {
                    onChangedApp(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_appetite'),
                ),
              ],
            )
                : new Container(),
            //Lip Closure Row
            showLip
                ? new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text("Lip Closure"),
                ),
                new Slider(
                  label: "Lip Closure Strength",
                  value: _lip,
                  onChanged: (double value) {
                    onChangedLip(value);
                  },
                  min: 0.0,
                  max: 5.0,
                  divisions: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Text('$_lip'),
                ),
              ],
            )
                : new Container(),
            new Divider(
              height: 1.0,
            ),

            //Checkbox Rows
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Nasality"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _nasal,
                      onChanged: (bool value) {
                        setState(() {
                          _nasal = value;
                          if (_nasal == true) {
                            nasal = "Yes";
                          } else {
                            nasal = "No";
                          }
                        });
                      },
                    )),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Facial Tingling"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _tingle,
                      onChanged: (bool value) {
                        setState(() {
                          _tingle = value;
                          if (_tingle == true) {
                            tingle = "Yes";
                          } else {
                            tingle = "No";
                          }
                        });
                      },
                    )),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Ptosis"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _ptosis,
                      onChanged: (bool value) {
                        setState(() {
                          _ptosis = value;
                          if (_ptosis == true) {
                            ptosis = "Yes";
                          } else {
                            ptosis = "No";
                          }
                        });
                      },
                    )),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Nasal Regurgitation"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _regurg,
                      onChanged: (bool value) {
                        setState(() {
                          _regurg = value;
                          if (_regurg == true) {
                            regurg = "Yes";
                          } else {
                            regurg = "No";
                          }
                        });
                      },
                    )),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Residue Issues"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _residue,
                      onChanged: (bool value) {
                        setState(() {
                          _residue = value;
                          if (_residue == true) {
                            residue = "Yes";
                          } else {
                            residue = "No";
                          }
                        });
                      },
                    )),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Sore Throat"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: new Checkbox(
                      value: _sorethroat,
                      onChanged: (bool value) {
                        setState(() {
                          _sorethroat = value;
                          if (_sorethroat == true) {
                            sorethroat = "Yes";
                          } else {
                            sorethroat = "No";
                          }
                        });
                      },
                    )),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Double Vision"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _diplopia,
                      onChanged: (bool value) {
                        setState(() {
                          _diplopia = value;
                          if (_diplopia == true) {
                            diplopia = "Yes";
                          } else {
                            diplopia = "No";
                          }
                        });
                      },
                    )),
              ],
            ),
            new Divider(
              height: 1.0,
            ),

            //Text input fields
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: new Form(
                  key: symFormKey,
                  child: new Column(children: <Widget>[
                    new TextFormField(
                      initialValue: null,
                      style: new TextStyle(fontSize: 14.0, color: Colors.black),
                      controller: _coughControl,
                      decoration: new InputDecoration(
                        labelText: 'Cough Incidents:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => coughs = val,
                      onSaved: (val) => coughs = val,
                      textAlign: TextAlign.center,
                    ),
                    new TextFormField(
                      initialValue: null,
                      style: new TextStyle(fontSize: 14.0, color: Colors.black),
                      controller: _sixtyControl,
                      decoration: new InputDecoration(
                        labelText: '$mestDose mg Mestinons:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => sixty = val,
                      onSaved: (val) => sixty = val,
                      textAlign: TextAlign.center,
                    ),
                    show180
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _releaseControl,
                      decoration: new InputDecoration(
                        labelText: '180mg Mestinons:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => release = val,
                      onSaved: (val) => release = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                    showPred
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _predControl,
                      decoration: new InputDecoration(
                        labelText: 'Steroids:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => pred = val,
                      onSaved: (val) => pred = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                    showWeight
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _weightControl,
                      decoration: new InputDecoration(
                        labelText: 'Weight:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => weight = val,
                      onSaved: (val) => weight = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                    showFat
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _fatpcControl,
                      decoration: new InputDecoration(
                        labelText: 'Percent Fat:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => pcfat = val,
                      onSaved: (val) => pcfat = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                    showSteps
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _stepControl,
                      decoration: new InputDecoration(
                        labelText: 'Daily Steps:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => steps = val,
                      onSaved: (val) => steps = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                    showSleep
                        ? new TextFormField(
                      initialValue: null,
                      style: new TextStyle(
                          fontSize: 14.0, color: Colors.black),
                      controller: _sleephrsControl,
                      decoration: new InputDecoration(
                        labelText: 'Sleep Hours:',
                        isDense: true,
                      ),
                      onFieldSubmitted: (val) => sleephrs = val,
                      onSaved: (val) => sleephrs = val,
                      textAlign: TextAlign.center,
                    )
                        : new Container(),
                  ])),
            ),

            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: new Form(
                key: commentFormKey,
                child: new TextFormField(
                  initialValue: null,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black),
                  controller: _commentControl,
                  decoration: new InputDecoration(
                    labelText: 'Comments:',
                  ),
                  onFieldSubmitted: (val) => comment = val,
                  onSaved: (val) => comment = val,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Text("Talk to doctor"),
                ),
                new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Checkbox(
                      value: _remember,
                      onChanged: (bool value) {
                        setState(() {
                          _remember = value;
                          if (_remember == true) {
                            remember = "Yes";
                          } else {
                            remember = "No";
                          }
                        });
                      },
                    )),
              ],
            ),

            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: new RaisedButton(
                      onPressed: saveDaily,
                      child: new Text('Save'),
                    ),
                  ),
                  new Text(''),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SymptomSelector()));
                      },
                      child: new Text('Settings'),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

//*******************************
//******* Symptom Selector Page
//*******************************

class SymptomSelector extends StatefulWidget {
  SymptomSelector({Key key, this.title}) : super(key: key);
  final String title;
  @override
  SymptomSelectorState createState() => SymptomSelectorState();
}

class SymptomSelectorState extends State<SymptomSelector> {
  final settingKey = new GlobalKey<FormState>();
  final scaffoldKeySet = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> setPrefs = SharedPreferences.getInstance();

  bool _swallowSel = true;
  bool _neckSel = true;
  bool _cheekSel = true;
  bool _breathSel = true;
  bool _extremitySel = true;
  bool _balanceSel = true;
  bool _speechSel = true;
  bool _fatigueSel = true;
  bool _appetiteSel = true;
  bool _lipsSel = true;

  bool _predSel = true;
  bool _180Sel = true;
  bool _stepsSel = true;
  bool _weightSel = true;
  bool _fatSel = true;
  bool _sleepSel = true;
  int _mestDose = 60;
  String _mestD, mestD;
  TextEditingController _mestDControl = new TextEditingController();
  bool _enable911 = false;

  @override
  void initState() {
    super.initState();
    setMe();
  }

  setMe() async {
    SharedPreferences hrefs = await SharedPreferences.getInstance();
    setState(() {
      _swallowSel = (hrefs.getBool('swallowSel') ?? true);
      _neckSel = (hrefs.getBool('neckSel') ?? true);
      _cheekSel = (hrefs.getBool('cheekSel') ?? true);
      _breathSel = (hrefs.getBool('breathSel') ?? true);
      _extremitySel = (hrefs.getBool('extremitySel') ?? true);
      _balanceSel = (hrefs.getBool('balanceSel') ?? true);
      _speechSel = (hrefs.getBool('speechSel') ?? true);
      _fatigueSel = (hrefs.getBool('fatigueSel') ?? true);
      _appetiteSel = (hrefs.getBool('appetiteSel') ?? true);
      _lipsSel = (hrefs.getBool('lipsSel') ?? true);
      _enable911 = (hrefs.getBool('enable911') ?? false);

      _predSel = (hrefs.getBool('predSel') ?? true);
      _180Sel = (hrefs.getBool('180Sel') ?? true);
      _stepsSel = (hrefs.getBool('stepsSel') ?? true);
      _weightSel = (hrefs.getBool('weightSel') ?? true);
      _fatSel = (hrefs.getBool('fatSel') ?? true);
      _sleepSel = (hrefs.getBool('sleepSel') ?? true);
      _mestDose = (hrefs.getInt('mestDose') ?? 60);
      mestD = (hrefs.getString('mestD') ?? '60');
    });
  }

  void saveTester() async {
    SharedPreferences grefs = await SharedPreferences.getInstance();
    final former = settingKey.currentState;
    former.save();
    grefs.setBool('swallowSel', _swallowSel);
    grefs.setBool('neckSel', _neckSel);
    grefs.setBool('cheekSel', _cheekSel);
    grefs.setBool('breathSel', _breathSel);
    grefs.setBool('extremitySel', _extremitySel);
    grefs.setBool('balanceSel', _balanceSel);
    grefs.setBool('speechSel', _speechSel);
    grefs.setBool('fatigueSel', _fatigueSel);
    grefs.setBool('appetiteSel', _appetiteSel);
    grefs.setBool('lipsSel', _lipsSel);

    grefs.setBool('predSel', _predSel);
    grefs.setBool('180Sel', _180Sel);
    grefs.setBool('stepsSel', _stepsSel);
    grefs.setBool('weightSel', _weightSel);
    grefs.setBool('fatSel', _fatSel);
    grefs.setBool('sleepSel', _sleepSel);
    grefs.setInt('mestDose', _mestDose);
    grefs.setString('mestD', _mestD);
    grefs.setBool('enable911', _enable911);

    print(grefs.getBool('swallowSel'));
    print(grefs.getBool('neckSel'));
    print(grefs.getString('mestD'));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text("Symptom Selector")),
        body: new ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SwitchListTile(
                  title: const Text('Swallow'),
                  dense: true,
                  value: _swallowSel,
                  onChanged: (bool value) {
                    setState(() {
                      _swallowSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Neck'),
                  dense: true,
                  value: _neckSel,
                  onChanged: (bool value) {
                    setState(() {
                      _neckSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Cheeks'),
                  dense: true,
                  value: _cheekSel,
                  onChanged: (bool value) {
                    setState(() {
                      _cheekSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Breathing'),
                  dense: true,
                  value: _breathSel,
                  onChanged: (bool value) {
                    setState(() {
                      _breathSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Extremity'),
                  dense: true,
                  value: _extremitySel,
                  onChanged: (bool value) {
                    setState(() {
                      _extremitySel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Balance'),
                  dense: true,
                  value: _balanceSel,
                  onChanged: (bool value) {
                    setState(() {
                      _balanceSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Altered Speech'),
                  dense: true,
                  value: _speechSel,
                  onChanged: (bool value) {
                    setState(() {
                      _speechSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Fatigue Impact'),
                  dense: true,
                  value: _fatigueSel,
                  onChanged: (bool value) {
                    setState(() {
                      _fatigueSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Appetite'),
                  dense: true,
                  value: _appetiteSel,
                  onChanged: (bool value) {
                    setState(() {
                      _appetiteSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Lip Closure'),
                  dense: true,
                  value: _lipsSel,
                  onChanged: (bool value) {
                    setState(() {
                      _lipsSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Steroids'),
                  dense: true,
                  value: _predSel,
                  onChanged: (bool value) {
                    setState(() {
                      _predSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('180mg Mestinon'),
                  dense: true,
                  value: _180Sel,
                  onChanged: (bool value) {
                    setState(() {
                      _180Sel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Steps'),
                  dense: true,
                  value: _stepsSel,
                  onChanged: (bool value) {
                    setState(() {
                      _stepsSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Weight'),
                  dense: true,
                  value: _weightSel,
                  onChanged: (bool value) {
                    setState(() {
                      _weightSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Percent Fat'),
                  dense: true,
                  value: _fatSel,
                  onChanged: (bool value) {
                    setState(() {
                      _fatSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Sleep'),
                  dense: true,
                  value: _sleepSel,
                  onChanged: (bool value) {
                    setState(() {
                      _sleepSel = value;
                    });
                  }),
              new SwitchListTile(
                  title: const Text('Enable automatic 911 text of Emergency'),
                  dense: true,
                  value: _enable911,
                  onChanged: (bool value) {
                    setState(() {
                      _enable911 = value;
                    });
                  }),
              new FutureBuilder<SharedPreferences>(
                  future: setPrefs,
                  builder: (BuildContext context,
                      AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return const Text('Loading...');
                    mestD = snapshot.requireData.getString('mestD') ?? '60';
                    return new Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: new Form(
                        key: settingKey,
                        child: new TextFormField(
                          //controller: _mestDControl,
                          initialValue: '$mestD',
                          style: new TextStyle(
                              fontSize: 14.0, color: Colors.black),

                          decoration: new InputDecoration(
                            labelText: 'Milligrams per Mestinon Pill:',
                            isDense: true,
                          ),
                          onFieldSubmitted: (val) => _mestD = val,
                          onSaved: (val) => _mestD = val,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  }),
              new Divider(height: 1.0),
              new FlatButton(
                  onPressed: saveTester,
                  color: Colors.black26,
                  child: new Text('Save Settings')),
            ]),
      ),
    );
  }
}
