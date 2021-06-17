import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

import 'model/constants/Constants.dart';
import 'model/database/save_accounts_db.dart';
import 'model/providers/LanguageProvider.dart';
import 'ui/auth/ForgetPasswordScreen.dart';
import 'ui/auth/LoginScreen.dart';
import 'ui/auth/SavedAcountsScreen.dart';
import 'ui/intro/IntroSliderScreens.dart';
import 'ui/auth/AuthIntroScreen.dart';

import 'ui/master/master_main/MasterMainScreen.dart';
import 'ui/notifications/notification_screen.dart';
import 'ui/splash/SplashScreen.dart';
import 'util/ChangeLangUtil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init Firebase for Cloud Msg
  Firebase.initializeApp();

  //init Hive Database Boxes
  SavedAccountsDb() .. initHiveDB(); 
   
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //cashe for graphQL
  // await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child:
          Consumer<LanguageProvider>(builder: (context, langProvider, child) {
        return MaterialApp(
          //current language
          locale: Locale(langProvider.languageApp!, ""),

          //place to be localized
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: [
            Locale(AppLanguages.en.toShortString(), ''),  
            Locale(AppLanguages.ar.toShortString(), ''),  
          ],

          debugShowCheckedModeBanner: false,
          title: 'Filerole',
          initialRoute: "splash",

          routes: appRoutes,
          theme: ThemeData(
            
            textTheme:
                (langProvider.languageApp! == AppLanguages.en.toShortString())
                    ? GoogleFonts.robotoTextTheme(TextTheme())
                    : GoogleFonts.cairoTextTheme(),
            primaryColor: clrGrey,
            
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        );
      }),
    );
  }
}

final appRoutes = {
  'splash': (context) => SplashScreen(),
  'intro' : (context) => IntroSliderScreens(),
  'login': (context) => LoginScreen(),
  'forget_pass': (context) => ForgetPasswordScreen(),

  'auth_intro': (context)   => AuthIntroScreen(),
  //'register': (context)   => RegisterScreen(),
  'saved_acc': (context)    => SavedAccountsScreen(),
  'master_main': (context)  => MasterMainScreen(),
  'notification': (context) => NotificationScreen(),
};
