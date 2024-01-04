
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeController with ChangeNotifier{

  bool isListOpen = false;
  var selectCat = 'Select Category';
  List<String> catList = ['Computer Shops', 'Automobile Shop', 'Spare parts', 'All'];
  List <File> images = [];
  final picker = ImagePicker();
  String selectFile = '';
  PlatformFile? file;
  bool showEmoji = false;

  void setEmoji(){
    showEmoji =! showEmoji;
    notifyListeners();
  }
  void onFieldTap(){
    showEmoji = false;
    notifyListeners();
  }
  setSelectCat(value){
    selectCat = value;
    notifyListeners();
  }
  void setIsListOpen(){
    isListOpen =! isListOpen;
    notifyListeners();
  }

  void getImageFromGallery(context)async{
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

}