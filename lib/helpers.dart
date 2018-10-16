import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
//import 'dart:collection';
import 'dart:core';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Strings {
  static String warning1 =
      'Many different drugs have been associated with worsening myasthenia gravis (MG). However, '
      'these drug associations do not necessarily mean that a patient with MG should not be prescribed these medications '
      'because in many instances the reports are very rare and in some instances they might only be a "chance" association '
      '(i.e. not causal). \nAlso some of these drugs may be necessary for a patient\’s treatment. Therefore, some of these '
      'drugs should not necessarily be considered "off limits" for MG patients. Careful thought needs to go into decisions '
      'about prescription. \nIt is advisable that patients and physicians recognize and discuss the possibility that a '
      'particular drug might worsen the patient\’s MG. They should also consider, when appropriate, the pros and cons of an '
      'alternate treatment, if available.  \nIt is important that the patient notify his or her physicians if the symptoms of MG '
      'worsen after starting any new medication. \nFor more information, the MGFA has an excellent review article for health '
      'professionals, found at the myasthenia.org website. For this app, we are only listing the more common prescription '
      'drugs with the strongest evidence suggesting an association with worsening MG.\n\n';

  static String commonscript =
      'Some of the more common prescription drugs associated with worsening MG:';

  static String ketek =
      'Telithromycin (Ketek) – inpatient drug for serious pneumonia. Should not be used in patients '
      'with MG. FDA has designated a “black box” warning (see below for explanation) on this drug in MG patients.';

  static String fluoroq =
      'The fluoroquinolones, including Ciprofloxacin and Levofloxacin – commonly prescribed '
      'antibiotics that are rarely associated with worsening MG. The US FDA has designated a “black box warning” on '
      'Ciprofloxacin/Avelox and Levofloxacin. Use cautiously, if at all.';

  static String zpack =
      'Zithromax (e.g. “Z-pak”) – commonly prescribed but potentially dangerous in MG. Use '
      'cautiously, if at all.';

  static String neomycin =
      'Gentamycin, neomycin (aminoglycoside antibiotics; tobramycin may be least offensive) – use '
      'cautiously if no alternative treatment available. Other antibiotics have been rarely reported with worsening MG. '
      'Please discuss with physician.';

  static String botox = 'Botulinum toxin (e.g. “Botox”) – avoid.';

  static String steroids =
      'Steroids (e.g. prednisone) – steroids are a common treatment for MG but patients who start '
      'steroids may have transient worsening of their MG during the first two weeks prior to an improvement in their MG. '
      'Thus, patients need to monitor carefully for this possibility.';

  static String quinine = 'Quinine - sometimes used for leg cramps.';

  static String procainamide =
      'Procainamide - cardiac drug used for irregular heart rhythm.';

  static String magnesium =
      'Magnesium in patients with kidney disease; potentially dangerous if given intravenous, for '
      'example, for eclampsia treatment during late pregnancy. (Many multivitamins contain small amounts of magnesium, which '
      'is okay.)';

  static String dpen =
      'D-penicillamine - drug rarely used these days but strongly associated with causing MG.';

  static String beta =
      'Beta-blockers – commonly prescribed for hypertension, heart disease and migraine but '
      'potentially dangerous in MG. Use cautiously, if necessary.';

  static String blackbox =
      'In the US, a “black box warning” (also known as boxed warning) is an alert that appears on the '
      'package insert for certain prescription drugs. A black box warning signifies that studies have shown the drug '
      'carries a significant risk of a serious or life-threatening adverse event. The black box warning is the strongest '
      'warning by the US FDA. For MG patients, some of the drugs that carry black box warnings include the fluoroquinolones '
      '(e.g. Ciprofloxacin, Levafloxacin; see above) and Telethromycin (i.e. Ketek); these particular antibiotics have been '
      'associated with worsening of MG in some patients. Mycophenolate mofetil (CellCept) also carries a black box warning for '
      'an increased risk of teratogenicity (e.g. malformation of fetus in utero) for pregnant mothers. MG patients should '
      'discuss potential risks of these drugs (and others on the provided list above) with their doctors';

  static String vaccine =
      'Vaccinations: It is generally believed that vaccinations (e.g. influenza) are safe in patients '
      'with MG (with a major caveat below). The evidence suggests that vaccine-related worsening of MG is rare and thus most '
      'MG specialists believe the benefits of immunization outweigh any small risk related to possible transient worsening of '
      'MG symptoms.';

  static String vacc2 =
      'Exception/caveat: If you are taking immunosuppressive medication, such as Prednisone, Azathioprine '
      'or Mycophenolate, it is usually recommended that you avoid live, attenuated vaccines. Examples of live, attenuated '
      'vaccines include the shingles vaccine and the nasal spray form of the influenza vaccine (the influenza injection is '
      'inactivated and thus not alive, so it is much safer in immunosuppressed patients). You need to discuss this with any '
      'doctor when considering a vaccine. If you are not sure, you should ask your doctor if you are taking immunosuppressive '
      'drugs and, if so, if the vaccine is safe in that setting. It’s worth noting that most vaccines are inactivated '
      '(e.g. dead), but because there are a few vaccines that are alive and attenuated (i.e. the pathogen is alive but not '
      'very virulent and thus immunizes the patient without causing the disease) and because the live, attenuated vaccines '
      'carry higher risk for those who are immunosuppressed, this technicality about vaccines is important and is always worth '
      'consideration.';

  static String sbcDirection =
      'Inhale as much air as you can in a single breath. As you exhale, quickly count out loud until you need to breathe again.\n'
      'What number did you get to?';

}






