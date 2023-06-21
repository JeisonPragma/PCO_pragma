import 'package:aleteo_arquetipo/ui/widgets/responsive/list_tile_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('general testing', () {
    testWidgets('Test ListTileExitDrawerWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            endDrawer: Drawer(),
            body: ListTileExitDrawerWidget(),
          ),
        ),
      );

      // Realizar pruebas y afirmaciones aquí
      // Por ejemplo, puedes utilizar `tester` para encontrar y verificar widgets dentro de ListTileExitDrawerWidget

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.text('Salir'), findsOneWidget);
      expect(find.text('Cerrar menu lateral'), findsOneWidget);
    });
  });
}
