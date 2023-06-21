import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_drawer.dart';
import '../../../mocks/mock_navigator_bloc.dart';

void main() {
  testWidgets('Test MyAppBarWidget', (WidgetTester tester) async {
    // Crea instancias de las clases mock
    final MockNavigatorBloc mockNavigatorBloc =
        MockNavigatorBloc(PageManager());
    final MockDrawerMainMenuBloc mockDrawerMainMenuBloc =
        MockDrawerMainMenuBloc();

    /* // Configura las respuestas necesarias de los métodos de las clases mock si es necesario
    when(mockNavigatorBloc.historyPageLength).thenReturn(2);
    when(mockNavigatorBloc.title).thenReturn('My App Title');
    when(mockDrawerMainMenuBloc.listMenuOptions).thenReturn([/* Lista de opciones del menú */]);
*/
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: MyAppBarWidget(
            navigatorBloc: mockNavigatorBloc,
            drawerMainMenuBloc: mockDrawerMainMenuBloc,
          ),
        ),
      ),
    );

    // Realizar pruebas y afirmaciones aquí
    // Por ejemplo, puedes utilizar `tester` para encontrar y verificar widgets dentro de MyAppBarWidget

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Text), findsAtLeastNWidgets(2));
    expect(find.byIcon(Icons.menu), findsOneWidget);
/*
    // await Future<void>.delayed(const Duration(milliseconds: 100));
    const Icon expectedIcon =
        Icon(Icons.chevron_left); // Reemplaza 'myIcon' con el icono esperado
    final Finder actualWidget = find.byWidgetPredicate(
      (Widget widget) => widget is IconButton && widget.icon == expectedIcon,
    );

    expect(actualWidget, findsOneWidget);
    // expect(find.byIcon(Icons.chevron_left), findsOneWidget);

 */
  });
}
