
import 'package:flutter_test/flutter_test.dart';
import 'package:online_quran_flutter/app.dart';

void main() {
  testWidgets('Quran app displays navigation tabs', (tester) async {
    await tester.pumpWidget(const QuranApp());

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Quran'), findsOneWidget);
    expect(find.text('Courses'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
