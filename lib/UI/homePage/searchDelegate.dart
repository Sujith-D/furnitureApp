import 'package:flutter/material.dart';
import 'package:furniture/UI/detailsPage.dart';
import 'package:furniture/data/provider.dart';
import 'package:furniture/model/apifile.dart';
import 'package:provider/provider.dart';

class MysearchDelegate extends SearchDelegate{
   

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }else{
        query = '';
        }
      }, )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
    );

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children:[ 
            Text("Sorry No Data Found"),
            IconButton(onPressed: (){
              close(context, null);
            }, icon: Icon(Icons.arrow_back) )
            // IconButton(icon: Icons.arrow_back,)
            ]
         
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final model = Provider.of<FurnitureProvider>(context, listen: false);

    List<Data> title = model.completeData.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return 
    title.length == 0 ? ListTile(
      title: Text("Sorry No Data Found"),
    ):
    ListView.builder(
      itemCount: title.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(title[index].title),
          onTap: (){
            query = title[index].title;
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => detailsPage(singleData:title[index] ,)));
          },
        );
      });
  }

}