class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: 'Date/Time',
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () { _selectTime(context); },
          ),
        ),
      ],
    );
  }
}

class SymDateTimePicker extends StatelessWidget {
  const SymDateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }


  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: 'Date',
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        const SizedBox(width: 12.0),

      ],
    );
  }
}


class DatabaseClient {
  Database _db;
  int dbVersion = 1;
  String tableName = "sbcTracking";
  String dbName ='sbcData.db';
  String dbPath;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    dbPath = join(path.path, dbName);

    _db = await openDatabase(dbPath, version: dbVersion, onCreate: this._create);
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE $tableName (
              id INTEGER PRIMARY KEY, 
              date TEXT NOT NULL,
              time TEXT NOT NULL,
              count TEXT NOT NULL,
              unixtime INTEGER NOT NULL
            )""");


  }

  Future countRecs() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, tableName);
    Database db = await openDatabase(dbPath);
    List breathList = await _db.rawQuery('SELECT date, time, count FROM $tableName');
    var counted = Sqflite
        .firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    //var count = await db.rawQuery("SELECT COUNT(*) FROM $tableName");
    //List list = await db.rawQuery('SELECT date, time, count FROM $tableName');
    await db.close();
    return [breathList, counted];
  }

  Future<Breath> upsertBreath(Breath breath) async {
    if (breath.id == null) {
      breath.id = await _db.insert(tableName, breath.toMap());
    } else {
      await _db.update(tableName, breath.toMap(), where: "id = ?", whereArgs: [breath.id]);
    }
    int count = Sqflite
        .firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    print('Record count = $count');
    List<Map> plist = await _db.rawQuery('SELECT * FROM $tableName');
    print(plist);

    return breath;
  }

  Future<List<Breath>> fetchLatestBreath(int limit) async {
    List<Map> results = await _db.query(tableName,
        columns: Breath.columns, limit: limit, orderBy: "id DESC");

    List<Breath> breaths = new List();
    results.forEach((results) {
      Breath breath = Breath.fromMap(results);
      breaths.add(breath);
    });

    return breaths;
  }

  Future<Breath> fetchBreath(int id) async {
    List<Map> results = await _db.query(tableName,
        columns: Breath.columns, where: "id = ?", whereArgs: [id]);

    Breath story = Breath.fromMap(results[0]);

    return story;
  }

  dynamic dbaseTester() async {
    create;

    List<Breath> items = await fetchLatestBreath(5);
    print(items);
  }

}

class Breath {
  Breath();

  int id;
  String date;
  String time;
  String count;
  int unixtime;

  static final columns = ["id", "date", "time", "count", "unixtime"];

  Map toMap() {
    Map map = <String,dynamic>{
      "date": date,
      "time": time,
      "count": count,
      "unixtime": unixtime,

    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Breath breath = new Breath();
    breath.id = map["id"];
    breath.date = map["date"];
    breath.time = map["time"];
    breath.count = map["count"];
    breath.unixtime = map["unixtime"];

    return breath;
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseClientex _db = new DatabaseClientex();
  int number;
  List listCategory;
  List<Widget> tiles;

  List colors = [
    const Color(0xFFFFA500),
    const Color(0xFF279605),
    const Color(0xFF005959)
  ];

  createdb() async {
    await _db.create().then(
            (data){
          _db.countCategory().then((list){
            setState(() {
              this.number = list[0][0]['COUNT(*)']; //3
              this.listCategory = list[1];
              //[{name: foo1, color: 0}, {name: foo2, color: 1}, {name: foo3, color: 2}]
            });
          });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    createdb();
  }

  void showCategoryDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      child: child,
    )
        .then<Null>((T value) {
      if (value != null) {
        setState(() { print(value); });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> buildTile(int counter) {
      this.tiles = [];
      for(var i = 0; i < counter; i++) {
        this.tiles.add(
            new DialogItem(
                icon: Icons.brightness_1,
                color: this.colors[
                this.listCategory[i]['color']
                ],
                text: this.listCategory[i]['name'],
                onPressed: () {
                  Navigator.pop(context, this.listCategory[i]['name']);
                }
            )
        );
      }
      return this.tiles;
    }

    return new Scaffold(
      appBar: new AppBar(title: new Text('SBC Results')),
      body: new Center(
          child: new RaisedButton(
            onPressed: (){
              showCategoryDialog<String>(
                  context: context,
                  child: new SimpleDialog(
                      title: const Text('Categories'),
                      children: buildTile(this.number)
                  )
              );
            },
            child: new Text("ListButton"),
          )
      ),
    );
  }
}


//******************************************************************
//Example to learn from - NOT part of the MG app
// Creating Database with some data and two queries
class DatabaseClientex {
  Database db;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    db = await openDatabase(dbPath, version: 1, onCreate: this._create);
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE category (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              color INTEGER NOT NULL
            )""");
    await db.rawInsert("INSERT INTO category (name, color) VALUES ('foo1', 0)");
    await db.rawInsert("INSERT INTO category (name, color) VALUES ('foo2', 1)");
    await db.rawInsert("INSERT INTO category (name, color) VALUES ('foo3', 2)");
  }

  Future countCategory() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);

    var count = await db.rawQuery("SELECT COUNT(*) FROM category");
    List list = await db.rawQuery('SELECT name, color FROM category');
    await db.close();

    return [count, list];
  }
}

