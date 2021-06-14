



import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/MasterPaymentCardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//   final clrBorder = Color(int.parse('#A2A8CA'.replaceAll('#', '0xff')));

class MasterPaymentMethod extends StatelessWidget {
  //Form key
  final formKey = GlobalKey<FormState>();
  MasterPaymentCardModel paymentCardModel = MasterPaymentCardModel();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const  EdgeInsets.only(bottom: 20 , top: 0 ,left: 17 , right: 17),
        child:paymentFormWidget()

      ),
    );
  }
  Widget visaImg (){
     return  Container(
      margin: EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/visa.svg',

        height: 230,
      ),
    );
  }



  Widget subHeadTitle ({required String title , }){
    return Text(title,
       style: TextStyle(fontSize: 15.8 , height: 1 ,fontWeight: FontWeight.w700, color:Colors.black54),
    );
  }

  Widget savingButton(){

    return Container(


      margin:EdgeInsets.only( left: 2 ,right: 2 , top: 5, bottom: 10) ,

      width: double.infinity,
      height: 50,
      child: ElevatedButton(onPressed: (){
        formKey.currentState!.save();

      } , child: Text(S.current.add_card.toUpperCase(),style: TextStyle(fontSize: 16,wordSpacing: 1,fontWeight: FontWeight.bold),),

          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                  RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(19.0),
                  )
              )
          )
      ),
    )    ;
  }



  Widget paymentFormWidget (){
    return Form(
      key: formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //visa img
          visaImg() ,
          //Visa Card No.
          subHeadTitle(title:S.current.card_number) ,
           Container(
            margin: EdgeInsets.only(top: 12.5 , bottom: 30) ,
            decoration: BoxDecoration(

              border: Border.all(
                color: clrBorder,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(15 ),
            ),
            child: TextFormField(
                textInputAction: TextInputAction.next,
                onSaved:(item){
                  paymentCardModel.cardNo=item.toString();

                } ,

                showCursor:false ,
                style: TextStyle(height: 2.5),

                keyboardType: TextInputType.number   ,

                decoration: InputDecoration(


                    contentPadding: EdgeInsets.symmetric(horizontal:12 ),

                    border: InputBorder.none,
                    hintText: '8171 9999 2766 0000' ,
                    hintStyle: TextStyle(color: Colors.black45),
                    suffixIcon:  Icon(Icons.payment_rounded,color: clrGreen3,)


                )
            ),
          ),



          //Visa Card ccv + expiry date

          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [


              Expanded(

                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    subHeadTitle(title:S.current.expiry_date),

                     Container(
                      margin: EdgeInsets.only(top: 12.5 , bottom: 30) ,
                      decoration: BoxDecoration(

                        border: Border.all(
                          color: clrBorder,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(15 ),
                      ),
                      child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onSaved:(item){
                            paymentCardModel.expiryDate=item;

                          } ,

                          style: TextStyle(height: 2.5),

                          keyboardType: TextInputType.text ,

                          decoration: InputDecoration(


                            contentPadding: EdgeInsets.symmetric(horizontal:12 ),

                            border: InputBorder.none,
                            hintText: '04/12' ,
                            hintStyle: TextStyle(color: Colors.black45),



                          )
                      ),
                    ),


                  ],
                ),),

              VerticalDivider(color: Colors.transparent,),

              Expanded(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  subHeadTitle(title:S.current.ccv),

                   Container(
                    margin: EdgeInsets.only(top: 12.5 , bottom: 30) ,
                    decoration: BoxDecoration(

                      border: Border.all(
                        color: clrBorder,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(15 ),
                    ),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved:(item){
                          paymentCardModel.ccv=item;

                        } ,

                        style: TextStyle(height: 2.5),

                        keyboardType: TextInputType.text ,

                        decoration: InputDecoration(


                          contentPadding: EdgeInsets.symmetric(horizontal:12 ),

                          border: InputBorder.none,
                          hintText: "980" ,
                          hintStyle: TextStyle(color: Colors.black45),



                        )
                    ),
                  ),

                ],
              ),
              ),
            ],),

          //Visa Card Name
          subHeadTitle(title : S.current.card_name , ),
           Container(
            margin: EdgeInsets.only(top: 12.5 , bottom: 30) ,
            decoration: BoxDecoration(
               border: Border.all(
                color: clrBorder,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(15 ),
            ),
            child: TextFormField(

                textInputAction: TextInputAction.next,
                onSaved:(item){
                  paymentCardModel.cardName=item;

                } ,

                 style: TextStyle(height: 2.5),

                keyboardType: TextInputType.text ,

                decoration: InputDecoration(



                    contentPadding: EdgeInsets.symmetric(horizontal:12 ),

                    border: InputBorder.none,
                    hintText: "MOHAMED ABDEL FATAH ELSISI" ,
                    hintStyle: TextStyle(color: Colors.black45),



                )
            ),
          ),

          //saving Button
          savingButton(),




        ],

      ),
    )  ;
  }




  // Widget headTitleForScreen(){
  //   return
  //    // Container(
  //   //     alignment: Alignment.center,
  //   //     child:
  //   //     Text('Add New Card', textAlign: TextAlign.center,
  //   //       style: TextStyle(fontSize: 15,height: 0.5   ,fontWeight: FontWeight.bold,color: Colors.black45),)) ,;
  // }
}


