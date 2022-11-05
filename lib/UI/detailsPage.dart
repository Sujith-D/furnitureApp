import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:furniture/UI/homePage/homePage.dart';
import 'package:furniture/data/provider.dart';
import 'package:furniture/model/apifile.dart';
import 'package:provider/provider.dart';

class detailsPage extends StatelessWidget {
  detailsPage({super.key,required this.singleData});
  Data singleData ;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FurnitureProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () {
          Navigator.pop(context);
          },),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.black,))
          ],
        backgroundColor: Colors.white,elevation: 0,),
      body: Stack(
        children: [
          Container(
            color: Colors.blue.shade900,
            child: Container(
              decoration: BoxDecoration(color: Colors.white,
              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/8),
              
              child: Container(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: [0,1,2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber
                          ),
                          child: Image(
                          image:  NetworkImage(
                          singleData.multiImageURL[i] ),
                         height: MediaQuery.of(context).size.height/3.8,
                         fit: BoxFit.cover,
                         )
                        );
                      },
                    );
                  }).toList(), 
                  options: CarouselOptions(height: 400.0)),
              // CarouselSlider()
                const SizedBox(height: 10,),
                Text(singleData.title,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  model.getRequest();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  alignment: Alignment.center,
                  color: Colors.amber,
                  width: double.infinity,
                  height: 50,
                  child: Text("\$ " + singleData.cost.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
              )
              ],
            ),
          )
        ],
      ),
    );
  }
}