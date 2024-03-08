import 'package:flutter/material.dart';
import 'dart:io';

class CustomImage extends StatefulWidget{
  File? selectedGif;
  String? imageTitle;
  VoidCallback onPressed;
  CustomImage({super.key , this.imageTitle = "image title" , this.selectedGif , required this.onPressed });
  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      margin: const EdgeInsets.symmetric( horizontal: 20),
      height: 150,
      child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Expanded(child: Image.file( widget.selectedGif! , width: 200,) ,)
                  ),
                  Container(
                    color: Colors.white,
                      child: Expanded(
                        child: SizedBox(
                          width: 148,
                          height: 200,
                          child: Center(child: Text("${widget.imageTitle}")),
                        ),
                      )
                  ),
                ]
      ),
    );
  }
}
