import "package:http/http.dart" as http;
import "models/citation.dart";
import "dart:convert";
import "dart:io";

Future newCitation() async {
  final citazione = Citation();

  final getList = await http.get(Uri.parse("https://api.chucknorris.io/jokes/categories"));
  citazione.getCategories(getList.body);
  
  stdout.write("\nScegli la classe: ");
  String? category = stdin.readLineSync();
  print("");

  final url = Uri.parse("https://api.chucknorris.io/jokes/random?category=$category");
  final res = await http.get(url);
  final Map<String, dynamic> data = json.decode(res.body);
  citazione.generateFile(data);
}
