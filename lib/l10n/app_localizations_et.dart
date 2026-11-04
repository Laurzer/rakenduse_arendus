// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get rakenduseNimi => 'Rakenduse arendus';

  @override
  String get kodu => 'Kodu';

  @override
  String get meie => 'Meie';

  @override
  String get inimesed => 'Inimesed';

  @override
  String get server => 'Server';

  @override
  String get kursused => 'Kursused';

  @override
  String get keeleNupp => 'EN';

  @override
  String get keeleVihje => 'Switch to English';

  @override
  String get tervitus =>
      'Tere tulemast! See on meie grupi Flutteri õpperakendus. Rakenduses saab vaadata grupi liikmeid, lugeda andmeid failist ning hallata serveris olevaid inimesi.';

  @override
  String tanaOn(String kuupaev) {
    return 'Täna on $kuupaev';
  }

  @override
  String get naitaNimekirja => 'Näita nimekirja';

  @override
  String get peidaNimekiri => 'Peida nimekiri';

  @override
  String get jargmineNimi => 'Näita järgmist nime';

  @override
  String get inimesedFailist => 'Inimesed failist';

  @override
  String failiViga(String viga) {
    return 'Faili lugemine ebaõnnestus: $viga';
  }

  @override
  String vanus(String vanus) {
    return 'Vanus: $vanus';
  }

  @override
  String get liige => 'Liige';

  @override
  String get poleLiige => 'Pole liige';

  @override
  String get inimesedServeris => 'Inimesed serveris';

  @override
  String get nimi => 'Nimi';

  @override
  String get vanuseVali => 'Vanus';

  @override
  String get saadaServerisse => 'Saada serverisse';

  @override
  String get saadan => 'Saatmine käib';

  @override
  String get saadetud => 'Saadetud';

  @override
  String laadimiseViga(String viga) {
    return 'Andmete laadimine ebaõnnestus: $viga';
  }

  @override
  String get saatmiseViga =>
      'Saatmine ebaõnnestus. Kontrolli välju ja ühendust.';

  @override
  String kustutamiseViga(String viga) {
    return 'Kustutamine ebaõnnestus: $viga';
  }

  @override
  String get kustuta => 'Kustuta';

  @override
  String get muuda => 'Muuda';

  @override
  String get eemalda => 'Eemalda';

  @override
  String get lisaKursus => 'Lisa kursus';

  @override
  String get muudaKursust => 'Muuda kursust';

  @override
  String get kirjeldus => 'Kirjeldus';

  @override
  String get pildiAadress => 'Pildi aadress (pole kohustuslik)';

  @override
  String get sisestaNimi => 'Sisesta kursuse nimi.';

  @override
  String get tuhista => 'Tühista';

  @override
  String get salvesta => 'Salvesta';
}
