import 'package:http/http.dart' as http;
import 'dart:convert';

class PreperaterFunctions {


   static  Future<List>  getAllPokemon () async {
    List<String> allNames = [" "];

    for (var i = 1; i<152; i++) {
      var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/' + i.toString());
      var res =   await http.get(url);
      if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
      Map<String, dynamic> theProperty = jsonDecode(res.body.toString());
      String theName = "${theProperty['name']}";
      allNames.add(theName) ;
    }

    return await (allNames);

   }
   static  Future<List>  getTypes () async {
    List<String> allNames = [" "];

    for (var i = 1; i<152; i++) {
      var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/' + i.toString());
      var res =   await http.get(url);
      if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
      List<dynamic> theProperty = jsonDecode(res.body)["types"];
      Map<String, dynamic> theName = json.decode(res.body);
      String theList = (theName["types"].toString());
      String theActualName;
      theActualName = theList.split("slot: 1, type: {name: ")[1].split("\,")[0];
      allNames.add(theActualName);
      print("[" + theActualName + "]");
    }
    print('Howdy' +  allNames.toString() + "\n\n\n\n\n\n\n\n\n");

    return await (allNames);

   }


}