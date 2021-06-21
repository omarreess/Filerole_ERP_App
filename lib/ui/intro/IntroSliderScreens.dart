






import 'package:Filerole/model/constants/Constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:introduction_screen/introduction_screen.dart';

 class IntroSliderScreens extends StatelessWidget {



  @override
  Widget build(BuildContext context) {



    //Viewpager
    return Scaffold(

    body :IntroSlider(
      slides: slides,
      onDonePress: (){
        
      Navigator.pushReplacementNamed(context, 'auth_intro');
      },
    ));
  }
}



//Pages

  final slides  = [
Slide(
  widthImage: 150,
heightImage: 210,
title: "فايل رول\n في أي زمان ومكان",
  description: "برامجنا في فايل رول سحابية تستطيع استخدامها في أي زمان ومكان والمخصصة لكل نوع من أنواع الأنشطة التجارية",


pathImage: "assets/calendar.png",
backgroundColor: clrGreen2.withOpacity(0.9),
),
    Slide(
      widthImage: 150,
      heightImage: 210,
     title: "أنظمة كثيرة برنامج واحد",
     description: "طريقة بناء البرامج في فايل رول مميزة بحيث يحتوي كل برنامج على الكثير من الأنظمة من محاسبة وشؤون موظفين ومستودعات وغيرها",
pathImage: "assets/technical-support.png",
backgroundColor:clrGreen2.withOpacity(0.9),
),
   Slide(

     widthImage: 150,
     heightImage: 210,
     title: "سهولة .. مرونة \n كفاءة",
     description: "مع برامج وخدمات فايل رول أتمت نشاطك التجاري ببرامج مخصصة مهما كان حجمه وبالطريقة التي تريدها بدقائق",

pathImage: "assets/layout.png",
backgroundColor: clrGreen2.withOpacity(0.9),

)];



/*
  intro_slider: ^2.3.3

*/