//Class of Dialog Item
class DialogItem extends StatelessWidget {
  DialogItem({
    Key key,
    this.icon,
    this.size,
    this.color,
    this.text,
    this.onPressed }) : super(key: key);

  final IconData icon;
  double size = 36.0;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new SimpleDialogOption(
        onPressed: onPressed,
        child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                  child: new Container(
                    margin: size == 16.0 ? new EdgeInsets.only(left: 7.0) : null,
                    child: new Icon(icon, size: size, color: color),
                  )
              ),
              new Padding(
                padding: size == 16.0 ?
                const EdgeInsets.only(left: 17.0) :
                const EdgeInsets.only(left: 16.0),
                child: new Text(text),
              ),
            ],
          ),
        )
    );
  }
}

//*****************************************************************
// End of example code




//**************************************************
//*******  Database Helper for Daily Symptom Entry
//**************************************************

class DailyDatabaseClient {
  Database _db;
  int dbVersion = 1;
  String tableName = "symptomTrackingTest5";
  String tempTable = "tempSymptomID";
  String dbName ='symptomData.db';
  String dbPath;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    dbPath = join(path.path, dbName);

    _db = await openDatabase(dbPath,
      version: dbVersion,
      onCreate: this._create,
      onUpgrade: this._onUpgrade, );
  }

  Future _create(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tempTable (
        idTemp INTEGER PRIMARY KEY,
        idSymp INTEGER)
    """);

    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        date TEXT NOT NULL,
        swallow REAL,
        neck REAL,
        cheek REAL,
        breath REAL,
        extrem REAL,
        balance REAL,
        slur REAL,
        fatigue REAL,
        appetite REAL,
        lip REAL,
        nasal TEXT,
        tingle TEXT,
        ptosis TEXT,
        regurg TEXT,
        residue TEXT,
        sorethroat TEXT,
        diplopia TEXT,
        coughs REAL,
        sixty REAL,
        release INTEGER,
        pred REAL,
        weight REAL,
        pcfat REAL,
        steps INTEGER,
        sleephrs REAL,
        comment TEXT,
        remember TEXT,
        unixtime INTEGER NOT NULL)
        
    """);
  }


  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {


    if(oldVersion == 1) {
      //await db.execute("ALTER TABLE $tableName ADD COLUMN sixty REAL");
      //await db.execute("ALTER TABLE $tableName ADD COLUMN pred REAL");
      //await db.execute("ALTER TABLE @tableName ADD COLUMN weight REAL");

    }

    if(oldVersion == 2) {
      //await db.execute("ALTER TABLE $tableName ADD COLUMN sixty REAL");
      //await db.execute("ALTER TABLE $tableName ADD COLUMN pred REAL");
      //await db.execute("ALTER TABLE @tableName ADD COLUMN weight REAL");

    }
    //_create(db, dbVersion);

  }

  /*id INTEGER PRIMARY KEY," +
              "date TEXT NOT NULL,"+
              //"comment TEXT," +
              //"coughs REAL NOT NULL, " +
              "swallow REAL," +
              //"cheek REAL, " +
              "neck REAL," +
              "breath REAL, sixty REAL," +
              "release REAL, tingle TEXT," +
              "nasal TEXT, ptosis TEXT," +
              "extrem REAL, balance REAL," +
              "lip REAL, pred REAL," +
              "regurg TEXT, residue TEXT," +
              "weight REAL, slur REAL," +
              "sorethroat TEXT, fatigue REAL," +
              "fatpc REAL, remember TEXT," +
              "diplopia TEXT, steps INTEGER," +
              "appetite REAL, sleephrs REAL, "unixtime INTEGER NOT NULL"*/


  Future countSymRecs() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, tableName);
    Database db = await openDatabase(dbPath);

    List symList = await _db.rawQuery('SELECT date, swallow FROM $tableName');
    var symcount = Sqflite
        .firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tableName"));

    await db.close();

    return [symList, symcount];
  }

  Future<SymMapper> upsertSymptoms(SymMapper symptoms) async {
    if (symptoms.id == null) {
      symptoms.id = await _db.insert(tableName, symptoms.toMap());
    } else {
      await _db.update(tableName,
          symptoms.toMap(),
          where: "id = ?",
          whereArgs: [symptoms.id]);
    }

    int count = Sqflite
        .firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    print('Record count = $count');
    List<Map> symplist = await _db.rawQuery('SELECT * FROM $tableName');
    print(symplist);
    await _db.close();
    return symptoms;
  }

  Future<SymMapper> updateSym(SymMapper sympHist) async {
    await _db.update(tableName,
        sympHist.toMap(),
        where: "id = ?",
        whereArgs: [sympHist.id]);
    await _db.close();
    return sympHist;
  }


  Future<int> delete(int id) async {
    return await _db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<SymMapper>> getLastSymptoms() async {
    List<Map> lastResult = await _db.rawQuery('SELECT * FROM $tableName');
    print(lastResult.last);

    await _db.close();
    return lastResult.map((mapped) => SymMapper.fromMap(mapped)).toList();
  }

  Future<List<SymMapper>> fetchLatestSymptoms(int limit) async {
    List<Map> results = await _db.query(tableName,
        columns: SymMapper.columns, limit: limit, orderBy: "id DESC");
    //List<Map> results = await _db.query(tableName,
    //limit: limit, orderBy: "id");


    List<SymMapper> latestsyms = new List();
    results.forEach((results) {
      SymMapper xbreath = SymMapper.fromMap(results);
      latestsyms.add(xbreath);
    });
    //print(latestsyms);

    await _db.close();
    if (results.length > 0) {
      //return results.map((mapped) => SymMapper.fromMap(mapped)).toList();
      return latestsyms;
    }else{
      return null;}
  }

  Future<SymMapper> fetchSymptom(int id) async {
    List<Map> results = await _db.query(tableName,
        columns: SymMapper.columns, where: "id = ?", whereArgs: [id]);

    SymMapper dayinfo = SymMapper.fromMap(results[0]);
    _db.close();
    return dayinfo;
  }

  dynamic dbaseTester() async {
    create;

    List<SymMapper> items = await fetchLatestSymptoms(2);
    print(items);
  }

  Future idConvert() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, dbName);
    Database dbk = await openDatabase(dbPath);
    await dbk.transaction((txn) async {
      await txn.rawInsert('INSERT INTO $tempTable(idSymp) SELECT id FROM $tableName WHERE id > 0');
      List<Map> templist = await _db.rawQuery('SELECT * FROM $tempTable');
      print(templist);
    });


  }

}

