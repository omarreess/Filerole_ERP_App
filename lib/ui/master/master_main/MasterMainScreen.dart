import 'dart:ui';

import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/providers/LanguageProvider.dart';
import 'package:Filerole/model/pojo/MasterAccountModel.dart';
import 'package:Filerole/networking/graphql/authentication/MasterAuth.dart';
import 'package:Filerole/networking/restful/client/master_client.dart';
import 'package:Filerole/ui/master/master_profile/MasterProfile.dart';
import 'package:Filerole/ui/master/payment_method/MasterPaymentMethod.dart';
import 'package:Filerole/ui/master/payments/MasterPayments.dart';
import 'package:Filerole/ui/master/subscriptions/MasterSubscription.dart';
import 'package:Filerole/util/ChangeLangUtil.dart';
import 'package:Filerole/util/GettingVersionCode.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StaticUserVar {
//app lifetime var contain user's token .....
  static MasterAccountModel userAccount = MasterAccountModel();
}

class StaticMasterClient {
//app lifetime var respobile for  Master Client
  static MasterClient client = MasterClient();
}

class MasterMainScreen extends StatefulWidget {
  @override
  _MasterMainScreenState createState() => _MasterMainScreenState();
}

class _MasterMainScreenState extends State<MasterMainScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidget(context),
        body: NestedScrollView(
          body: tabBarScreens(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leadingWidth: 58,
                  expandedHeight: 170,
                  collapsedHeight: 120,
                  automaticallyImplyLeading:
                      false, // means not to back btn even it's avalible
                  centerTitle: true,

                  backgroundColor: clrGreen2,
                  title: logoWidget(),
                  elevation: 0.0, // Elevation Shadow

                  leading: menuBtn(),

                  actions: <Widget>[
                    logoutBtn(),
                  ],
                  bottom: PreferredSize(
                    child: tabBarWidet(),
                    preferredSize: Size.fromHeight(0.0),
                  ),

                  //body in bar
                  pinned: false,
                  // floating: true,
                ),
              )
            ];
          },
        ),
      ),
    );
  }

  Widget menuBtn() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        _scaffoldKey.currentState!.openDrawer();
      },
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: SvgPicture.asset(
          'assets/menuic.svg',
          color: Colors.white,
        ),
      ),
    );
  }

  Widget logoWidget({double width = 95}) {
    return Image(
      image: AssetImage(
        'assets/filerolebanner.png',
      ),
      width: width,
      color: Colors.white,
    );
  }

  Widget logoutBtn() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        logoutUser();
        toLoginScreen();
      },
      child: Container(
        padding: EdgeInsets.only(left: 18.5, right: 18.5),
        child: SvgPicture.asset(
          'assets/logout.svg',
          color: Colors.white,
          height: 28,
          width: 28,
        ),
      ),
    );
  }

  Widget tabBarWidet() {
    return Container(
      color: clrGreen2,
      child: Container(
        height: 100,
        padding: EdgeInsets.only(left: 19, top: 25),
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorWeight: 2,
          indicatorPadding: EdgeInsets.only(bottom: 18, left: 10, right: 10),
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              child: Text(
                S.of(context).master_label_payments.toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                S.of(context).master_label_subscriptions.toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                S.of(context).master_label_payment_method.toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                S.of(context).master_label_profile.toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBarScreens() {
    return SafeArea(
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          Container(child: MasterPayments()),
          Container(child: MasterSubscription()),
          Container(child: MasterPaymentMethod()),
          Container(child: MasterProfile()),
        ],
      ),
    );
  }

  Widget drawerWidget(BuildContext ctx) {
    return Drawer(
      elevation: 15,
      child: Container(
        color: clrGreen3.withOpacity(0.8),
        child: SafeArea(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Divider(
                height: 25,
                color: Colors.transparent,
              ),
              //profile photo + name
              ClipOval(
                child: Container(
                  height: 100,
                  child: Image.network(
                  StaticUserVar.userAccount.img!,
                  ),
                ),
              ),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Text(
               StaticUserVar.userAccount.name??'User',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    height: 1),
              ),

              //drawer navigators
              Divider(
                height: 35,
                color: Colors.transparent,
              ),
              drawerItemNavigator(
                  icon: Icons.table_chart_outlined,
                  label: S.of(context).master_label_payments,
                  ctx: ctx,
                  index: 0),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),

              drawerItemNavigator(
                  icon: Icons.subscriptions_outlined,
                  label: S.of(context).master_label_subscriptions,
                  ctx: ctx,
                  index: 1),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),

              drawerItemNavigator(
                  icon: Icons.credit_card,
                  label: S.of(context).master_label_payment_method,
                  ctx: ctx,
                  index: 2),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),

              drawerItemNavigator(
                  icon: Icons.account_circle_outlined,
                  label: S.of(context).master_label_profile,
                  ctx: ctx,
                  index: 3),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              drawerItemNavigator(
                  icon: Icons.notifications_none,
                  label: S.of(context).notifications,
                  ctx: ctx,
                  index: 4),

              Divider(
                height: 26,
                color: Colors.transparent,
              ),

              //Change language
              drawerItemNavigator(
                  icon: Icons.translate,
                  label: S.of(context).change_lang,
                  ctx: ctx,
                  index: 4),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19.0),
                      ),
                      child: Text(
                        'English',
                        style: TextStyle(color: Colors.black54),
                      ),
                      onPressed: () {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .changeLang(AppLanguages.en.toShortString());
                      },
                      color: Colors.white70.withOpacity(0.3),
                    ),
                  ]),
                  VerticalDivider(
                    color: Colors.transparent,
                    width: 20,
                  ),
                  FlatButton(
                    color: Colors.white70.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19.0),
                    ),
                    child: Text(
                      'عربي',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1, color: Colors.black54),
                    ),
                    onPressed: () {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLang(AppLanguages.ar.toShortString());
                    },
                  ),
                ],
              ),

              //logo + version
              Expanded(
                child: Align(
                    //alignment: Alignment.bottomCenter,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoWidget(width: 120),
                    Divider(
                      color: Colors.transparent,
                      height: 7,
                    ),
                    //getting app version
                    FutureBuilder(
                        future: getVersionNumberUtill(),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return Text(
                            "v${snapshot.data}",
                            style: TextStyle(
                                color: Colors.white, fontSize: 15, height: 1),
                          );
                        }),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItemNavigator(
      {required String label,
      IconData? icon,
      BuildContext? ctx,
      required int index}) {
    // ignore: deprecated_member_use
    return FlatButton(
      //if index <4 means it's change language buttons

      onPressed: () {
        Navigator.pop(context);
        if (index < 4) {
          tabController!.animateTo((index));
        } else if (index == 4) {
          Navigator.pushNamed(context, 'notification');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: (index < 4) ? 26 : 22,
            ),
            VerticalDivider(
              width: 15,
              color: Colors.transparent,
            ),
            Text(label,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: (index < 4) ? 22 : 19.2)),
          ],
        ),
      ),
    );
  }

  void logoutUser() {
    StaticMasterClient.client
        .logoutService(token: StaticUserVar.userAccount.accessToken)
        .then(
          (response) {
          // checking status code
         if (checkNetworkResponseStatusCode(response)) 
         {
         StaticUserVar.userAccount.accessToken = '';
        createToast(response?['message'], colour: Colors.greenAccent.withOpacity(0.6));
        toLoginScreen();
        }
         else{
           createToast(response?['errors']??'Something went wrong', colour: Colors.red.withOpacity(0.6));

         } 
      
    }
    );
    // final authState = MasterAuth();
    // authState
    //     .graphQLClientRequest(
    //         queryDoc: authState.getProfileQuery,
    //         token: StaticUserVar.userAccount.accessToken
    //         //  StaticUserVar. userAccount.token
    //         )
    //     .then((response) {
    //   createToast('Bye ${StaticUserVar.userAccount.name} ${response.data}');
    //   //  Toast.show( 'Bye ${StaticUserVar.  userAccount.name} ${response.data }', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    //   toLoginScreen();
    // }).catchError((error) {
    //   createToast('Error Occured ');
    //   //  Toast.show( 'Error Occured ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    // });
  }

  void toLoginScreen() {
    Navigator.pushReplacementNamed(context, 'login');
  }
}
