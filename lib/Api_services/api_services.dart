import 'dart:convert';

import 'package:flutter_pro/model/category_list.dart';
import 'package:flutter_pro/model/community_data.dart';
import 'package:http/http.dart' as http;
class ApiServices{

  static Future<List<Data>?> getCategoryList()async{
    List<Data> allCategoryList = [];
    try{
      var url = 'https://alfnr.com/uat/community/category-list';
      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      if(response.statusCode == 200){
        print("******* ${response.statusCode} ********");
        print("******* ${response.body} ********");

        CategoryList categoryList = CategoryList.fromJson(data);
        for(var i in categoryList.data!){
          allCategoryList.add(i);
        }
      }else{
        print("******* No Cat Found ********");
      }
      return allCategoryList;
    }catch(e){
      print("888$e 888888");
    }
    return null;
  }



  static Future <List<String>?> getCommunityData({required int comId})async{
    var comList = <String>[];
    try{
      var url = 'https://alfnr.com/uat/community/data?community_id=$comId';
      final response = await http.get(Uri.parse(url));
      var data  = jsonDecode(response.body);
      print("----***--- ${response.statusCode} ----***-- ");
      if(response.statusCode == 200 ){
        print("------- ${response.statusCode} ------ ");
        print("------- ${response.body} ------ ");
         CommunityData  communityData = CommunityData.fromJson(data);
         for(var i in communityData.data!.sendTo!){
           comList.add(i);
         }
      }else{
        print("------- Community data not working ------ ");

      }
      return comList;

    }catch(e){

    }
    return null;
  }
}