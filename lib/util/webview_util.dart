import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/ui/auth/InAppBrowser.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//mock 
//final String url = 'https://filerole.com/register';

openWebView( String url ) {

  //options 
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(
          hideUrlBar: true,
          toolbarTopBackgroundColor: clrBackground2,
          hideToolbarTop: true,
          hidden: false),
      android: AndroidInAppBrowserOptions(
        allowGoBackWithBackButton: true,
        hideTitleBar: true,
      ),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
      )));
 
 //injecting the webview
 final MyInAppBrowser browser = new MyInAppBrowser();

                        
                        browser.openUrlRequest(
                            urlRequest: URLRequest(url: Uri.parse(url)),
                            options: options);

                        // MyChromeSafariBrowser().open(
                        //     url: Uri.parse(url),
                        //     options: ChromeSafariBrowserClassOptions(
                        //
                        //         android: AndroidChromeCustomTabsOptions(   addDefaultShareMenuItem: false , showTitle: false),
                        //
                        //         ios: IOSSafariOptions(barCollapsingEnabled: true)));

                        // MyInAppBrowser().openUrlRequest(
                        //   options: options,
                        //     urlRequest: URLRequest(url: Uri.parse(url))
                        // );

                        // Navigator.pushNamed(context, 'register');
}
