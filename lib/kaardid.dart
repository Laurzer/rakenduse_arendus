import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'main.dart';

// Üks kursus: nimi, kirjeldus ja internetist laetava pildi aadress.
class Kursus {
  const Kursus({
    required this.nimi,
    required this.kirjeldus,
    required this.pildiAadress,
  });

  final String nimi;
  final String kirjeldus;
  final String pildiAadress;
}

const List<Kursus> naidisKursused = [
  Kursus(
    nimi: 'Flutteri alused',
    kirjeldus: 'Vidinad, lehed ja navigeerimine.',
    pildiAadress: 'https://picsum.photos/seed/flutter/480/270',
  ),
  Kursus(
    nimi: 'Kasutajaliidese disain',
    kirjeldus: 'Paigutus, värvid ja tüpograafia.',
    pildiAadress: 'https://picsum.photos/seed/disain/480/270',
  ),
  Kursus(
    nimi: 'Veebitehnoloogiad',
    kirjeldus: 'HTML, CSS ja HTTP päringud.',
    pildiAadress: 'https://picsum.photos/seed/veeb/480/270',
  ),
  Kursus(
    nimi: 'Tootearendus',
    kirjeldus: 'Ideest valmis tooteni.',
    pildiAadress: 'https://picsum.photos/seed/toode/480/270',
  ),
  Kursus(
    nimi: 'Tehisintellekti alused',
    kirjeldus: 'AI tööriistad disainis ja arenduses.',
    pildiAadress: 'https://picsum.photos/seed/tehisaru/480/270',
  ),
];

// Ülesanne 8: taaskasutatav osa. Nupud ilmuvad ainult siis, kui need on antud.
class KursuseKaart extends StatelessWidget {
  const KursuseKaart({
    super.key,
    required this.kursus,
    this.onMuuda,
    this.onEemalda,
  });

  final Kursus kursus;
  final VoidCallback? onMuuda;
  final VoidCallback? onEemalda;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SizedBox(
      width: 260,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                kursus.pildiAadress,
                // Ülesanne 12: pilt dekodeeritakse näidatavas suuruses.
                cacheWidth: 520,
                fit: BoxFit.cover,
                semanticLabel: kursus.nimi,
                loadingBuilder: (context, pilt, edenemine) {
                  if (edenemine == null) return pilt;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, viga, jalg) {
                  return const Center(child: Icon(Icons.broken_image));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kursus.nimi,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(kursus.kirjeldus),
                ],
              ),
            ),
            if (onMuuda != null || onEemalda != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onMuuda != null)
                    IconButton(
                      tooltip: t.muuda,
                      icon: const Icon(Icons.edit),
                      onPressed: onMuuda,
                    ),
                  if (onEemalda != null)
                    IconButton(
                      tooltip: t.eemalda,
                      icon: const Icon(Icons.delete),
                      onPressed: onEemalda,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Ülesanded 8 ja 9: lisamine, muutmine, eemaldamine ja horisontaalne kerimine.
class KursusedLeht extends StatefulWidget {
  const KursusedLeht({super.key});

  @override
  State<KursusedLeht> createState() => _KursusedLehtState();
}

class _KursusedLehtState extends State<KursusedLeht> {
  final List<Kursus> kursused = List.of(naidisKursused);
  final ScrollController kerimine = ScrollController();

  @override
  void dispose() {
    kerimine.dispose();
    super.dispose();
  }

  Future<void> lisa() async {
    final uus = await avaVorm();
    if (uus == null) return;
    setState(() {
      kursused.add(uus);
    });
  }

  Future<void> muuda(int indeks) async {
    final muudetud = await avaVorm(algne: kursused[indeks]);
    if (muudetud == null) return;
    setState(() {
      kursused[indeks] = muudetud;
    });
  }

  void eemalda(int indeks) {
    setState(() {
      kursused.removeAt(indeks);
    });
  }

  Future<Kursus?> avaVorm({Kursus? algne}) {
    return showDialog<Kursus>(
      context: context,
      builder: (context) => KursuseVorm(algne: algne),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    // Ülesanne 10: rida kasvab koos kasutaja valitud teksti suurusega.
    final korgus = 242 + MediaQuery.textScalerOf(context).scale(88);
    return LeheRaam(
      pealkiri: t.kursused,
      lisaNupp: FloatingActionButton(
        tooltip: t.lisaKursus,
        onPressed: lisa,
        child: const Icon(Icons.add),
      ),
      sisu: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: korgus,
            child: Scrollbar(
              controller: kerimine,
              thumbVisibility: true,
              // ListView.builder loob ainult nähtavad kaardid, seega laetakse
              // ka pildid alles siis, kui kaart on ekraani lähedal.
              child: ListView.builder(
                controller: kerimine,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: kursused.length,
                itemBuilder: (context, indeks) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 16),
                    child: KursuseKaart(
                      kursus: kursused[indeks],
                      onMuuda: () => muuda(indeks),
                      onEemalda: () => eemalda(indeks),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KursuseVorm extends StatefulWidget {
  const KursuseVorm({super.key, this.algne});

  final Kursus? algne;

  @override
  State<KursuseVorm> createState() => _KursuseVormState();
}

class _KursuseVormState extends State<KursuseVorm> {
  late final TextEditingController nimi;
  late final TextEditingController kirjeldus;
  late final TextEditingController pilt;
  bool nimiPuudub = false;

  @override
  void initState() {
    super.initState();
    nimi = TextEditingController(text: widget.algne?.nimi ?? '');
    kirjeldus = TextEditingController(text: widget.algne?.kirjeldus ?? '');
    pilt = TextEditingController(text: widget.algne?.pildiAadress ?? '');
  }

  @override
  void dispose() {
    nimi.dispose();
    kirjeldus.dispose();
    pilt.dispose();
    super.dispose();
  }

  void salvesta() {
    final uusNimi = nimi.text.trim();
    if (uusNimi.isEmpty) {
      setState(() {
        nimiPuudub = true;
      });
      return;
    }
    final aadress = pilt.text.trim();
    Navigator.of(context).pop(
      Kursus(
        nimi: uusNimi,
        kirjeldus: kirjeldus.text.trim(),
        pildiAadress: aadress.isEmpty
            ? 'https://picsum.photos/seed/${Uri.encodeComponent(uusNimi)}/480/270'
            : aadress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.algne == null ? t.lisaKursus : t.muudaKursust),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nimi,
              decoration: InputDecoration(
                labelText: t.nimi,
                errorText: nimiPuudub ? t.sisestaNimi : null,
              ),
            ),
            TextField(
              controller: kirjeldus,
              decoration: InputDecoration(labelText: t.kirjeldus),
            ),
            TextField(
              controller: pilt,
              decoration: InputDecoration(labelText: t.pildiAadress),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.tuhista),
        ),
        ElevatedButton(onPressed: salvesta, child: Text(t.salvesta)),
      ],
    );
  }
}
