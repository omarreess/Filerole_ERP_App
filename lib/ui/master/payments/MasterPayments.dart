import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/Constants.dart';
import 'package:Filerole/ui/auth/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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
        paymentListWidget(),
      ],
    );
  }

  Widget paymentListWidget() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 7, right: 7, bottom: 15),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: ListView.separated(
          itemBuilder: (context, index) => paymentItemWidget(),
          itemCount: 10,
          separatorBuilder: (context, index) =>
              Divider(height: 20, thickness: 0.2, color: Colors.grey),
        ),
      ),
    ));
  }

  Widget paymentItemWidget() {
    return InkWell(
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
    );
  }

  Widget sortByWidget() {
    return Container(
      width: 110,
      height: 50,
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
