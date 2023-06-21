import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyAppRouterDelegate', () {
    late MyAppRouterDelegate routerDelegate;
    late PageManager pageManager;
    setUp(() {
      pageManager = PageManager();
      routerDelegate = MyAppRouterDelegate();
    });

    test('currentConfiguration returns the current configuration', () {
      expect(
        routerDelegate.currentConfiguration?.historyPagesCount,
        pageManager.currentConfiguration.historyPagesCount,
      );
    });

    testWidgets('build method builds a Navigator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: MyAppRouteInformationParser(),
        ),
      );
      expect(find.byType(Navigator), findsOneWidget);
    });

    test('setNewRoutePath updates the configuration', () async {
      final PageManager newConfiguration = PageManager();
      await routerDelegate.setNewRoutePath(newConfiguration);
      expect(
        pageManager.currentConfiguration.historyPagesCount,
        newConfiguration.historyPagesCount,
      );
    });

    test('popRoute calls back on the PageManager', () async {
      final bool tmp = await routerDelegate.popRoute();
      pageManager.setHomePage(const Center());
      expect(tmp, true);
    });
  });
}
