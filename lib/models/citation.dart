import "dart:convert";
import "dart:io";

class Citation {
  String id;
  String createdAt;
  String value;

  Citation({this.id = "", this.createdAt = "", this.value = ""});

  //Prendo della map solo i campi interessati
  String getCitation(Map lista) {
    var obj = {
      'id': lista["id"],
      'createdAt': lista["created_at"],
      'value': lista["value"]
    };
    return json.encode(obj);
  }

  //Stampo in console la lista delle categorie 
  void getCategories(String categories) {
    var newCategories = "";
    for (var i = 0; i < categories.length; i++) {
      if (categories[i] != "[" &&
          categories[i] != "]" &&
          categories[i] != "\"") {
        newCategories = newCategories + categories[i];
      }
    }
    List<String> categoriesList = newCategories.split(",");
    for (var element in categoriesList) {
      print("- $element\r");
    }
  }

  //Scrivo il file con dentro i dati
  void generateFile(Map dict){
    //creo il file se non esiste
    File file = File('citations.json'); 
    if(!file.existsSync()) file.createSync();

    List<dynamic> jsonList = [];
    //se il file è vuoto, aggiungo i nuovi dati
    if(file.readAsStringSync() == ""){
      jsonList.add(getCitation(dict));
      file.writeAsStringSync("$jsonList", mode: FileMode.append);
      print(getCitation(dict));
    }
    else{
      //se esiste già, lo sovrascrivo con i dati già presenti + quelli nuovi
      final jsonString = file.readAsStringSync();
      jsonList = json.decode(jsonString);
      jsonList.add(json.decode(getCitation(dict)));
      file.writeAsStringSync(json.encode(jsonList));

      print(getCitation(dict));
    }
  }
}
