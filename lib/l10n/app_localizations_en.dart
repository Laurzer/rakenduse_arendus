// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get rakenduseNimi => 'App development';

  @override
  String get kodu => 'Home';

  @override
  String get meie => 'About us';

  @override
  String get inimesed => 'People';

  @override
  String get server => 'Server';

  @override
  String get kursused => 'Courses';

  @override
  String get keeleNupp => 'ET';

  @override
  String get keeleVihje => 'Vaheta eesti keelele';

  @override
  String get tervitus =>
      'Welcome! This is our group\'s Flutter learning app. You can view the group members, read data from a file and manage people on the server.';

  @override
  String tanaOn(String kuupaev) {
    return 'Today is $kuupaev';
  }

  @override
  String get naitaNimekirja => 'Show list';

  @override
  String get peidaNimekiri => 'Hide list';

  @override
  String get jargmineNimi => 'Show next name';

  @override
  String get inimesedFailist => 'People from file';

  @override
  String failiViga(String viga) {
    return 'Could not read the file: $viga';
  }

  @override
  String vanus(String vanus) {
    return 'Age: $vanus';
  }

  @override
  String get liige => 'Member';

  @override
  String get poleLiige => 'Not a member';

  @override
  String get inimesedServeris => 'People on the server';

  @override
  String get nimi => 'Name';

  @override
  String get vanuseVali => 'Age';

  @override
  String get saadaServerisse => 'Send to server';

  @override
  String get saadan => 'Sending';

  @override
  String get saadetud => 'Sent';

  @override
  String laadimiseViga(String viga) {
    return 'Could not load the data: $viga';
  }

  @override
  String get saatmiseViga =>
      'Sending failed. Check the fields and your connection.';

  @override
  String kustutamiseViga(String viga) {
    return 'Could not delete: $viga';
  }

  @override
  String get kustuta => 'Delete';

  @override
  String get muuda => 'Edit';

  @override
  String get eemalda => 'Remove';

  @override
  String get lisaKursus => 'Add course';

  @override
  String get muudaKursust => 'Edit course';

  @override
  String get kirjeldus => 'Description';

  @override
  String get pildiAadress => 'Image address (optional)';

  @override
  String get sisestaNimi => 'Enter a course name.';

  @override
  String get tuhista => 'Cancel';

  @override
  String get salvesta => 'Save';
}
