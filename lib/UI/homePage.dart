import 'package:flutter/material.dart';
import 'package:furniture/UI/detailsPage.dart';
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
  TextEditingController _controller = TextEditingController();
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