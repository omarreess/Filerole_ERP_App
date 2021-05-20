





 import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/Constants.dart';
import 'package:Filerole/model/MasterPlansModel.dart';
import 'package:flutter/material.dart';

class MasterSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(


      color: Colors.white30,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //head Tittle
          Container(
              padding: EdgeInsets.only(top: 0  ,left: 17,right: 17),

              child: Text(S.of(context).plans ,style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w800,height: 1.5,fontSize: 23),)),
          Divider(color: Colors.transparent,height: 10,),
          //plans list
          Expanded(child: subsPlansGrid()),




        ],
      ),
    );
  }

  Widget subsPlansGrid(){
    
    List<MasterPlansModel > subsPlans = List.empty(growable: true);
    subsPlans.add(MasterPlansModel(storeName: 'Safi Market' , planType: 'Free Plan',storeType: 'Supermarket',  imgUrl: 'https://static.dw.com/image/42651500_303.jpg'));
    subsPlans.add(MasterPlansModel(storeName: 'Almasa Hotel' , planType: 'Classic Plan',storeType: 'Hotel',  imgUrl: 'http://www.helnan.com/Uploads/images/land_info1.jpg'));
    subsPlans.add(MasterPlansModel(storeName: 'Bobe Barber' , planType: 'Free Plan',storeType: 'Salon',  imgUrl: 'https://airows.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_860/MTM4NTIyNjM5MjE5MTA3MjM5/baxterfinley---2016-best-barber-shopsjpg.webp'));
    subsPlans.add(MasterPlansModel(storeName: 'Safi market' , planType: 'Free Plan',storeType: 'Supermarket',  imgUrl: 'https://api.time.com/wp-content/uploads/2018/08/thrift-stores.jpg?w=800&quality=85'));
    subsPlans.add(MasterPlansModel(storeName: 'Hadi Barber' , planType: 'Free Plan',storeType: 'Salon',  imgUrl: 'https://api.time.com/wp-content/uploads/2018/08/thrift-stores.jpg?w=800&quality=85'));
    subsPlans.add(MasterPlansModel(storeName: 'Safi market' , planType: 'Free Plan',storeType: 'Supermarket',  imgUrl: 'https://api.time.com/wp-content/uploads/2018/08/thrift-stores.jpg?w=800&quality=85'));

    
    return Padding(
      padding: EdgeInsets.only( top:10,bottom: 20 ,left: 12,right:12 ),

       child: GridView.builder(
        itemCount: subsPlans.length,
        scrollDirection: Axis.vertical,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (200 / 290),

           // maxCrossAxisExtent: 200,//one item takes 200width , width grid depends on screen
             crossAxisCount:2,  // no. col

            crossAxisSpacing:3.0,
            mainAxisSpacing: 12.0
        ),

        itemBuilder: (BuildContext context, int index){
          return Card(

           shape:RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
           ) ,
             elevation:1,
           child: InkWell(
             borderRadius: BorderRadius.circular(15),
             onTap: (){},
             child: Column(
                children: [
                 ClipRRect(
                   borderRadius: BorderRadius.only(topRight:Radius.circular(17),topLeft: Radius.circular(17)),
                   child: Image.network(subsPlans[index].imgUrl! ,
                     fit: BoxFit.fitWidth,

                    ),
                 ),
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Text(subsPlans[index].storeName!,style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.w500,color: clrGreen2),),
                       Row(
                         children:[
                           Expanded(child: Divider(thickness: 0.5, color: Colors.black54,height: 0,)),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10),
                             child: Text(subsPlans[index].planType!, style: TextStyle(color: Colors.black45),),
                           ),
                           Expanded(child: Divider(thickness: 0.4, color: Colors.black54,height: 0,)),
                         ],),

                       Chip(

                         elevation: 0.9,
                         backgroundColor:Colors.blueAccent ,
                         label: Text(subsPlans[index].storeType!,style: TextStyle(fontSize:13.5 ,color: Colors.white),),
                       )
                     ],
                   ),
                 ),

               ],
             ),
           ),);
        },
      ),
    );
  }
}
