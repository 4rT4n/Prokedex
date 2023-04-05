import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:super_hero/super_hero.dart';
import 'package:http/http.dart' as http;
import 'DataPreperater.dart';
import 'package:chat_bubbles/chat_bubbles.dart';



Future<void> main() async {

PreperaterFunctions.getTypes();
PreperaterFunctions.getTypes();
  runApp(const MyApp());
}



/**
 * Here we have the appearance of the
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(useMaterial3: true), // standard dark theme
      darkTheme: ThemeData.dark(useMaterial3: true),
      title: 'Find a superhero name',

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SuperHeroName();
  }



class _SuperHeroName extends State<MyHomePage> {
  late Future<List> myFuture;
  late Future<List> theTypes;
  Map<String, Color> theColors = {"grass": Color(0xFF2DCD45),
    "fire": Color(0xFFf08030),
    "water": Color(0xFF149eff),
    "bug": Color(0xFFa8b820),
    "normal": Color(0xFFa8a878),
    "electric": Color(0xFFf8d030),
    "ground": Color(0xFFe0c068),
    "fairy": Color(0xFFee99ac),
    "fighting": Color(0xFF94352d),
    "psychic": Color(0xFff6996F),
    "rock": Color(0xFFb8a038),
    "dragon": Color(0xFF700AEE)
  };

  @override
  void initState() {
    myFuture = PreperaterFunctions.getAllPokemon();
    theTypes = PreperaterFunctions.getTypes();

    super.initState();
  }

  final _SuperHeroNames = <String>[];
  final _hearted = <String>{};

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_selectedIndex.toString()),
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,

        ));
    throw UnimplementedError();
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider();
        }
        if (i ~/ 2 >= _SuperHeroNames.length) {
          _SuperHeroNames.addAll(_GenerateSuperHeroNames());
        }
        return _buildRow(_SuperHeroNames[i ~/ 2]);
      }
      );
    }
    else if (_selectedIndex == 1) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,

          ),
          itemCount: 152,
          itemBuilder: (BuildContext context, int index) {
            return _buildCell(index);
          }
      );
    }


    else
      return Center(
        child: TextButton(child: Text("Drück mich"),
          onPressed: () {
            // Add your onPressed code here!
          },


        ),
      );
  }

  Iterable<String> _GenerateSuperHeroNames() {
    List<String> myNames = [
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
      SuperHero.random(),
    ];
    return myNames;
  }


  Widget _buildRow(String superHeroName) {
    final _markedfav = _hearted.contains(superHeroName);
    return ListTile(
      title: Text(superHeroName),
      trailing: Icon(
        _markedfav ? Icons.favorite : Icons.favorite_border,
        color: _markedfav ? Colors.red : Colors.amberAccent,
      ),
      onTap: () {
        setState(() {
          _markedfav ? _hearted.remove(superHeroName) : _hearted.add(
              superHeroName);
        });
      },
      onLongPress: () {

      },
    );
  }

  Widget _buildCell(int pokeName) {
    final _pokeNameIntern = pokeName;
    var _realame = '';

    return FutureBuilder<List>(
        future: theTypes, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot1) {
          List<Widget> children;
          if (snapshot1.hasData) {
            return GestureDetector(
              onTap: () {
                _pushExample(_pokeNameIntern);
              },
              child: Card(
                color: theColors[snapshot1.data![pokeName]] ?? Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Expanded(child: Container(

                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' +
                                  _pokeNameIntern.toString() + '.png'),
                        ],


                      ),
                    ),
                    ),
                    Center( child: Container(

                      child: FutureBuilder<List>(
                        future: myFuture,
                        // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot<
                            List> snapshot) {
                          List<Widget> children;

                          if (snapshot.hasData) {
                            children = <Widget>[

                              Column(
                                children: [

                                  Text("   " + snapshot.data![pokeName].replaceAll(",", "")  + "\m"),

                                ],

                              ),

                            ];
                          } else if (snapshot.hasError) {
                            children = <Widget>[

                              TextButton(
                                child: Text("Fehler"),
                                onPressed: () {
                                  /* ... */
                                },
                              ),
                            ];
                          } else {
                            children = <Widget>[
                              TextButton(
                                child: Text(""),
                                onPressed: () {
                                  /* ... */
                                },
                              ),
                            ];
                          }
                          return Row(
                              children: children,
                            );

                        },
                      ),

                    )
                    ),

                  ],

                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                _pushExample(_pokeNameIntern);
              },
              child: Card(

                color: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Expanded(child: Container(

                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' +
                                  _pokeNameIntern.toString() + '.png'),
                        ],


                      ),


                    ),


                    ),
                    Expanded(child: Container(

                      child: FutureBuilder<List>(
                        future: myFuture,
                        // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot<
                            List> snapshot) {
                          List<Widget> children;

                          if (snapshot.hasData) {
                            children = <Widget>[

                              Text(snapshot.data![pokeName]
                                  ),
                            ];
                          } else if (snapshot.hasError) {
                            children = <Widget>[

                              TextButton(
                                child: Text("Fehler"),
                                onPressed: () {
                                  /* ... */
                                },
                              ),
                            ];
                          } else {
                            children = <Widget>[
                              TextButton(
                                child: Text(""),
                                onPressed: () {
                                  /* ... */
                                },
                              ),
                            ];
                          }
                          return Center(
                            child: Row(
                              children: children,
                            ),
                          );
                        },
                      ),

                    )),

                  ],

                ),
              ),
            );
          }
        }
    );
  }

  void _pushExample(int superHeroName) {
    Navigator.of(context).push(
        CupertinoPageRoute<void>(builder: (BuildContext context) {
          final _superHeroNameIntern = superHeroName;
          return FutureBuilder<List>(
              future: Future.wait([myFuture, theTypes]),
              // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(

                    appBar: AppBar(
                      backgroundColor: theColors [snapshot.data![1][_superHeroNameIntern].toString()] ?? Colors.transparent ,
                      title: Text(
                          snapshot.data![0][_superHeroNameIntern].toString()


                    ),
                    ),
                    body: Column(

                      children: <Widget>[
                        Container(
                            height: 300,
                            color: theColors [snapshot.data![1][_superHeroNameIntern].toString()] ?? Colors.transparent ,
                          child: Column(
                            children: <Widget>[
                              Expanded(

                                child:Image.network(
                                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' +
                                      _superHeroNameIntern.toString() + '.png',
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width  ,
                                  fit: BoxFit.contain,

                                ),


                              ),


                            ],

                          )


                        ),





                        Padding(padding: EdgeInsets.all(10),
                        child: Text(snapshot.data![0][_superHeroNameIntern].toString(),
                            style: TextStyle(fontSize: 30.0), ),),


                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(6), //apply padding to all four sides
                            child: Text(snapshot.data![1][_superHeroNameIntern],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          elevation: 0,
                          color: theColors [snapshot.data![1][_superHeroNameIntern].toString()] ?? Colors.transparent ,
                          margin: EdgeInsets.all(30),
                        ),
                      ]

                      ),

                    );

                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(""),
                    ),
                  );
                }
              }
          );
        }
        )
    );
  }
}




class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(child: Text('Page 2'), onPressed: () =>{}),
          ),
      );

  }
}


/*
class _MyStatefulWidgetState extends State<MyHomePage> {
  late Future<List> myFuture;
  var CurrentID;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  void initState() {
    myFuture = PreperaterFunctions.getAllPokemon("4");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List>(
        future: myFuture, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('${snapshot.data}'[poke], ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
*/
/*
return GestureDetector(
          onTap: () {
            _pushExample("Joa");
          },
          child:
          Card(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
            const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
          ],
          ),
          ),
        );
 */
/*
return Card(

          margin: const EdgeInsets.all(2),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png'),

                ]
            ),
            Row(
                children: <Widget>[
                  TextButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ]
            ),
          ],
        )
      );
 */