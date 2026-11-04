import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_et.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('et'),
  ];

  /// No description provided for @rakenduseNimi.
  ///
  /// In et, this message translates to:
  /// **'Rakenduse arendus'**
  String get rakenduseNimi;

  /// No description provided for @kodu.
  ///
  /// In et, this message translates to:
  /// **'Kodu'**
  String get kodu;

  /// No description provided for @meie.
  ///
  /// In et, this message translates to:
  /// **'Meie'**
  String get meie;

  /// No description provided for @inimesed.
  ///
  /// In et, this message translates to:
  /// **'Inimesed'**
  String get inimesed;

  /// No description provided for @server.
  ///
  /// In et, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @kursused.
  ///
  /// In et, this message translates to:
  /// **'Kursused'**
  String get kursused;

  /// No description provided for @keeleNupp.
  ///
  /// In et, this message translates to:
  /// **'EN'**
  String get keeleNupp;

  /// No description provided for @keeleVihje.
  ///
  /// In et, this message translates to:
  /// **'Switch to English'**
  String get keeleVihje;

  /// No description provided for @tervitus.
  ///
  /// In et, this message translates to:
  /// **'Tere tulemast! See on meie grupi Flutteri õpperakendus. Rakenduses saab vaadata grupi liikmeid, lugeda andmeid failist ning hallata serveris olevaid inimesi.'**
  String get tervitus;

  /// No description provided for @tanaOn.
  ///
  /// In et, this message translates to:
  /// **'Täna on {kuupaev}'**
  String tanaOn(String kuupaev);

  /// No description provided for @naitaNimekirja.
  ///
  /// In et, this message translates to:
  /// **'Näita nimekirja'**
  String get naitaNimekirja;

  /// No description provided for @peidaNimekiri.
  ///
  /// In et, this message translates to:
  /// **'Peida nimekiri'**
  String get peidaNimekiri;

  /// No description provided for @jargmineNimi.
  ///
  /// In et, this message translates to:
  /// **'Näita järgmist nime'**
  String get jargmineNimi;

  /// No description provided for @inimesedFailist.
  ///
  /// In et, this message translates to:
  /// **'Inimesed failist'**
  String get inimesedFailist;

  /// No description provided for @failiViga.
  ///
  /// In et, this message translates to:
  /// **'Faili lugemine ebaõnnestus: {viga}'**
  String failiViga(String viga);

  /// No description provided for @vanus.
  ///
  /// In et, this message translates to:
  /// **'Vanus: {vanus}'**
  String vanus(String vanus);

  /// No description provided for @liige.
  ///
  /// In et, this message translates to:
  /// **'Liige'**
  String get liige;

  /// No description provided for @poleLiige.
  ///
  /// In et, this message translates to:
  /// **'Pole liige'**
  String get poleLiige;

  /// No description provided for @inimesedServeris.
  ///
  /// In et, this message translates to:
  /// **'Inimesed serveris'**
  String get inimesedServeris;

  /// No description provided for @nimi.
  ///
  /// In et, this message translates to:
  /// **'Nimi'**
  String get nimi;

  /// No description provided for @vanuseVali.
  ///
  /// In et, this message translates to:
  /// **'Vanus'**
  String get vanuseVali;

  /// No description provided for @saadaServerisse.
  ///
  /// In et, this message translates to:
  /// **'Saada serverisse'**
  String get saadaServerisse;

  /// No description provided for @saadan.
  ///
  /// In et, this message translates to:
  /// **'Saatmine käib'**
  String get saadan;

  /// No description provided for @saadetud.
  ///
  /// In et, this message translates to:
  /// **'Saadetud'**
  String get saadetud;

  /// No description provided for @laadimiseViga.
  ///
  /// In et, this message translates to:
  /// **'Andmete laadimine ebaõnnestus: {viga}'**
  String laadimiseViga(String viga);

  /// No description provided for @saatmiseViga.
  ///
  /// In et, this message translates to:
  /// **'Saatmine ebaõnnestus. Kontrolli välju ja ühendust.'**
  String get saatmiseViga;

  /// No description provided for @kustutamiseViga.
  ///
  /// In et, this message translates to:
  /// **'Kustutamine ebaõnnestus: {viga}'**
  String kustutamiseViga(String viga);

  /// No description provided for @kustuta.
  ///
  /// In et, this message translates to:
  /// **'Kustuta'**
  String get kustuta;

  /// No description provided for @muuda.
  ///
  /// In et, this message translates to:
  /// **'Muuda'**
  String get muuda;

  /// No description provided for @eemalda.
  ///
  /// In et, this message translates to:
  /// **'Eemalda'**
  String get eemalda;

  /// No description provided for @lisaKursus.
  ///
  /// In et, this message translates to:
  /// **'Lisa kursus'**
  String get lisaKursus;

  /// No description provided for @muudaKursust.
  ///
  /// In et, this message translates to:
  /// **'Muuda kursust'**
  String get muudaKursust;

  /// No description provided for @kirjeldus.
  ///
  /// In et, this message translates to:
  /// **'Kirjeldus'**
  String get kirjeldus;

  /// No description provided for @pildiAadress.
  ///
  /// In et, this message translates to:
  /// **'Pildi aadress (pole kohustuslik)'**
  String get pildiAadress;

  /// No description provided for @sisestaNimi.
  ///
  /// In et, this message translates to:
  /// **'Sisesta kursuse nimi.'**
  String get sisestaNimi;

  /// No description provided for @tuhista.
  ///
  /// In et, this message translates to:
  /// **'Tühista'**
  String get tuhista;

  /// No description provided for @salvesta.
  ///
  /// In et, this message translates to:
  /// **'Salvesta'**
  String get salvesta;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'et'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'et':
      return AppLocalizationsEt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
