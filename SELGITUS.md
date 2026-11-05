# Ülesannete selgitus

Kood on kahes failis:

- `lib/main.dart`: kujundus (`looTeema`), ühine lehe raam (`LeheRaam`), lehed Kodu, Meie, Inimesed ja Server, HTTP päringud ning võrgukutse nupp (`VorguNupp`).
- `lib/kaardid.dart`: kursused (`Kursus`), kursusekaart (`KursuseKaart`), leht Kursused (`KursusedLeht`) ja kursuse vorm (`KursuseVorm`).

Tekstid on kaustas `lib/l10n/`, failist loetavad andmed failis `assets/inimesed.json` ja testid kaustas `test/`.

Käivita: `flutter pub get`, siis `flutter run -d web-server --release --web-hostname 0.0.0.0 --web-port 8080`. Pärast uut käivitust tee brauseris kõva värskendus (Ctrl+Shift+R).

| Ülesanne | Kus | Kuidas töötab |
| --- | --- | --- |
| 1. Projekti loomine | `MinuRakendus`, `pohiVarv` | Muuda pealkirja või põhivärvi `pohiVarv` ja vaata, et rakendus muutub. |
| 2. Erinevad lehed | `routes`, `LeheRaam` | Igal lehel on oma aadress (`/`, `/meie`, `/inimesed`, `/server`, `/kursused`). Navigeerimine on lehe päises. |
| 3. Nupuga tekst | `MeieLeht` | `setState` uuendab vaadet. Üks nupp näitab või peidab nimekirja, teine näitab järgmist nime. |
| 4. Failist lugemine | `InimesedLeht` | `rootBundle.loadString` loeb faili `assets/inimesed.json` ja `jsonDecode` teeb sellest nimekirja. |
| 6. HTTP kasutus | `ServerLeht` | `http.get` näitab, `http.post` lisab, `http.delete` kustutab. |
| 7. Võrgukutse nupp | `VorguNupp` | Nupul on kolm olekut: algne, laeb ja õnnestus. Ebaõnnestumisel läheb tagasi algolekusse. Nimevälja või vanusevälja muutmine viib õnnestunud nupu tagasi algolekusse. |
| 8. Taaskasutatavad osad | `lib/kaardid.dart`, `KursuseKaart` | Sama kaart on avalehel ja lehel Kursused. Pilt laaditakse internetist. Vorm lisab ja muudab kursusi, prügikasti nupp eemaldab. |
| 9. Horisontaalne scroll | `lib/kaardid.dart`, `KursusedLeht` | `ListView.builder` kerib külgsuunas ja loob ainult nähtavad kaardid, nii laetakse pildid siis, kui neid on vaja. |
| 10. Ligipääsetavus | `LeheRaam`, `VorguNupp`, `KursuseKaart`, `test/widget_test.dart` | Pealkirjad on märgitud päistena, pildil on kirjeldus, olekumuutused loetakse ette, kaart kasvab suure tekstiga ning testid kontrollivad nupu suurust, silte ja kontrasti. |
| 11. Lokaliseerimine | `lib/l10n/`, `keel` | Tekstid asuvad ARB-failides. Nupp päises vahetab eesti ja inglise keele. Kuupäeva vorming tuleb valitud keelest. |
| 12. Jõudlus | `ServerLeht`, `KursuseKaart` | Pikad nimekirjad on `ListView.builder`, pildid dekodeeritakse näidatavas suuruses ja võrgukutsel on 10-sekundiline piirang. |

## Kujundus

Kujundust on uuendatud, et rakendus oleks ühtne ja töötaks ka telefonis.

| Muudatus | Kus | Mida teeb |
| --- | --- | --- |
| Ühine teema | `looTeema()`, `pohiVarv` | Värvid, kaardid, nupud ja tekstiväljad on määratud ühes kohas. Põhivärv on rohekassinine (`#0F766E`), taust hele, kaartidel on õhuke ääris ja ümarad nurgad. |
| Sisu keskel | `LeheRaam`, `sisuLaius` | Laial ekraanil on sisu keskel ja kuni 880 px lai, nii et read ei veni liiga pikaks. |
| Päis ja menüü | `LeheRaam` | Kõigil lehtedel on sama päis. Aktiivne leht on menüüs heleda taustaga. Kitsal ekraanil saab menüüd külgsuunas kerida. Keelenupp on päises paremal. |
| Nupud ja väljad | `looTeema()` | Põhinupud on vähemalt 160 × 48 px, nii et neid on lihtne vajutada. Tekstiväljad on valge taustaga ja ümarate nurkadega. |
| Kitsas ekraan | `ServerLeht`, `MeieLeht` | Serveri lehel on väljad laias vaates kõrvuti ja kitsas üksteise all. Meie lehe nupud lähevad vajadusel uuele reale. |
| Kursusekaart | `lib/kaardid.dart`, `KursuseKaart` | Kursuse nimi ja kirjeldus on kuni 2 rida, pikem tekst lõpeb kolme punktiga, nii et kaart ei lähe Kursused lehe reast üle. |
| Telefoni test | `test/telefon_test.dart` | Kontrollib, et ükski leht ei lähe 400 px laiusel ekraanil üle ääre, eesti ja inglise keeles. |

Enne ülesannete 6 ja 7 esitamist kontrolli faili `lib/main.dart` alguses `serveriAadress`.
