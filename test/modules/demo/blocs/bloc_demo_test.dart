import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/modules/demo/blocs/bloc_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDrawerMainMenuBloc extends DrawerMainMenuBloc {}

class MockResponsiveBloc extends ResponsiveBloc {}

class MockDrawerSecondaryMenuBloc extends DrawerSecondaryMenuBloc {
  MockDrawerSecondaryMenuBloc();
}

void main() {
  group('Testing blocDemo', () {
    late BlocDemo blocDemo;
    late MockDrawerMainMenuBloc mockDrawerMainMenuBloc;
    late MockDrawerSecondaryMenuBloc mockDrawerSecondaryMenuBloc;
    setUp(() {
      mockDrawerMainMenuBloc = MockDrawerMainMenuBloc();
      mockDrawerSecondaryMenuBloc = MockDrawerSecondaryMenuBloc();
      blocDemo = BlocDemo(
        drawerMainMenuBloc: mockDrawerMainMenuBloc,
        drawerSecondaryMenuBloc: mockDrawerSecondaryMenuBloc,
      );
    });
    test('Testing add drawerOptions', () async {
      blocDemo.addMainOption();
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerMainMenuBloc.clearMainDrawer();
      blocDemo.addMainOptionWithSecondaryOptions();
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerMainMenuBloc.clearMainDrawer();
      blocDemo.addDrawerOptionMenu(
        onPressed: () {},
        title: 'test',
      );
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerSecondaryMenuBloc.clearSecondaryMainDrawer();
      blocDemo.addSecondaryDrawerOptionMenu(onPressed: () {}, title: 'title');
      expect(mockDrawerSecondaryMenuBloc.listMenuOptions.isNotEmpty, true);
    });
    test('Testing counter functions', () async {
      expect(blocDemo.counter, equals(0));
      expect(blocDemo.counter, isA<int>());
      blocDemo.incrementCount();
      expect(blocDemo.counter, equals(1));
      blocDemo.incrementCount();
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[2]));
      blocDemo.decrementCount();
      expect(blocDemo.counter, equals(1));
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[1]));
      blocDemo.reset();
      expect(blocDemo.counter, equals(0));
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[0]));
    });

    test('Main BlocDemo stream is disposed', () {
      final Stream<int> stream = blocDemo.counterStream;

      blocDemo.dispose();
      expect(stream.isBroadcast, false);
    });

    group('Testing blocDemo', () {
      late BlocDemo blocDemo;
      late MockDrawerMainMenuBloc mockDrawerMainMenuBloc;
      late MockDrawerSecondaryMenuBloc mockDrawerSecondaryMenuBloc;
      setUp(() {
        mockDrawerMainMenuBloc = MockDrawerMainMenuBloc();
        mockDrawerSecondaryMenuBloc = MockDrawerSecondaryMenuBloc();
        blocDemo = BlocDemo(
          drawerMainMenuBloc: mockDrawerMainMenuBloc,
          drawerSecondaryMenuBloc: mockDrawerSecondaryMenuBloc,
        );
      });
      test('Testing add main option with secondary options', () async {
        blocDemo.addMainOptionWithSecondaryOptions();

        // Check that the main option was added
        expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
        expect(
          mockDrawerMainMenuBloc.listMenuOptions[0].title.isNotEmpty,
          true,
        );
        expect(
          mockDrawerMainMenuBloc.listMenuOptions[0].icondata,
          Icons.add_circle,
        );
        // Remove the main option
        mockDrawerMainMenuBloc.listMenuOptions[0].onPressed();
        mockDrawerMainMenuBloc.listMenuOptions[1].onPressed();
        await Future<void>.delayed(Duration.zero);

        // Check that the secondary options were added
        expect(mockDrawerSecondaryMenuBloc.listMenuOptions.length, 5);
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[0].toolTip,
          'Increment Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[0].icondata,
          Icons.add_circle,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[1].toolTip,
          'Decrement Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[1].icondata,
          Icons.remove_circle,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[2].toolTip,
          'reset Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[2].icondata,
          Icons.refresh,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[3].toolTip,
          'Remove MainOption',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[3].icondata,
          Icons.remove,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[4].toolTip,
          'Remove MainDrawer',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[4].icondata,
          Icons.garage,
        );

        // Remove the main option
        mockDrawerMainMenuBloc.listMenuOptions[1].onPressed();
        await Future<void>.delayed(Duration.zero);
      });
    });

    tearDown(() {
      blocDemo.dispose();
    });
  });
}
