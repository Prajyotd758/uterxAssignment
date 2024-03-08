import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final VoidCallback? onPressed;
  final String buttontext;
  const CustomButton({super.key ,this.buttontext = "click me" , this.onPressed});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 25 , vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding :const EdgeInsets.symmetric(vertical: 15),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity , 1),
          elevation: 4
        ),
        child: Text(buttontext),
      )
    );
}
}
