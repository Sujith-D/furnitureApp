import 'package:flutter/material.dart';
import 'package:furniture/UI/detailsPage.dart';
import 'package:furniture/UI/homePage/listData.dart';
import 'package:furniture/UI/homePage/searchDelegate.dart';
import 'package:furniture/data/provider.dart';
import 'package:furniture/model/apifile.dart';
import 'package:furniture/model/boolModel.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});
  @override
  State<homePage> createState() => _homePageState();
}


class _homePageState extends State<homePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FurnitureProvider>(context,listen: false).getRequest();
    });

    super.initState();
  }

  List<booleanModel> constrains = [
    booleanModel(data: "All", value: true),
    booleanModel(data: "sofa", value: false),
    booleanModel(data: "Chair", value: false),
    booleanModel(data: "Dinning", value: false),
    ];

  void dataSelected(int index){
      setState(() {
        for (var model in constrains) {
          model.value = false;
        }
        constrains[index].value = true;
      });
    }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FurnitureProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: const Text("DashBoard"),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: MysearchDelegate());
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue.shade900,
            child: Container(
              decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                color: Colors.white,
              ),
              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height/3.5),
            ),
            ),
          
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(constrains.length,(index){
                    return 
                      GestureDetector(
                    onTap: () {
                      setState(() {
                        dataSelected(index);
                        model.selected();
                        model.getData(constrains[index].data);
                      }); 
                    },
                  child: Container(
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: constrains[index].value?Colors.black:Colors.white),
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.center,
                    child: Text(constrains[index].data,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: constrains[index].value?Colors.white:Colors.black),))));
                  })),
                SizedBox(height: 10,),
                model.isLoading ? CircularProgressIndicator():
                ListDataWidget(model: model)
              
              ],
            ),
          )
        ],
      ),
    );
  }
}

