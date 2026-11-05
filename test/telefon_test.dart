import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deadline_app/main.dart';

// Kontrollib, et ükski leht ei lähe telefoni laiusel (400 px) üle ääre.
void main() {
  // Tühjendab failide vahemälu, et Inimesed leht loeks faili igas testis uuesti.
  setUp(() => rootBundle.clear());

  for (final keeleKood in ['et', 'en']) {
    for (final aadress in ['/', '/meie', '/inimesed', '/server', '/kursused']) {
      testWidgets('Leht $aadress ($keeleKood) mahub telefoni ekraanile', (
        tester,
      ) async {
        keel.value = Locale(keeleKood);
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(const MinuRakendus());
        await tester.pumpAndSettle();
        if (aadress != '/') {
          final navigaator = tester.state<NavigatorState>(
            find.byType(Navigator),
          );
          navigaator.pushReplacementNamed(aadress);
          await tester.pumpAndSettle();
        }
        expect(tester.takeException(), isNull);
      });
    }
  }
}
