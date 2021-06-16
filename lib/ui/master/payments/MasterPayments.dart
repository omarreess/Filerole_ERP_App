import 'dart:ui';

import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/MasterPaymentModel.dart';
import 'package:Filerole/model/MasterPlansModel.dart';
import 'package:Filerole/ui/auth/LoginScreen.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/ui/master/payment_method/MasterPaymentMethod.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterPayments extends StatefulWidget {
  //popup blured screen
  @override
  _MasterPaymentsState createState() => _MasterPaymentsState();
}

class _MasterPaymentsState extends State<MasterPayments> {
  late OverlayEntry popupDialogVar;

  bool dataReady = false;
  bool dataFiltered = false;

  late int currentPage;

  late int lastPage;

  List<MasterPaymentsModel> paymentsPlan = List.empty(growable: true);

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

        //payments list
       (dataFiltered) ?paymentListWidget(context)
      
        : FutureBuilder(
            future:
                getPaymentsList(token: StaticUserVar.userAccount.accessToken!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (dataReady) {
                  return paymentListWidget(context);
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
                            child:
                                CircularProgressIndicator(color: clrGreen3))));
              }
            }),

      ],
    );
  }

  Widget paymentListWidget(BuildContext ctx) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 7, right: 7, bottom: 15),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: ListView.separated(
          itemBuilder: (context, index) => paymentItemWidget(
              ctx,
              MasterPaymentsModel(
                  companyName: paymentsPlan[index].companyName,
                  date: paymentsPlan[index].date,
                  period: paymentsPlan[index].period,
                  duration: paymentsPlan[index].duration,
                  plan: paymentsPlan[index].plan,
                  amount: paymentsPlan[index].amount)),
          itemCount: paymentsPlan.length,
          separatorBuilder: (context, index) =>
              Divider(height: 20, thickness: 0.2, color: Colors.grey),
        ),
      ),
    ));
  }

  OverlayEntry popupDialog({MasterPaymentsModel? masterPaymentsModel}) {
    return OverlayEntry(
        builder: (context) => Center(
                child: Dialog(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 300,
                        width: 320,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                masterPaymentsModel!.companyName!,
                                style: TextStyle(
                                    color: clrGreen3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              Text(
                                masterPaymentsModel.plan!,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    height: 1.3),
                              ),
                              Divider(
                                height: 7,
                                color: Colors.transparent,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${S.current.date} : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(
                                      child: Text(
                                    masterPaymentsModel.date!,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )),
                                ],
                              ),
                              Divider(
                                height: 5,
                                color: Colors.transparent,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${S.current.duration} : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(
                                      child: Text(
                                    masterPaymentsModel.duration!,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )),
                                ],
                              ),
                              Divider(
                                height: 35,
                                thickness: 1.5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${S.current.cost} : ',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  Text(
                                    masterPaymentsModel.amount!,
                                    style: TextStyle(
                                        color: clrGreen3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))),
            )));
  }

  Widget paymentItemWidget(
      BuildContext ctx, MasterPaymentsModel masterPaymentsModel) {
    return GestureDetector(
      onLongPress: () {
        popupDialogVar = popupDialog(masterPaymentsModel: masterPaymentsModel);
        Overlay.of(ctx)!.insert(popupDialogVar);
      },
      onLongPressEnd: (details) => popupDialogVar.remove(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(masterPaymentsModel.date!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
              Text.rich(TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: masterPaymentsModel.plan! + '\n',
                      style: TextStyle(fontSize: 17)),
                  TextSpan(
                      text: masterPaymentsModel.companyName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 13)),
                ],
              )),
              Text(masterPaymentsModel.duration!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(height: 1.5, fontSize: 13, color: Colors.red)),
              Text(masterPaymentsModel.amount!,
                  style: TextStyle(fontSize: 15, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sortByWidget() {
    return Container(
      width: 100,
      height: 50,
      child: PopupMenuButton(
        onSelected: (value) {
          // add this property
          setState(() {
dataFiltered= true ; 
            switch (value) {
              case 0:
                paymentsPlan.sort((a, b) => a.date!.compareTo(b.date!));

                break;

              case 1:
                paymentsPlan.sort((b, a) => a.amount!.compareTo(b.amount!));
                break;

              case 2:
                paymentsPlan.sort((a, b) => a.amount!.compareTo(b.amount!));
                break;

              default:
            }
          });
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(S.current.sort_by_date),
            value: 0,
          ),
          PopupMenuItem(
            child: Text(S.current.sort_by_highpaid),
            value: 1,
          ),
          PopupMenuItem(
            child: Text(S.current.sort_by_lowpaid),
            value: 2,
          ),
        ],
        child: Card(
          elevation: 2,
          shadowColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
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

  Future<void> getPaymentsList({
    String? page,
    required String token,
  }) async {
    await StaticMasterClient.client
        .paymentsService(
      token: token,
    )
        .then((response) {
      // checking status code
      if (checkNetworkResponseStatusCode(response)) {
        if (response!['data']['data'] == null) {
          dataReady = false;
        } else {
          paymentsPlan.clear();
          //assigning new Data
          (response['data']['data'] as List).forEach((element) {
            paymentsPlan.add(MasterPaymentsModel(
                companyName: element['name'] ?? 'Store Name',
                plan: element['plan_type'] ?? 'Plan',
                amount: element['payment_tot'] ?? '0',
                date: element['date'] ?? 'Date',
                duration: element['period'] ?? '0'));
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
      dataReady = false;
    });
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
