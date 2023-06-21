import 'package:aleteo_arquetipo/modules/demo/blocs/bloc_demo.dart';
import 'package:aleteo_arquetipo/modules/demo/ui/pages/demo_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mock_bloc_drawer.dart';
import '../../../../mocks/mock_secondary_drawer_bloc.dart';

void main() {
  testWidgets('Test DemoHomePage widget', (WidgetTester tester) async {
    final BlocDemo blocDemo = BlocDemo(
      drawerMainMenuBloc: MockDrawerMainMenuBloc(),
      drawerSecondaryMenuBloc: MockSecondaryDrawerBloc(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: DemoHomePage(
          blocDemo: blocDemo,
          isTesting: true,
        ),
      ),
    );

    // Verify that the widget displays the correct counter value
    expect(find.text('0'), findsOneWidget);
  });
}
