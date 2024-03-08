import 'package:flutter/material.dart';

class InputFields extends StatelessWidget{
  final String hinttext;
  final TextEditingController textEditingController;
  final IconData? icon;
  final TextInputType? keypad;
  final VoidCallback onPressed;
  const InputFields({super.key,
    this.icon,
    this.keypad,
    this.hinttext = "hint text",
    required this.textEditingController,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context){

    return  Padding(
          padding: const EdgeInsets.symmetric( vertical: 5 , horizontal: 25),
          child: Row(
            children: [
              SizedBox(
                width: 240,
                child: TextField(
                  controller: textEditingController,
                  keyboardType: keypad,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(icon),
                    hintText: hinttext,
                    hintStyle:const TextStyle(
                      letterSpacing: 0.8,
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder:const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder:const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )
                  ),

                ),
              ),
              ElevatedButton(onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                  shape: CircleBorder(), padding: EdgeInsets.all(25)) ,
                  child: Text("add title"))
            ],
          ),
    );
  }
}
