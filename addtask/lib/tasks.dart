import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/timer.dart';

class focustask extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<focustask> {
  //database bağlantısı sağlandı.
  final dbhelper = Databasehelper.instance;

  // fonksiyonlar için gerekli olan tanımlamalar gerçekleştirildi.
  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>();

  //listeye task ekleyebilmek için gerkli olan kodlar yazıldı.
  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
    };
    final id = await dbhelper.insert(row);
    Navigator.pop(context);
    todoedited = "";
    setState(() {
    });
  }
  //tasklerin yazılacağı kart yapıları için gerekli komutlar yazıldı.
  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(
          Card(
             elevation: 10.0,
             margin: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 4.0,
             ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(

            title: Text(
              row['todo'],
              style: TextStyle(
                fontSize: 20.0,

              ),
            ),
            //task içindeki çöp kutusu iconu
            leading: new Icon(Icons.delete, color: Color(0xFF4CB2C6),size: 28.0,
            ),
            //taske uzun süre basılı tutunca silinmesini sağlayacak olan kod parçası.
            onLongPress: () {
              dbhelper.deletedata(row['id']);
              setState(() {});
            },
          ),

        ),
      )
      );
    });
    return Future.value(true);
  }
  //task eklemek için aşağıda bulunan büyük '+' butonuna basıldığında karşılaşılan ekran için gerekli olan kodlar yazıldı.
  void popup() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(
                "ADD TASK",
                style: TextStyle(
                  color:Color(0xFF03989E),
                ),

              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  TextField(
                    onChanged: (_val) {
                      todoedited = _val;
                    },
                    style: TextStyle(
                      fontSize: 23.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            addtodo();
                          },
                          color: Color(0xFF03989E),
                          child: Text(
                              "ADD",
                              style: TextStyle(
                                color:Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
//uygulamanın ana ekranı için iki şart yazıldı.İlk şart hiç task eklenmediğinde çalıştırılacak kodlar
// ikincisi ise task eklendiği zaman çalıştırıcalacak.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        {
          if (myitems.length == 0) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: popup,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF03989E),
              ),
              //katlanır menü ve içerisindeki logo
              drawer: Drawer(
                child:Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: AssetImage("lib/assets/images.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    //katlanır menüdeki buton halindeki seçenekler.
                    ListTile(
                      leading: Icon(Icons.account_circle_rounded,color:Colors.black),
                      title:Text('MY PROFIL'),
                      onTap:() {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_alarm,color:Colors.black),
                      title:Text('TIMER'),
                      onTap:() {
                        //timer seçeneğine tıklandığında timer ekranının çalışması için gereken kod.
                        Navigator.push(context,MaterialPageRoute( builder:(context)=>timer()),);
                      },
                    ),
                  ],
                )
              ),
              //uygulamanın başlık kısmı
              appBar: AppBar(
                titleSpacing: 30,
                shadowColor: Colors.white,
                backgroundColor: Color(0xFF03989E),
                centerTitle: true,
                title: Text(
                  "My Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              //uygulamada task yokken ekranda belirmesini istediğimiz yazı içim olan kodlar.
              body: Center(
                child: Text(
                  "LET'S ADD TASK",
                  style: TextStyle( fontSize: 20.0,color: Color(0xFF03989E)),
                ),
              ),
            );
          } else {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: popup,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF03989E),
              ),
              drawer: Drawer(
                  child:Column(
                    children: [
                      DrawerHeader(
                    child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("lib/assets/images.png"),
                      fit: BoxFit.cover,
                        ),
                      ),
                  ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,color:Colors.black),
                        title:Text('MY PROFIL'),
                        onTap:() {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_alarm,color:Colors.black),
                        title:Text('TIMER'),
                        onTap:() {
                          Navigator.push(context,MaterialPageRoute( builder:(context)=>timer()),);
                        },
                      )
                    ],
                  )
              ),
              appBar: AppBar(
                titleSpacing: 30,
                backgroundColor: Color(0xFF03989E),
                centerTitle: true,
                shadowColor: Colors.white,
                actions: <Widget>[

                  Icon(Icons.arrow_forward, size: 30,color:Colors.white),
                ],
                title: Text(
                  " My Tasks ",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              backgroundColor: Color(0xF5F0FFFF),
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
