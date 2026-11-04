import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

import 'kaardid.dart';
import 'l10n/app_localizations.dart';

// Muuda siin: 300X, kus X on teie tiimi number (ülesanne 6).
const String serveriAadress = 'http://192.168.46.75:3001/people';

// Ülesanne 12: aeglane võrgukutse ei jää ootama igavesti.
const Duration ajapiirang = Duration(seconds: 10);

// Grupi liikmed (ülesanded 2 ja 3).
const List<String> grupiLiikmed = ['Laura-Liis', 'Gerda', 'Anastasia'];

// Kujundus: rakenduse põhivärv ja sisu suurim laius.
const Color pohiVarv = Color(0xFF0F766E);
const double sisuLaius = 880;

// Ülesanne 11: valitud keel. Väärtuse muutmine uuendab kogu rakendust.
final ValueNotifier<Locale> keel = ValueNotifier(const Locale('et'));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ülesanne 10: veebis on abivahendite tugi kohe sees.
  SemanticsBinding.instance.ensureSemantics();
  runApp(const MinuRakendus());
}

class MinuRakendus extends StatelessWidget {
  const MinuRakendus({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: keel,
      builder: (context, valitudKeel, _) {
        return MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context).rakenduseNimi,
          debugShowCheckedModeBanner: false,
          locale: valitudKeel,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: looTeema(),
          // Ülesanne 2: igal lehel on oma aadress.
          initialRoute: '/',
          routes: {
            '/': (context) => const KoduLeht(),
            '/meie': (context) => const MeieLeht(),
            '/inimesed': (context) => const InimesedLeht(),
            '/server': (context) => const ServerLeht(),
            '/kursused': (context) => const KursusedLeht(),
          },
        );
      },
    );
  }
}

// Ühine välimus: värvid, kaardid, nupud ja väljad on määratud ühes kohas.
ThemeData looTeema() {
  final varvid = ColorScheme.fromSeed(seedColor: pohiVarv).copyWith(
    primary: pohiVarv,
    surface: const Color(0xFFF7FAF9),
  );
  final nurgad = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  return ThemeData(
    colorScheme: varvid,
    scaffoldBackgroundColor: varvid.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: varvid.primary,
      foregroundColor: varvid.onPrimary,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: varvid.outlineVariant),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(160, 48),
        shape: nurgad,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

// Sama päis ja navigeerimine kõigil lehtedel.
class LeheRaam extends StatelessWidget {
  const LeheRaam({
    super.key,
    required this.pealkiri,
    required this.sisu,
    this.lisaNupp,
  });

  final String pealkiri;
  final Widget sisu;
  final Widget? lisaNupp;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final varvid = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Semantics(header: true, child: Text(pealkiri)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: varvid.onPrimary,
                side: BorderSide(color: varvid.onPrimary),
              ),
              onPressed: () {
                keel.value = keel.value.languageCode == 'et'
                    ? const Locale('en')
                    : const Locale('et');
              },
              child: Semantics(label: t.keeleVihje, child: Text(t.keeleNupp)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _lingiNupp(context, t.kodu, '/'),
                  _lingiNupp(context, t.meie, '/meie'),
                  _lingiNupp(context, t.inimesed, '/inimesed'),
                  _lingiNupp(context, t.server, '/server'),
                  _lingiNupp(context, t.kursused, '/kursused'),
                ],
              ),
            ),
          ),
        ),
      ),
      // Sisu on keskel ega veni laial ekraanil üle kogu lehe.
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: sisuLaius),
          child: sisu,
        ),
      ),
      floatingActionButton: lisaNupp,
    );
  }

  // Aktiivne leht on heleda taustaga, et kasutaja näeks, kus ta asub.
  Widget _lingiNupp(BuildContext context, String tekst, String aadress) {
    final varvid = Theme.of(context).colorScheme;
    final aktiivne = ModalRoute.of(context)?.settings.name == aadress;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: aktiivne ? varvid.onPrimary : Colors.transparent,
          foregroundColor: aktiivne ? varvid.primary : varvid.onPrimary,
        ),
        onPressed: () => Navigator.of(context).pushReplacementNamed(aadress),
        child: Text(tekst),
      ),
    );
  }
}

