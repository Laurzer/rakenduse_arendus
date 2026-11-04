import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deadline_app/main.dart';

void main() {
  setUp(() => keel.value = const Locale('et'));

  testWidgets('Meie lehel ilmub iga vajutusega järgmine nimi', (tester) async {
    await tester.pumpWidget(const MinuRakendus());
    await tester.tap(find.text('Meie'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Näita järgmist nime'));
    await tester.pump();
    expect(find.text(grupiLiikmed[0]), findsOneWidget);

    await tester.tap(find.text('Näita järgmist nime'));
    await tester.pump();
    expect(find.text(grupiLiikmed[1]), findsOneWidget);
  });

  testWidgets('Keelenupp vahetab rakenduse keele', (tester) async {
    await tester.pumpWidget(const MinuRakendus());
    expect(find.text('Meie'), findsOneWidget);

    await tester.tap(find.text('EN'));
    await tester.pumpAndSettle();
    expect(find.text('About us'), findsOneWidget);
    expect(find.text('Meie'), findsNothing);
  });

  testWidgets('Meie leht vastab ligipääsetavuse juhistele', (tester) async {
    final kontroll = tester.ensureSemantics();
    await tester.pumpWidget(const MinuRakendus());
    await tester.tap(find.text('Meie'));
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    kontroll.dispose();
  });
}
