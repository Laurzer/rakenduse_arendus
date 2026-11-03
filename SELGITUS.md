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

Enne esitamist muuda faili alguses `grupiLiikmed` ja `serveriAadress`.
