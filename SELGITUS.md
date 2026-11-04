# Ülesannete selgitus

Kogu kood on failis `lib/main.dart`. Käivita: `flutter pub get`, siis `flutter run -d web-server --web-hostname 0.0.0.0`.

| Ülesanne | Kus | Kuidas töötab |
| --- | --- | --- |
| 1. Projekti loomine | `MinuRakendus` | Muuda pealkirja või `seedColor` värvi ja vaata, et rakendus muutub. |
| 2. Erinevad lehed | `routes`, `LeheRaam` | Igal lehel on oma aadress (`/` ja `/meie`). Navigeerimine on lehe päises. |
| 3. Nupuga tekst | `MeieLeht` | `setState` uuendab vaadet. Üks nupp näitab või peidab nimekirja, teine näitab järgmist nime. |
| 4. Failist lugemine | `InimesedLeht` | `rootBundle.loadString` loeb faili `assets/inimesed.json` ja `jsonDecode` teeb sellest nimekirja. |
| 6. HTTP kasutus | `ServerLeht` | `http.get` näitab, `http.post` lisab, `http.delete` kustutab. |
| 7. Võrgukutse nupp | `VorguNupp` | Nupul on kolm olekut: algne, laeb ja õnnestus. Ebaõnnestumisel läheb tagasi algolekusse. Nimevälja või vanusevälja muutmine viib õnnestunud nupu tagasi algolekusse. |
| 8. Taaskasutatavad osad | `lib/kaardid.dart`, `KursuseKaart` | Sama kaart on avalehel ja lehel Kursused. Pilt laaditakse internetist. Vorm lisab ja muudab kursusi, prügikasti nupp eemaldab. |
| 9. Horisontaalne scroll | `KursusedLeht` | `ListView.builder` kerib külgsuunas ja loob ainult nähtavad kaardid, nii laetakse pildid siis, kui neid on vaja. |
| 10. Ligipääsetavus | `LeheRaam`, `VorguNupp`, `KursuseKaart`, `test/widget_test.dart` | Pealkirjad on märgitud päistena, pildil on kirjeldus, olekumuutused loetakse ette, kaart kasvab suure tekstiga ning testid kontrollivad nupu suurust, silte ja kontrasti. |
| 11. Lokaliseerimine | `lib/l10n/`, `keel` | Tekstid asuvad ARB-failides. Nupp päises vahetab eesti ja inglise keele. Kuupäeva vorming tuleb valitud keelest. |
| 12. Jõudlus | `ServerLeht`, `KursuseKaart` | Pikad nimekirjad on `ListView.builder`, pildid dekodeeritakse näidatavas suuruses ja võrgukutsel on 10-sekundiline piirang. |

Enne ülesannete 6 ja 7 esitamist kontrolli faili alguses `serveriAadress`.
