import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/NotifyModel.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrGreen2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.purple[100],
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(StaticUserVar.userAccount.img!),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        //   padding: const EdgeInsets.symmetric(8.0),
        child: Column(
          children: [
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  S.of(context).notifications,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 38,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 25, top: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33.0),
                  ),
                  color: Colors.white,
                ),
                child: notifyList(list),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget notifyListTile(NotifyModel notifyModel) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: clrGreen2.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(notifyModel.img!), fit: BoxFit.fill),
          ),
        ),
      ),
      title: Text(notifyModel.msg ?? 'Check your network'),
      subtitle: Text(notifyModel.name ?? 'Filerole'),
    ),
  );
}

Widget notifyList(List<NotifyModel> notifyList) {
  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      height: 25,
      endIndent: 60,
      indent: 60,
    ),
    itemCount: notifyList.length,
    itemBuilder: (context, index) => notifyListTile(notifyList[index]),
  );
}

final list = [
  NotifyModel(
      img:
          'https://cdn.dribbble.com/users/22878/screenshots/8123429/media/201ad89010aa3dd123bf6ccb0aad3ecd.png',
      msg: "Hey there is an New Offer Plan ",
      name: "Cook Door"),
  NotifyModel(
      img:
          'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/http://coursera-university-assets.s3.amazonaws.com/11/e5a0023d7242b48cb761d67508c038/atlassian-logo-gradient-vertical-blue-2x.png?auto=format%2Ccompress&dpr=1&w=120&h=120&q=40',
      msg: "Try out our Best Plans with Best Prices in Ksa ",
      name: "Filerole"),
  NotifyModel(
      img:
          'https://cdn.dribbble.com/users/22878/screenshots/8123429/media/201ad89010aa3dd123bf6ccb0aad3ecd.png',
      msg: "Hey there is an New Offer Plan ",
      name: "Cook Door"),
  NotifyModel(
      img:
          'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/http://coursera-university-assets.s3.amazonaws.com/11/e5a0023d7242b48cb761d67508c038/atlassian-logo-gradient-vertical-blue-2x.png?auto=format%2Ccompress&dpr=1&w=120&h=120&q=40',
      msg: "Try out our Best Plans with Best Prices in Ksa ",
      name: "Filerole"),
  NotifyModel(
      img:
          'https://cdn.dribbble.com/users/22878/screenshots/8123429/media/201ad89010aa3dd123bf6ccb0aad3ecd.png',
      msg: "Hey there is an New Offer Plan ",
      name: "Cook Door"),
  NotifyModel(
      img:
          'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/http://coursera-university-assets.s3.amazonaws.com/11/e5a0023d7242b48cb761d67508c038/atlassian-logo-gradient-vertical-blue-2x.png?auto=format%2Ccompress&dpr=1&w=120&h=120&q=40',
      msg: "Try out our Best Plans with Best Prices in Ksa ",
      name: "Filerole"),
  NotifyModel(
      img:
          'https://cdn.dribbble.com/users/22878/screenshots/8123429/media/201ad89010aa3dd123bf6ccb0aad3ecd.png',
      msg: "Hey there is an New Offer Plan ",
      name: "Cook Door"),
  NotifyModel(
      img:
          'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/http://coursera-university-assets.s3.amazonaws.com/11/e5a0023d7242b48cb761d67508c038/atlassian-logo-gradient-vertical-blue-2x.png?auto=format%2Ccompress&dpr=1&w=120&h=120&q=40',
      msg: "Try out our Best Plans with Best Prices in Ksa ",
      name: "Filerole"),
];