class SymMapper {
  SymMapper();

  int id;
  String date;
  String comment;
  double coughs;
  double swallow;
  double cheek;
  double neck;
  double breath;
  double sixty;
  int release;
  String tingle;
  String nasal;
  String ptosis;
  double extrem;
  double balance;
  double lip;
  double pred;
  String regurg;
  String residue;
  double weight;
  double slur;
  String sorethroat;
  double fatigue;
  double pcfat;
  String remember;
  String diplopia;
  int steps;
  double appetite;
  double sleephrs;
  int unixtime;

  static final columns = ["id", "date", "swallow", "neck", "cheek", "breath", "extrem",
  "balance", "slur", "fatigue", "appetite", "lip", "nasal", "tingle",
  "ptosis", "regurg", "residue", "sorethroat", "diplopia", "coughs",
  "sixty", "release", "pred", "weight", "pcfat", "steps", "sleephrs",
  "comment", "remember", "unixtime"];

  static final fcolumns = ["id", "date", "comment", "coughs", "swallow", "cheek",
  "neck", "breath", "sixty", "release", "tingle", "nasal", "ptosis", "extrem",
  "balance", "lip", "pred", "regurg", "residue", "weight", "slur", "sorethroat",
  "fatigue", "fatpc", "remember", "diplopia", "steps", "appetite", "sleephrs", "unixtime"];

