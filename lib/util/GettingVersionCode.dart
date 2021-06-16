

import 'package:package_info/package_info.dart';

Future<String> getVersionNumberUtill() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;

  // Other data you can get:
  //
  // 	String appName = packageInfo.appName;
  // 	String packageName = packageInfo.packageName;
  //	String buildNumber = packageInfo.buildNumber;
}

//  package_info: ^0.4.0+6


/*

FutureBuilder(
	future: getVersionNumber(), // The async function we wrote earlier that will be providing the data i.e vers. no
	builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>	Text(snapshot.hasData ? snapshot.data : "Loading ...",) // The widget using the data
),

 */