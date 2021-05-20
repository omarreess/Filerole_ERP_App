import 'dart:ui';

import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/Constants.dart';
import 'package:Filerole/model/MasterPaymentModel.dart';
import 'package:Filerole/ui/auth/LoginScreen.dart';
import 'package:Filerole/ui/master/payment_method/MasterPaymentMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterPayments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.payments,
                style:
                    TextStyle(fontSize: 25, height: 1, color: Colors.black54),
              ),
              sortByWidget(),
            ],
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 3,
        ),
        paymentListWidget(context),
      ],
    );
  }

  Widget paymentListWidget( BuildContext ctx) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 7, right: 7, bottom: 15),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: ListView.separated(
          itemBuilder: (context, index) => paymentItemWidget(ctx),
          itemCount: 10,
          separatorBuilder: (context, index) =>
              Divider(height: 20, thickness: 0.2, color: Colors.grey),
        ),
      ),
    ));
  }
  OverlayEntry popupDialog ({MasterPaymentsModel? masterPaymentsModel}){
   return   OverlayEntry(  builder: (context) => Center(child:
   Dialog(

      child: BackdropFilter(

         filter: ImageFilter.blur(sigmaX:5.0,sigmaY:5.0),
         child: ClipRRect(
           borderRadius: BorderRadius.circular(10),
             child: Container( height: 300 , width:320 , color: Colors.white,
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Text(masterPaymentsModel!.companyName! , style:  TextStyle(color: clrGreen3 , fontWeight: FontWeight.bold , fontSize: 23),),

                 Text(masterPaymentsModel.plan! , style:  TextStyle(color: Colors.black38 , fontWeight: FontWeight.w800 , fontSize: 18 , height: 1.3),),
                   Divider(height: 7,color: Colors.transparent,),



                   Row(


                     children: [
                     Text('Date : ' , style:  TextStyle(   fontSize: 18),),

                     Expanded(child: Text(masterPaymentsModel.date! , textAlign:TextAlign.end, style:  TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold , fontSize: 22),)),
                   ],
                 ),
                   Divider(height: 5, color: Colors.transparent,),

                   Row(
                     children: [
                       Text('Duration : ' , style:  TextStyle(  fontSize: 18),),
                       Expanded(child: Text(masterPaymentsModel.duration! , textAlign:TextAlign.end, style:  TextStyle(color:Colors.blueAccent , fontWeight: FontWeight.bold , fontSize: 22),)),

                     ],
                   ),
                 Divider(height: 35,thickness: 1.5,),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text('Total : ' , style:  TextStyle(  fontSize: 23),),

                     Text(masterPaymentsModel.amount! , style:  TextStyle(color: clrGreen3 , fontWeight: FontWeight.bold , fontSize: 26 , height: 1),),
                   ],
                 ),
               ],),
             )
               ,))),
   )
   )     );
 }

  Widget paymentItemWidget(BuildContext ctx) {
   final  popupDialogVar = popupDialog( masterPaymentsModel : MasterPaymentsModel( companyName: 'Filerole Company' , date: '9 Aug 2020' , duration: '6 Monthes' , plan: 'Free Plan ', amount: '49 SAR'));
    return GestureDetector(
      onLongPress: () {
         Overlay.of(ctx)!.insert(popupDialogVar);
      },
      onLongPressEnd: (details) => popupDialogVar .remove(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('09\nAug',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
              Text.rich(TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Free Plan\n', style: TextStyle(fontSize: 17)),
                  TextSpan(
                      text: 'Filerole Company',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 13)),
                ],
              )),
              Text('6\nMonthes',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5, fontSize: 13, color: Colors.red)),
              Text('29 SAR', style: TextStyle(fontSize: 15, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sortByWidget2() {
    return Container(
      width: 100,
      height: 50,
      child: Card(

        elevation: 2,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
             // color: Colors.transparent,
              child: DropdownButton(
                disabledHint: Container(color: Colors.transparent,),
                 iconEnabledColor: Colors.transparent,
                isExpanded: true   ,
                underline: Container(color: Colors.transparent,),
                items: [
                  DropdownMenuItem(
                    child: Text(S.current.sort_by_date ,
                    style: TextStyle(
                      //color: Colors.transparent,
                  ),) , ),
                  DropdownMenuItem(child: Text(S.current.sort_by_highpaid)),
                  DropdownMenuItem(child: Text(S.current.sort_by_lowpaid)),
                  ],

                onChanged: (dynamic value) {  },
              ),
            ),
           // Container(color: Colors.brown,),

            Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 S.current.sort_by,
                 style: TextStyle(color: Colors.black54),
               ),
               VerticalDivider(
                 color: Colors.transparent,
                 width: 2,
               ),
               Icon(
                 Icons.filter_alt,
                 color: Colors.black54,
               )
             ],
              ),
          ],
        ),
      ),
    );

  }

 Widget sortByWidget() {
    return Container(
      width: 100,
      height: 50,

       child: PopupMenuButton(

         itemBuilder: (context) => [
    PopupMenuItem(
    child: Text(S.current.sort_by_date),
   ),
   PopupMenuItem(
   child: Text(S.current.sort_by_highpaid),
   ),
   PopupMenuItem(
   child: Text(S.current.sort_by_lowpaid),
   ),

   ],
        child: Card(


          elevation: 2,
          shadowColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),

          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.current.sort_by,
                style: TextStyle(color: Colors.black54),
              ),
              VerticalDivider(
                color: Colors.transparent,
                width: 2,
              ),
              Icon(
                Icons.filter_alt,
                color: Colors.black54,
              )
            ],
          ),


        ),
      ),
    );

  }
}


/*
SingleChildScrollView(child:
      Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            color: Colors.red,)
        ],
      )),
*/

/*
 // DropdownButton<String>(
                    //
                    //
                    //  hint: Text('Sort By'),
                    //  icon: Icon(Icons.filter_alt),
                    //  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    //    return new DropdownMenuItem<String>(
                    //      value: value,
                    //      child: new Text(value),
                    //    );
                    //  }).toList(),
                    //
                    //  onChanged: (_) {},
                    //   ),
 */