  Map toMap() {
    Map<String, dynamic> map = {
      "date": date,
      "comment": comment,
      "coughs": coughs,
      "swallow": swallow,
      "cheek": cheek,
      "neck": neck,
      "breath": breath,
      "sixty": sixty,
      "release": release,
      "tingle": tingle,
      "nasal": nasal,
      "ptosis": ptosis,
      "extrem": extrem,
      "balance": balance,
      "lip": lip,
      "pred": pred,
      "regurg": regurg,
      "residue": residue,
      "weight": weight,
      "slur": slur,
      "sorethroat": sorethroat,
      "fatigue": fatigue,
      "pcfat": pcfat,
      "remember": remember,
      "diplopia": diplopia,
      "steps": steps,
      "appetite": appetite,
      "sleephrs": sleephrs,
      "unixtime": unixtime,

    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    SymMapper symmapped = new SymMapper();
    symmapped.id = map["id"];
    symmapped.date = map["date"];
    symmapped.comment = map["comment"];
    symmapped.coughs = map["coughs"];
    symmapped.swallow = map["swallow"];
    symmapped.cheek = map["cheek"];
    symmapped.neck = map["neck"];
    symmapped.breath = map["breath"];
    symmapped.sixty = map["sixty"];
    symmapped.release = map["release"];
    symmapped.tingle = map["tingle"];
    symmapped.nasal = map["nasal"];
    symmapped.ptosis = map["ptosis"];
    symmapped.extrem = map["extrem"];
    symmapped.balance = map["balance"];
    symmapped.lip = map["lip"];
    symmapped.pred = map["pred"];
    symmapped.regurg = map["regurg"];
    symmapped.residue = map["residue"];
    symmapped.weight = map["weight"];
    symmapped.slur = map["slur"];
    symmapped.sorethroat = map["sorethroat"];
    symmapped.fatigue = map["fatigue"];
    symmapped.pcfat = map["pcfat"];
    symmapped.remember = map["remember"];
    symmapped.diplopia = map["diplopia"];
    symmapped.steps = map["steps"];
    symmapped.appetite = map["appetite"];
    symmapped.sleephrs = map["sleephrs"];
    symmapped.unixtime = map["unixtime"];
    /*
    id = map["id"];
    date = map["date"];
    comment = map["comment"];
    coughs = map["coughs"];
    swallow = map["swallow"];
    cheek = map["cheek"];
    neck = map["neck"];
    breath = map["breath"];
    sixty = map["sixty"];
    release = map["release"];
    tingle = map["tingle"];
    nasal = map["nasal"];
    ptosis = map["ptosis"];
    extrem = map["extrem"];
    balance = map["balance"];
    lip = map["lip"];
    pred = map["pred"];
    regurg = map["regurg"];
    residue = map["residue"];
    weight = map["weight"];
    slur = map["slur"];
    sorethroat = map["sorethroat"];
    fatigue = map["fatigue"];
    pcfat = map["pcfat"];
    remember = map["remember"];
    diplopia = map["diplopia"];
    steps = map["steps"];
    appetite = map["appetite"];
    sleephrs = map["sleephrs"];
    unixtime = map["unixtime"];
*/
    return symmapped;
  }

}

//Create a separate database for temporary creating a lisr of sequential id numbers
//that correspond to list of symptom record id numbers that might have gaps
//The next/previous function would use these id numbers to select the proper
//symptom record id to query