// ------------------------------------------------------------
// Ülesanded 1 ja 2: koduleht
// ------------------------------------------------------------
class KoduLeht extends StatelessWidget {
  const KoduLeht({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    // Ülesanne 11: kuupäev vormindatakse valitud keele järgi.
    final kuupaev = MaterialLocalizations.of(
      context,
    ).formatFullDate(DateTime.now());
    final teema = Theme.of(context);
    return LeheRaam(
      pealkiri: t.kodu,
      sisu: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: teema.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.rakenduseNimi,
                  style: teema.textTheme.headlineMedium?.copyWith(
                    color: teema.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t.tervitus,
                  style: TextStyle(color: teema.colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 8),
                Text(
                  t.tanaOn(kuupaev),
                  style: TextStyle(color: teema.colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushReplacementNamed('/kursused'),
                  child: Text(t.kursused),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Sama kaart on kasutusel ka lehel Kursused (ülesanne 8).
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final kursus in naidisKursused.take(3))
                KursuseKaart(kursus: kursus),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Ülesanded 2 ja 3: grupi liikmed
// ------------------------------------------------------------
class MeieLeht extends StatefulWidget {
  const MeieLeht({super.key});

  @override
  State<MeieLeht> createState() => _MeieLehtState();
}

class _MeieLehtState extends State<MeieLeht> {
  bool nimekiriNahtav = false;
  int nimeJarjekord = -1;

  void vahetaNimekirja() {
    setState(() {
      nimekiriNahtav = !nimekiriNahtav;
    });
  }

  void naitaJargmist() {
    setState(() {
      nimeJarjekord = (nimeJarjekord + 1) % grupiLiikmed.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return LeheRaam(
      pealkiri: t.meie,
      sisu: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: vahetaNimekirja,
                        child: Text(
                          nimekiriNahtav ? t.peidaNimekiri : t.naitaNimekirja,
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: naitaJargmist,
                        child: Text(t.jargmineNimi),
                      ),
                    ],
                  ),
                  if (nimeJarjekord >= 0) ...[
                    const SizedBox(height: 16),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        grupiLiikmed[nimeJarjekord],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                  if (nimekiriNahtav) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final nimi in grupiLiikmed)
                          Chip(
                            avatar: const Icon(Icons.person, size: 18),
                            label: Text(nimi),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Ülesanne 4: andmete lugemine failist
// ------------------------------------------------------------
class InimesedLeht extends StatefulWidget {
  const InimesedLeht({super.key});

  @override
  State<InimesedLeht> createState() => _InimesedLehtState();
}

class _InimesedLehtState extends State<InimesedLeht> {
  List<Map<String, dynamic>> inimesed = [];
  bool laeb = true;
  String? viga;

  @override
  void initState() {
    super.initState();
    loeFail();
  }

  Future<void> loeFail() async {
    try {
      final tekst = await rootBundle.loadString('assets/inimesed.json');
      final andmed = jsonDecode(tekst) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        inimesed = andmed.cast<Map<String, dynamic>>();
        laeb = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        viga = '$e';
        laeb = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget sisu;
    if (laeb) {
      sisu = const Center(child: CircularProgressIndicator());
    } else if (viga != null) {
      sisu = Center(child: Text(t.failiViga(viga!)));
    } else {
      sisu = ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: inimesed.length,
        itemBuilder: (context, indeks) {
          final inimene = inimesed[indeks];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('${inimene['nimi']}'),
                subtitle: Text(t.vanus('${inimene['vanus']}')),
                trailing: Chip(
                  label: Text(
                    inimene['member'] == true ? t.liige : t.poleLiige,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
    return LeheRaam(pealkiri: t.inimesedFailist, sisu: sisu);
  }
}

// ------------------------------------------------------------
// Ülesanded 6 ja 7: serveri andmed ja võrgukutse nupp
// ------------------------------------------------------------
class ServerLeht extends StatefulWidget {
  const ServerLeht({super.key});

  @override
  State<ServerLeht> createState() => _ServerLehtState();
}

class _ServerLehtState extends State<ServerLeht> {
  final nimeVali = TextEditingController();
  final vanuseVali = TextEditingController();

  List<dynamic> inimesed = [];
  bool laeb = true;
  String? viga;

  @override
  void initState() {
    super.initState();
    laeAndmed();
  }

  @override
  void dispose() {
    nimeVali.dispose();
    vanuseVali.dispose();
    super.dispose();
  }

  void naitaTeadet(String tekst) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(tekst)));
  }

  // GET: küsib andmed serverist.
  Future<void> laeAndmed() async {
    setState(() {
      laeb = true;
      viga = null;
    });
    try {
      final vastus = await http
          .get(Uri.parse(serveriAadress))
          .timeout(ajapiirang);
      if (vastus.statusCode != 200) {
        throw Exception('HTTP ${vastus.statusCode}');
      }
      final andmed = jsonDecode(vastus.body) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        inimesed = andmed;
        laeb = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        viga = '$e';
        laeb = false;
      });
    }
  }

  // POST: lisab inimese. Tagastab true, kui kutse õnnestus.
  Future<bool> lisaInimene() async {
    final teade = AppLocalizations.of(context).saatmiseViga;
    final nimi = nimeVali.text.trim();
    final vanus = vanuseVali.text.trim();
    var onnestus = false;
    if (nimi.isNotEmpty && vanus.isNotEmpty) {
      try {
        final vastus = await http
            .post(
              Uri.parse(serveriAadress),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'nimi': nimi, 'vanus': vanus, 'member': true}),
            )
            .timeout(ajapiirang);
        onnestus = vastus.statusCode == 200 || vastus.statusCode == 201;
      } catch (e) {
        onnestus = false;
      }
    }
    if (!mounted) return onnestus;
    if (onnestus) {
      await laeAndmed();
    } else {
      naitaTeadet(teade);
    }
    return onnestus;
  }

  // DELETE: kustutab inimese tema id järgi.
  Future<void> kustutaInimene(dynamic id) async {
    final t = AppLocalizations.of(context);
    try {
      final vastus = await http
          .delete(Uri.parse('$serveriAadress/$id'))
          .timeout(ajapiirang);
      if (vastus.statusCode >= 300) {
        throw Exception('HTTP ${vastus.statusCode}');
      }
      await laeAndmed();
    } catch (e) {
      if (!mounted) return;
      naitaTeadet(t.kustutamiseViga('$e'));
    }
  }

  Widget vorm(AppLocalizations t) {
    final nimeLahter = TextField(
      controller: nimeVali,
      decoration: InputDecoration(labelText: t.nimi),
    );
    final vanuseLahter = TextField(
      controller: vanuseVali,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: t.vanuseVali),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Laias vaates on väljad kõrvuti, kitsas üksteise all.
                LayoutBuilder(
                  builder: (context, piirid) {
                    if (piirid.maxWidth < 480) {
                      return Column(
                        children: [
                          nimeLahter,
                          const SizedBox(height: 12),
                          vanuseLahter,
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(flex: 2, child: nimeLahter),
                        const SizedBox(width: 12),
                        Expanded(child: vanuseLahter),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Ülesanne 7. Muudetud andmed viivad nupu tagasi algolekusse.
                Align(
                  alignment: Alignment.centerRight,
                  child: VorguNupp(
                    tekst: t.saadaServerisse,
                    muutused: Listenable.merge([nimeVali, vanuseVali]),
                    onVajutus: lisaInimene,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (laeb) const Center(child: CircularProgressIndicator()),
        if (viga != null)
          Semantics(liveRegion: true, child: Text(t.laadimiseViga(viga!))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return LeheRaam(
      pealkiri: t.inimesedServeris,
      // Ülesanne 12: ka suur nimekiri loob ainult nähtavad read.
      sisu: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: inimesed.length + 1,
        itemBuilder: (context, indeks) {
          if (indeks == 0) return vorm(t);
          final inimene = inimesed[indeks - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                title: Text('${inimene['nimi']}'),
                subtitle: Text(t.vanus('${inimene['vanus']}')),
                trailing: IconButton(
                  tooltip: t.kustuta,
                  icon: const Icon(Icons.delete),
                  onPressed: () => kustutaInimene(inimene['id']),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum NupuOlek { algne, laeb, onnestus }

class VorguNupp extends StatefulWidget {
  const VorguNupp({
    super.key,
    required this.tekst,
    required this.onVajutus,
    required this.muutused,
  });

  final String tekst;
  final Future<bool> Function() onVajutus;
  final Listenable muutused;

  @override
  State<VorguNupp> createState() => _VorguNuppState();
}

class _VorguNuppState extends State<VorguNupp> {
  NupuOlek olek = NupuOlek.algne;

  @override
  void initState() {
    super.initState();
    widget.muutused.addListener(andmedMuutusid);
  }

  @override
  void dispose() {
    widget.muutused.removeListener(andmedMuutusid);
    super.dispose();
  }

  void andmedMuutusid() {
    if (olek == NupuOlek.onnestus) {
      setState(() {
        olek = NupuOlek.algne;
      });
    }
  }

  Future<void> vajutus() async {
    // Laadimise ajal või pärast õnnestumist ei tee nupp midagi.
    if (olek != NupuOlek.algne) return;
    setState(() {
      olek = NupuOlek.laeb;
    });
    final onnestus = await widget.onVajutus();
    if (!mounted) return;
    setState(() {
      olek = onnestus ? NupuOlek.onnestus : NupuOlek.algne;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget sisu;
    switch (olek) {
      case NupuOlek.algne:
        sisu = Text(widget.tekst);
      case NupuOlek.laeb:
        sisu = Semantics(
          liveRegion: true,
          label: t.saadan,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      case NupuOlek.onnestus:
        sisu = Semantics(
          liveRegion: true,
          child: Icon(Icons.check, semanticLabel: t.saadetud),
        );
    }
    return FilledButton(onPressed: vajutus, child: sisu);
  }
}
