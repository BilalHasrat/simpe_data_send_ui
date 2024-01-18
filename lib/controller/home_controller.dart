
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/Api_services/api_services.dart';
import 'package:flutter_pro/model/category_list.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';


class HomeController with ChangeNotifier{

  bool isCategoryOpen = false;
  bool isSubCategoryOpen = false;
  var selectCat = 'Select Category';
  int?  selectCatId ;
  int?  currentIndex ;
  List <File> images = [];
  final picker = ImagePicker();
  String selectFile = '';
  PlatformFile? file;
  bool showEmoji = false;
  var categoryList = <Data>[];
  var communityList = <String>[];
  final titleController = TextEditingController();
  final descController = TextEditingController();
  var contactNo = '';
  var comunityId = '';

  void setEmoji(){
    showEmoji =! showEmoji;
    notifyListeners();
  }
  void onFieldTap(){
    showEmoji = false;
    notifyListeners();
  }
  setSelectCat(String value, int id){
    selectCat = value;
    selectCatId = id;
    notifyListeners();
  }
  void setIsCatListOpen(){
    isCategoryOpen =! isCategoryOpen;
    notifyListeners();
  }
  void setIsSubCatListOpen(){
    isSubCategoryOpen =! isSubCategoryOpen;
    notifyListeners();
  }
  void subCatIndex(index){
    if(currentIndex == index){
      currentIndex = null;
    }else{
      currentIndex = index;
    }
  }

   getImageFromGallery(context)async{
    final List<XFile> pickedImage = await picker.pickMultiImage();
    for(var img in pickedImage ){
      images.add(File(img.path));
    }
    notifyListeners();
  }

  Future<void> getWordFile(context)async{
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
         allowedExtensions: ['xlsx','pdf'],
      );
      if (result != null) {
        file = result.files.first;
        print('*************${file!.extension}***********');
        print('*************${file?.name}***********');
        if(file!.extension == 'pdf' || file!.extension == 'xlsx'){
          File _file = File(result.files.single.path!);
          selectFile = _file.path;
          notifyListeners();
        }
      }
    } catch (error) {
      print(error);
    }
  }

  // For Fetching Category list
  fetchCategoryList()async{
    try{
      var catList = await ApiServices.getCategoryList();
      if(catList != null){
        categoryList = catList  ;
        notifyListeners();
      }else{
        print("******* Category Not fetching ********");

      }
    }catch(e){
      print("******* $e ********");

    }
  }

  // For Fetching Community List
  fetchCommunityList({required int comId})async{
    try{
      var comList = await ApiServices.getCommunityData(comId: comId);
      if(comList != null){
        communityList = comList;
        notifyListeners();
      }else{
        print("------- Community list not fetching ------ ");
      }
    }catch(e){
      print("------- $e ------ ");

    }
  }

  Future<void> createCampaignApi (context)async{
    var request = http.MultipartRequest('POST', Uri.parse('https://alfnr.com/uat/campaign/create'));
    request.fields.addAll({
      'community_id': comunityId,
      'title': titleController.text,
      'description': descController.text
    });
    for(var i in images ){
      request.files.add(await http.MultipartFile.fromPath('images[]',i.path));
      print('----1-1---1--1-1--1--1-1--1-1-1-1-1-1-1-1-');
    }
    request.files.add(await http.MultipartFile.fromPath('attachment', selectFile));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Data Sent Successfully',style: TextStyle(color: Colors.white),)));
      print('${await response.stream.bytesToString()}00000000000000000000000000000');
    }
    else {
      print(response.reasonPhrase);
    }

  }


  Future<void> shareImageOnWhatsApp() async {
    String phone = contactNo; // Replace with the recipient's phone number
    String text = titleController.text;
    String imagePath = Uri.encodeFull( images[0].path); // Replace with the actual image path
    String url = 'whatsapp://send?phone=$phone&text=$text&image=$imagePath';

    try{
      launchUrl(Uri.parse(url));

    }catch(e){
      print('----Error launching WhatsApp: $e--------');

    }
  }



// Future<void> shareFile(no ,context) async {
  //   await WhatsappShare.shareFile(
  //     phone: '+923451909646',
  //     text: titleController.text,
  //     filePath: [images[0].path,images[1].path,images[2].path],
  //     package: Package.businessWhatsapp
  //   );
  // }



}

