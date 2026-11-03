import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// Muuda siin: 300X, kus X on teie tiimi number (ülesanne 6).
const String serveriAadress = 'http://192.168.46.75:3001/people';

// Muuda siin: teie grupi päris liikmed (ülesanded 2 ja 3).
const List<String> grupiLiikmed = ['Laura-Liis', 'Anastasia'];

void main() {
  runApp(const MinuRakendus());
}

class MinuRakendus extends StatelessWidget {
  const MinuRakendus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rakenduse arendus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // Ülesanne 2: igal lehel on oma aadress.
      initialRoute: '/',
      routes: {
        '/': (context) => const KoduLeht(),
        '/meie': (context) => const MeieLeht(),
        '/inimesed': (context) => const InimesedLeht(),
        '/server': (context) => const ServerLeht(),
      },
    );
  }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(pealkiri),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _lingiNupp(context, 'Kodu', '/'),
                _lingiNupp(context, 'Meie', '/meie'),
                _lingiNupp(context, 'Inimesed', '/inimesed'),
                _lingiNupp(context, 'Server', '/server'),
              ],
            ),
          ),
        ),
      ),
      body: sisu,
      floatingActionButton: lisaNupp,
    );
  }

  Widget _lingiNupp(BuildContext context, String tekst, String aadress) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacementNamed(aadress),
      child: Text(tekst),
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
    return const LeheRaam(
      pealkiri: 'Kodu',
      sisu: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Tere tulemast! See on meie grupi Flutteri õpperakendus. '
          'Rakenduses saab vaadata grupi liikmeid, lugeda andmeid failist '
          'ning hallata serveris olevaid inimesi.',
        ),
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
    return LeheRaam(
      pealkiri: 'Meie',
      sisu: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: vahetaNimekirja,
            child: Text(nimekiriNahtav ? 'Peida nimekiri' : 'Näita nimekirja'),
          ),
          if (nimekiriNahtav)
            for (final nimi in grupiLiikmed)
              ListTile(leading: const Icon(Icons.person), title: Text(nimi)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: naitaJargmist,
            child: const Text('Näita järgmist nime'),
          ),
          const SizedBox(height: 12),
          if (nimeJarjekord >= 0)
            Text(
              grupiLiikmed[nimeJarjekord],
              style: Theme.of(context).textTheme.headlineSmall,
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
        viga = 'Faili lugemine ebaõnnestus: $e';
        laeb = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget sisu;
    if (laeb) {
      sisu = const Center(child: CircularProgressIndicator());
    } else if (viga != null) {
      sisu = Center(child: Text(viga!));
    } else {
      sisu = ListView.builder(
        itemCount: inimesed.length,
        itemBuilder: (context, indeks) {
          final inimene = inimesed[indeks];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('${inimene['nimi']}'),
            subtitle: Text('Vanus: ${inimene['vanus']}'),
            trailing: Text(inimene['member'] == true ? 'Liige' : 'Pole liige'),
          );
        },
      );
    }
    return LeheRaam(pealkiri: 'Inimesed failist', sisu: sisu);
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

  // GET: küsib andmed serverist.
  Future<void> laeAndmed() async {
    setState(() {
      laeb = true;
      viga = null;
    });
    try {
      final vastus = await http.get(Uri.parse(serveriAadress));
      if (vastus.statusCode != 200) {
        throw Exception('server vastas koodiga ${vastus.statusCode}');
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
        viga = 'Andmete laadimine ebaõnnestus: $e';
        laeb = false;
      });
    }
  }

  // POST: lisab inimese. Tagastab true, kui kutse õnnestus.
  Future<bool> lisaInimene() async {
    final nimi = nimeVali.text.trim();
    final vanus = vanuseVali.text.trim();
    if (nimi.isEmpty || vanus.isEmpty) return false;
    try {
      final vastus = await http.post(
        Uri.parse(serveriAadress),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nimi': nimi, 'vanus': vanus, 'member': true}),
      );
      if (vastus.statusCode != 200 && vastus.statusCode != 201) return false;
      await laeAndmed();
      return true;
    } catch (e) {
      return false;
    }
  }

  // DELETE: kustutab inimese tema id järgi.
  Future<void> kustutaInimene(dynamic id) async {
    try {
      final vastus = await http.delete(Uri.parse('$serveriAadress/$id'));
      if (vastus.statusCode >= 300) {
        throw Exception('server vastas koodiga ${vastus.statusCode}');
      }
      await laeAndmed();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Kustutamine ebaõnnestus: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LeheRaam(
      pealkiri: 'Inimesed serveris',
      sisu: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: nimeVali,
            decoration: const InputDecoration(labelText: 'Nimi'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: vanuseVali,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Vanus'),
          ),
          const SizedBox(height: 16),
          // Ülesanne 7. Muudetud andmed viivad nupu tagasi algolekusse.
          VorguNupp(
            tekst: 'Saada serverisse',
            muutused: Listenable.merge([nimeVali, vanuseVali]),
            onVajutus: lisaInimene,
          ),
          const SizedBox(height: 24),
          if (laeb) const Center(child: CircularProgressIndicator()),
          if (viga != null) Text(viga!),
          for (final inimene in inimesed)
            ListTile(
              title: Text('${inimene['nimi']}'),
              subtitle: Text('Vanus: ${inimene['vanus']}'),
              trailing: IconButton(
                tooltip: 'Kustuta',
                icon: const Icon(Icons.delete),
                onPressed: () => kustutaInimene(inimene['id']),
              ),
            ),
        ],
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
    Widget sisu;
    switch (olek) {
      case NupuOlek.algne:
        sisu = Text(widget.tekst);
      case NupuOlek.laeb:
        sisu = const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case NupuOlek.onnestus:
        sisu = const Icon(Icons.check);
    }
    return ElevatedButton(onPressed: vajutus, child: sisu);
  }
}
