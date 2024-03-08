import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import './Components/InputFields.dart';
import 'package:flutter/material.dart';
import './Components/custombutton.dart';
import './Components/customimage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';


void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeComponent(),
  ));
}


class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});
  @override
  _HomeComponentState createState() => _HomeComponentState();
}



class _HomeComponentState extends State<HomeComponent>{
  List<File?> gifs = [];
  File? _selectedGif1 , _selectedGif2;
  String? settext;
  String txt1 = "add text here";
  String txt2 = "add text here";
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  final controller = ScreenshotController();

  void selctImage()async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
      allowMultiple: true,
    );

    if (result != null) {

      if(gifs.isEmpty){
        setState(() {
          _selectedGif1 = File(result.files[0].path!);
          _selectedGif2 = File(result.files[1].path!);
          gifs.add(_selectedGif1);
          gifs.add(_selectedGif2);
        });
      }else{
        setState(() {
          gifs.removeRange(0, 2);
          _selectedGif1 = File(result.files[0].path!);
          _selectedGif2 = File(result.files[1].path!);
          gifs.add(_selectedGif1);
          gifs.add(_selectedGif2);
        });
      }
    }
  }

  void setTextOfSecondImage(){
    setState(() {
      if (textEditingController2.text.isEmpty) {
        txt2 = "Add title";
      } else {
        txt2 = textEditingController2.text;
      }
    });
  }
  void setTextOfFirstImage(){
    setState(() {
      if (textEditingController1.text.isEmpty) {
        txt1 = "Add title";
      } else {
        txt1 = textEditingController2.text;
      }
    });
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '_').replaceAll(':', '_');
    final result = await ImageGallerySaver.saveImage(bytes , name : "Gif_$time");
    print(result);
    return result['filePath'];
  }


  void share(Uint8List bytes) async{
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }


  @override
  Widget build(BuildContext context){
      return Scaffold(
        resizeToAvoidBottomInset : true,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectedGif1 != null && _selectedGif2 != null ?
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Screenshot(
                  controller: controller,
                  child: Column(
                      children : [
                        CustomImage( selectedGif:  gifs[0]! , onPressed: setTextOfFirstImage , imageTitle: txt1,),
                        CustomImage( selectedGif:  gifs[1]! , onPressed: setTextOfSecondImage, imageTitle: txt2,),
                      ]
                  ),
                ),
              )
                  : const Text(""),
              CustomButton( buttontext: "Select GIF" , onPressed: selctImage  ,),
              InputFields(icon: Icons.title_rounded, onPressed: setTextOfFirstImage, hinttext: "Enter GIF title", textEditingController: textEditingController1,),
              InputFields(icon: Icons.title_rounded, onPressed: setTextOfSecondImage, hinttext: "Enter GIF title", textEditingController: textEditingController2,),
              CustomButton( buttontext: "Download GIF" , onPressed: () async {
                final image = await controller.capture();
                if (image == null) return;
                await saveImage(image);
              },)
            ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
          child: FloatingActionButton(
            onPressed: () async{
              final image = await controller.capture();
              if (image == null) return;
              share(image);
            },
            child: const Icon(Icons.share_rounded),
          ),
        ),
      );
  }
}