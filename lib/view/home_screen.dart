import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_pro/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    var pro = Provider.of<HomeController>(context,listen: false);
    pro.selectFile = '';
    pro.images = [];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (BuildContext context, pro, Widget? child) {
      return WillPopScope(

        onWillPop: () {
          if (pro.showEmoji) {
            pro.setEmoji();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },

        child: Scaffold(

          appBar: AppBar(
            elevation: 5,
            title: const Text('Select Category').animate().fade(duration: Duration(milliseconds: 1500)),
            centerTitle: true,
          ),

          body: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15, top: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * .07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:  [
                          BoxShadow(
                              color: Colors.blue.shade50,
                              offset: Offset(0, 5),
                              blurRadius: 20,
                              spreadRadius: 1
                          ),
                          BoxShadow(
                              color: Colors.blue.shade50,
                              offset: Offset(0, -5),
                              blurRadius: 20,
                              spreadRadius: 1
                          )
                        ]
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pro.selectCat),
                          InkWell(
                              onTap: (){
                                pro.setIsListOpen();
                              },
                              child: Icon(pro.isListOpen ? Icons.keyboard_arrow_up :Icons.keyboard_arrow_down)),
                        ],
                      ),
                    ),
                  ).animate().fade(duration: Duration(milliseconds: 1500)),

                  if(pro.isListOpen)
                    SizedBox(
                      height: 260,
                      child: Expanded(
                          child: ListView.builder(
                              itemCount: pro.catList.length,
                              itemBuilder: (context, index){
                                return Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    onTap: (){
                                      pro.setSelectCat(pro.catList[index]);
                                        pro.isListOpen = false;
                                    },
                                    leading: Text('No $index'),
                                    title: Text(pro.catList[index]),
                                  ),
                                );
                              })),
                    ),

                  SizedBox(height: 20,),

                  // Title Text
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('Title (Required)',style: TextStyle(color: Colors.blue),),
                  ),

                  MyTextFields(
                    hint: 'Product Title',
                    controller: titleController,
                    maxLine: 1,).animate().fade(duration: Duration(milliseconds: 1500)),

                  SizedBox(height: 20,),

                  // Description Text
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('Description (Required)',style: TextStyle(color: Colors.blue),),
                  ),

                  MyTextFields(
                    hint: 'Description',
                    icon: IconButton(
                      onPressed: () {
                        pro.setEmoji();
                      },
                    icon: Icon(Icons.emoji_emotions),) ,
                    controller: descController,
                    maxLine: null,).animate().fade(duration: Duration(milliseconds: 1500)),

                  if (pro.showEmoji)
                    SizedBox(
                      height: size.height * .35,
                      child: EmojiPicker(
                          textEditingController: descController,
                          config: Config(
                            bgColor: Colors.brown.shade100,
                            columns: 8,
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.00),
                          )),
                    ),

                  SizedBox(height: 10,),

                  // For uploading images
                   myButton(title: 'Upload Images', onTap: () {
                     pro.images = [];
                     pro.getImageFromGallery(context); }, isRequired: '(Optional)',).animate().fade(duration: Duration(milliseconds: 1500)),

                  const SizedBox(height: 10,),

                  // Uploaded Images from gallery will be shown here
                  pro.images.isNotEmpty
                      ? SizedBox(
                    height: 150,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:  [
                            BoxShadow(
                                color: Colors.blue.shade50,
                                offset: Offset(0, 5),
                                blurRadius: 20,
                                spreadRadius: 1
                            ),
                            BoxShadow(
                                color: Colors.blue.shade50,
                                offset: Offset(0, -5),
                                blurRadius: 20,
                                spreadRadius: 1
                            )
                          ]
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 5
                        ),
                          itemCount: pro.images.length,
                          itemBuilder: (context, index){
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                            child: Image.file(pro.images[index],fit: BoxFit.cover,));

                      },),
                    ),
                  )
                      :const SizedBox(),

                  const SizedBox(height: 10,),

                  // For Uploading Attachment
                  myButton(title: 'Upload Attachment', onTap: (){
                    pro.getWordFile(context);
                      }, isRequired: '(Optional)',).animate().fade(duration: Duration(milliseconds: 1500)),

                  const SizedBox(height: 10,),

                  if(pro.selectFile != null && pro.file != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50
                      ),
                      child: ListTile(
                        leading: pro.file!.extension == 'pdf' ? const Icon(Icons.picture_as_pdf,color: Colors.red,) : const Icon(Icons.wordpress),
                        title: Text(pro.file!.name),
                      ),
                    ),

                  const SizedBox(height: 20,),

                  myButton(
                      color: Colors.blue.shade200,
                      isRequired: '', title: 'Save', onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                content: Text('Data Sent Successfully',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 5),),

                            )
                        );
                  })


                ],
              ),
            ),
          ),
        ),
      );
    },);
  }
}

class myButton extends StatelessWidget {
  final String title;
  final String isRequired;
  final VoidCallback onTap;
  Color? color;
   myButton({
    super.key,
    required this.isRequired,
    required this.title,
    required this.onTap,
     this.color = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow:  [
          BoxShadow(
              color: Colors.blue.shade50,
              offset: Offset(0, 5),
              blurRadius: 20,
              spreadRadius: 1
          ),
          BoxShadow(
              color: Colors.blue.shade50,
              offset: Offset(0, -5),
              blurRadius: 20,
              spreadRadius: 1
          )
            ]
        ),
        child:  Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(fontSize: 18),),
            Text(isRequired,style: TextStyle(fontSize: 14),),
          ],
        ),),
      ),
    );
  }
}

class MyTextFields extends StatelessWidget {
  final String hint;
  IconButton? icon;
  final TextEditingController controller;
  int? maxLine ;


   MyTextFields({super.key,
    required this.hint,
    required this.controller,
    this.maxLine,
     this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shadowColor: Colors.blue.shade50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: maxLine,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Colors.blue,
          hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
    );
  }
}
