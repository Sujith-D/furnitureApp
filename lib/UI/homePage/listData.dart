import 'package:flutter/material.dart';
import 'package:furniture/UI/detailsPage.dart';
import 'package:furniture/data/provider.dart';

class ListDataWidget extends StatelessWidget {
  const ListDataWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FurnitureProvider model;

  @override
  Widget build(BuildContext context) {
    return 
    model.isSelected ?
    Expanded(
      child: ListView.builder(
      itemCount: model.renderData.length,
      itemBuilder: (context, index)  {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => detailsPage(singleData: model.renderData[index]),));
          },
          child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
          children: [
            Image(
              image: NetworkImage(
              model.renderData[index].imageURL),
             height: MediaQuery.of(context).size.height/3.8,
             fit: BoxFit.cover,
             ),
            Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Align(alignment: Alignment.center,child: Text(model.renderData[index].title,style: 
                      TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 20,fontStyle: FontStyle.italic))),
                      SizedBox(height: 5,),
                    Align(alignment: Alignment.center,child: Text("\$" + model.renderData[index].cost.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18,fontStyle: FontStyle.italic))),
                    SizedBox(height:5,),
                  ],),
                )
          ],
              ),
            ),
        );
      })):
    Expanded(
      child: ListView.builder(
      itemCount: model.completeData.length,
      itemBuilder: (context, index)  {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => detailsPage(singleData: model.completeData[index]),));
          },
          child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
          children: [
            Image(
              image: NetworkImage(
              model.completeData[index].imageURL),
             height: MediaQuery.of(context).size.height/3.8,
             fit: BoxFit.cover,
             ),
            Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Align(alignment: Alignment.center,child: Text(model.completeData[index].title,style: 
                      TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 20,fontStyle: FontStyle.italic))),
                      SizedBox(height: 5,),
                    Align(alignment: Alignment.center,child: Text("\$" + model.completeData[index].cost.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18,fontStyle: FontStyle.italic))),
                    SizedBox(height:5,),
                  ],),
                )
          ],
              ),
            ),
        );
      }));
  }
}