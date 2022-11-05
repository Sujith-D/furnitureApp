import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture/model/apifile.dart';
import 'package:http/http.dart' as http;

class FurnitureProvider extends ChangeNotifier{

bool _isLoading = false;
bool _isSelected = false;
List<Data> _furnitureDataFromApi =[];
List<Data> _renderData = [];

//listData 


var emmuURL = 'http://10.0.2.2:3000/furniture';
var phoneURL = 'http://192.168.1.102:3000/furniture';


List<Data> get completeData => _furnitureDataFromApi;
List<Data> get renderData => _renderData;
bool get isLoading => _isLoading;
bool get isSelected =>_isSelected;

Future<http.Response> getRequest() async{
    _isLoading = true;
    var url = Uri.parse(emmuURL);
    http.Response response = await http.get(url);
    FurnitureDataApi furnitureData = FurnitureDataApi.fromJson(jsonDecode(response.body));
    _furnitureDataFromApi = furnitureData.furnitureData;
    _isLoading = false;
    notifyListeners();
   return response;
}

void selected(){
  _isSelected = true;
  ChangeNotifier();
}

void getData(String tag){
  _renderData.clear();
   if(tag == 'All') {
      _renderData.addAll(_furnitureDataFromApi);
      ChangeNotifier();
      return;
    }
  for(var furnitureData in _furnitureDataFromApi){
    if(furnitureData.tag == tag){
      _renderData.add(furnitureData);
    }
  }
  ChangeNotifier();
 
}




// void separateData(FurnitureProvider data){
//   print(furnitureDataFromApi.length);

// }



// Future loadData() async{
//     String data = await _loadData();
//     print(data);
//     // final jsonResponse = json.decode(data);
//     // FurnitureDataApi furnitureData = new FurnitureDataApi.fromJson(jsonResponse);
//     // print('${furnitureData.furnitureData[0].title} ');
//     //return jsonResponse;
//   }

}