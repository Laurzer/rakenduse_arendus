import 'package:flutter_test/flutter_test.dart';

import 'package:deadline_app/main.dart';

void main() {
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
}
