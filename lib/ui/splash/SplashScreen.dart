

import 'package:Filerole/model/constants/Constants.dart';


 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';



    


class SplashScreen extends StatelessWidget {
  final logoPath = 'assets/logosvg.svg';
  final appName = 'Slango';
  final progressbarColour = Colors.indigoAccent;

  @override
  Widget build(BuildContext context) {


    delayTimeToHomeScreen(context);

    return Scaffold(
      body: Container(

        decoration:  BoxDecoration(
          color:clrGrey,
  // borderRadius: BorderRadius.vertical(bottom:  Radius.circular(40)  )

      ),
         child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: SafeArea(
            child: Stack(
              children:[
                Column(
                  children: [

                    logoWidget(),
                    Divider(indent: double.infinity, height: 110,endIndent: double.infinity,) ,
                    //Text(appName,style:TextStyle(),),
                    // progressWidget(),

                  ],
                ),
                waveGreenWidget()

              ]
            ),
          ),
        ),
      ),
    );
  }

  void delayTimeToHomeScreen(BuildContext ctx)
  {

    Future.delayed(const Duration(milliseconds: 7000), () {
        Navigator.pushReplacementNamed(ctx, 'intro');
    });
  }

  Widget logoWidget (){
   return Column(

     children: [
       Divider(indent: double.infinity, height: 20,endIndent: double.infinity,) ,

       SvgPicture.asset(
       'assets/fileroleic.svg',
         color:clrGreen,
         height: 120,
    ),
       Divider(indent: double.infinity, height: 30,endIndent: double.infinity,) ,

   Container(
         // width: 200,
         //   height: 200,
           decoration: BoxDecoration(
        //  borderRadius: BorderRadius.circular(35.0),
           ),
            child: Image(
               image: AssetImage('assets/filerolebanner.png' , ),
             )),
     ],
   );
   }
  Widget progressWidget (){
    return Container( padding: EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0),),
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(progressbarColour),
          minHeight: 2.5,
          backgroundColor: Colors.transparent,
        )
    )
    ;
  }

  Widget waveGreenWidget(){
    return Align(alignment: Alignment.bottomCenter,
      child: WaveWidget( //user Stack() widget to overlap content and waves
        config: CustomConfig(
          colors: [
           clrGreen2.withOpacity(0.2),
           clrGreen2.withOpacity(0.3),
            clrGreen2.withOpacity(0.4),
            clrGreen2.withOpacity(0.5),
            //the more colors here, the more wave will be
          ],
          durations: [3000,4000, 5000, 7000],
          //durations of animations for each colors,
          // make numbers equal to numbers of colors
          heightPercentages: [0.01,0.02, 0.03, 0.04],
          //height percentage for each colors.
          blur: MaskFilter.blur(BlurStyle.solid, 5),
          //blur intensity for waves
        ),
        waveAmplitude: 50.00, //depth of curves
        waveFrequency: 1, //number of curves in waves
        backgroundColor: Colors.transparent, //background colors
        size: Size(
          double.infinity,
          20
        ),
      ),
    );
  }
}

