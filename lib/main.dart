import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'model/Constants.dart';
import 'model/LanguageProvider.dart';

import 'ui/auth/LoginScreen.dart';
import 'ui/auth/RegisterScreen.dart';
import 'ui/auth/SavedAcountsScreen.dart';
import 'ui/intro/IntroSliderScreens.dart';
import 'ui/auth/AuthIntroScreen.dart';
import 'ui/master/master_main/MasterMainScreen.dart';
import 'ui/splash/SplashScreen.dart';
import 'util/ChangeLangUtil.dart';

void main() async  {

   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //cashe
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LanguageProvider(),



     child: Consumer<LanguageProvider>(
     builder: (context, langProvider, child) {
     return  MaterialApp(
        //current language
        locale:   Locale(langProvider.languageApp , ""),

        //place to be localized
        localizationsDelegates:
        [

          S.delegate,

          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],


        supportedLocales: [
            Locale(AppLanguages.en.toShortString(), ''), // empty lang code

            Locale(AppLanguages.ar.toShortString(), ''), // empty lang code
        ],

        debugShowCheckedModeBanner: false,
         title: 'Filerole',
        initialRoute: 'master_main',

        routes:appRoutes,
        theme: ThemeData(
          textTheme: GoogleFonts.cairoTextTheme(),

          primaryColor: clrGrey,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

    );} ),
     );
  }

}




final appRoutes =   {

  'splash': (context) => SplashScreen(),
  'intro': (context) => IntroSliderScreens(),
  'login': (context) => LoginScreen(),

  'auth_intro': (context) => AuthIntroScreen(),
  'register': (context) => RegisterScreen(),
  'saved_acc': (context) => SavedAccountsScreen(),
  'master_main': (context) => MasterMainScreen(),


};