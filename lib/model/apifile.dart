class FurnitureDataApi{
  List<Data> furnitureData;
  FurnitureDataApi({required this.furnitureData});

  factory FurnitureDataApi.fromJson(List<dynamic> json){
    List<Data> dataList = json.map((c) => Data.fromJson(c)).toList();
    return new FurnitureDataApi(furnitureData: dataList);
  }
}

class Data{
  String title;
  String tag;
  int cost;
  List<dynamic> multiImageURL;
  String imageURL;

  Data({required this.title,required this.tag,required this.cost,required this.imageURL,required this.multiImageURL});

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      title: json['title'], 
      tag: json['tag'], 
      cost: json['cost'], 
      imageURL: json['imageURL'], 
      multiImageURL:json['multiImageURL']);
  }

}