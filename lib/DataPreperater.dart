import 'package:http/http.dart' as http;
import 'dart:convert';

class PreperaterFunctions {


   static  Future<String>  getAllPokemon ( {required String number}) async {
    List<String> allNames = [" "];


      var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/' + number);
      var res = await http.get(url);
      if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
      Map<String, dynamic> theProperty = jsonDecode(res.body.toString());
      String theName = "${theProperty['name']}";
      allNames.add(theName) ;
      print("Halloooo" + theName);

    return await theName;

   }
   static  Future<String>  getTypes ({required number}) async {
    List<String> allNames = [" "];


      var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/' + number);
      var res =   await http.get(url);
      if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
      List<dynamic> theProperty = jsonDecode(res.body)["types"];
      Map<String, dynamic> theName = json.decode(res.body);
      String theList = (theName["types"].toString());
      String theActualName;
      theActualName = theList.split("slot: 1, type: {name: ")[1].split("\,")[0];
      print("["+theActualName+"]");

    return await (theActualName);

   }

   static void getStats({required number}) {

   }


}