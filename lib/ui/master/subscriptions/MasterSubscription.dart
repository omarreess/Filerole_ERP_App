import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/pojo/MasterPlansModel.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:flutter/material.dart';

class MasterSubscription extends StatelessWidget {
  //for Loading
  bool dataReady = false;

  //for network pagination
  late int currentPage;
  late int lastPage;

  //Data
  List<MasterPlansModel> subsPlans = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    print('ysta${StaticUserVar.userAccount.accessToken!}');
    getSubscroptionList(token: StaticUserVar.userAccount.accessToken!);

    return Container(
      color: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //head Tittle
          Container(
              padding: EdgeInsets.only(top: 0, left: 17, right: 17),
              child: Text(
                S.of(context).plans,
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                    fontSize: 23),
              )),
          Divider(
            color: Colors.transparent,
            height: 10,
          ),
          //plans list
          FutureBuilder(
              future: getSubscroptionList(
                  token: StaticUserVar.userAccount.accessToken!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (dataReady) {
                    return Expanded(child: subsPlansGrid());
                  }
                  {
                    return Expanded(
                        child: Container(
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: clrGreen3))));
                  }
                } else {
                  return Expanded(
                      child: Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: clrGreen3))));
                }
              }),
        ],
      ),
    );
  }

  Widget subsPlansGrid() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 20, left: 12, right: 12),
      child: GridView.builder(
        itemCount: subsPlans.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (200 / 290),

            // maxCrossAxisExtent: 200,//one item takes 200width , width grid depends on screen
            crossAxisCount: 2, // no. col

            crossAxisSpacing: 3.0,
            mainAxisSpacing: 12.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {},
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(17),
                        topLeft: Radius.circular(17)),
                    child: Image.network(
                      subsPlans[index].imgUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          subsPlans[index].storeName!,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: clrGreen2),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.black54,
                              height: 0,
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                subsPlans[index].planType!,
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.4,
                              color: Colors.black54,
                              height: 0,
                            )),
                          ],
                        ),
                        Chip(
                          elevation: 0.9,
                          backgroundColor: Colors.blueAccent,
                          label: Wrap(
                            children: [
                              Text(
                                subsPlans[index].storeType!,
                                style: TextStyle(
                                    fontSize: 13.5, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getSubscroptionList({
    String? page,
    required String token,
  }) async {
    await StaticMasterClient.client
        .subscriptionsService(
      token: token,
    )
        .then((response) {
      // checking status code
      if (checkNetworkResponseStatusCode(response)) {
        if (response!['data']['data'] == null) {
          dataReady = false;
        } else {
          //assigning new Data
          (response['data']['data'] as List).forEach((element) {
            subsPlans.add(MasterPlansModel(
                storeName: element['name'] ?? 'User Name',
                planType: element['plan'] ?? 'Plan',
                storeType: element['activity'] ?? 'Store',
                imgUrl: element['image'].toString()));
          });

          dataReady = true;
        }

        // createToast(response?['message'],
        //     colour: Colors.greenAccent.withOpacity(0.6));

      } else {
        createToast(response?['status'].toString() ?? 'Something went wrong!',
            colour: Colors.red.withOpacity(0.6));
        dataReady = false;
      }
    }).catchError((error) {
      //  createToast(error.toString());

      createToast(error.toString());
      print('ysta ${error.toString()}');
      dataReady = false;
    });
  }
}
