// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Payments`
  String get master_label_payments {
    return Intl.message(
      'Payments',
      name: 'master_label_payments',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get master_label_subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'master_label_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get master_label_payment_method {
    return Intl.message(
      'Payment Method',
      name: 'master_label_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get master_label_profile {
    return Intl.message(
      'Profile',
      name: 'master_label_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get change_lang {
    return Intl.message(
      'Change language',
      name: 'change_lang',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message(
      'Sort By',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get payments {
    return Intl.message(
      'Payments',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `My Subscriptions Plans`
  String get plans {
    return Intl.message(
      'My Subscriptions Plans',
      name: 'plans',
      desc: '',
      args: [],
    );
  }

  /// `CCV`
  String get ccv {
    return Intl.message(
      'CCV',
      name: 'ccv',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiry_date {
    return Intl.message(
      'Expiry Date',
      name: 'expiry_date',
      desc: '',
      args: [],
    );
  }

  /// `Name on Card`
  String get card_name {
    return Intl.message(
      'Name on Card',
      name: 'card_name',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_number {
    return Intl.message(
      'Card Number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last  Name`
  String get last_time {
    return Intl.message(
      'Last  Name',
      name: 'last_time',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Add Card`
  String get add_card {
    return Intl.message(
      'Add Card',
      name: 'add_card',
      desc: '',
      args: [],
    );
  }

  /// `Save Edits`
  String get save_edits {
    return Intl.message(
      'Save Edits',
      name: 'save_edits',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get password_old {
    return Intl.message(
      'Old Password',
      name: 'password_old',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get password_new {
    return Intl.message(
      'New Password',
      name: 'password_new',
      desc: '',
      args: [],
    );
  }

  /// `Re-Type Password`
  String get password_retype {
    return Intl.message(
      'Re-Type Password',
      name: 'password_retype',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}