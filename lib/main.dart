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

      home: MyHomePage(name: "Jinny",),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String name;
  static const Map<String, Color> theColors = {"grass": Color(0xFF2DCD45),
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
  MyHomePage({required this.name});
  @override
  State<StatefulWidget> createState() => _SuperHeroName();
  }



class _SuperHeroName extends State<MyHomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prokedex"),
      ),
      body:
      GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,

          ),
          itemCount: 152,
          itemBuilder: (BuildContext context, int index) {
            return OneGridCard(name: index.toString());
          }
      ),

    );
    throw UnimplementedError();
  }
}
class OneGridCard extends StatefulWidget {
  final String name;

  OneGridCard({required this.name});

  @override
  State<StatefulWidget> createState() => _pokemon();

}


class _pokemon extends State<OneGridCard> {

  late Future<String> theName;
  late Future<String> theType;

  @override
  void initState() {
      theName = PreperaterFunctions.getAllPokemon(number: '${widget.name}'.toString());
      theType = PreperaterFunctions.getTypes(number: '${widget.name}'.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pushExample(widget.name);
      },
          child: FutureBuilder<List<String>>(
            future: Future.wait([theName, theType]),
            // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<
                List<String>> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                return  Card(color: MyHomePage.theColors[snapshot.data![1]],
                  child: Center(

                      child: Column(
                        children: [
                          Expanded(child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.name}.png'),),
                          Text(snapshot.data![0]),
                          Text(snapshot.data![1]),
                        ],
                      )
                  ),);








              } else if (snapshot.hasError) {
                return  Card(
                  child: Center(

                      child: Column(
                        children: [
                          Expanded(child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.name}.png'),),
                          Text(""),
                          Text(""),
                        ],
                      )
                  ),);
              } else {
                return  Card(
                  child: Center(

                      child: Column(
                        children: [
                          Text(""),
                          Text(""),
                        ],
                      )
                  ),);
              }


            },
          ),




    );



    throw UnimplementedError();
  }


  void _pushExample(String superHeroName) {
    Navigator.of(context).push(
        CupertinoPageRoute<void>(builder: (BuildContext context) {
          final _superHeroNameIntern = superHeroName;
          return FutureBuilder<List>(
              future: Future.wait([theName, theType]),
              // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: MyHomePage.theColors[snapshot.data![1]]?? Colors.transparent,

                    ),
                    body: Column(

                        children: <Widget>[
                          Container(
                            color: MyHomePage.theColors[snapshot.data![1]]?? Colors.transparent,
                            child: Expanded(

                              child: Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.name}.png',
                height: MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width  ,
                                fit: BoxFit.contain,

                              ),


                            ),
                            height: 300,
                          ),

                          Text("Many more information about the pokemon"),


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







