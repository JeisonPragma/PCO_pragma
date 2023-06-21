import 'dart:async';

import 'blocs/bloc_drawer.dart';
import 'blocs/bloc_processing.dart';
import 'blocs/bloc_responsive.dart';
import 'blocs/bloc_secondary_drawer.dart';
import 'blocs/navigator_bloc.dart';
import 'blocs/onboarding_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'entities/entity_bloc.dart';
import 'modules/cat/blocs/cat_bloc.dart';
import 'modules/demo/blocs/bloc_demo.dart';
import 'modules/demo/ui/pages/demo_home_page.dart';
import 'providers/my_app_navigator_provider.dart';
import 'services/cat_service.dart';
import 'services/theme_config.dart';
import 'services/theme_service.dart';
import 'ui/pages/my_onboarding_page.dart';

/// Zona de configuración inicial
final BlocCore<dynamic> blocCore = BlocCore<dynamic>();
bool _init = false;
FutureOr<void> testMe() async {
  await Future<void>.delayed(
    const Duration(seconds: 2),
  );
}

Future<void> onboarding([
  Duration initialDelay = const Duration(seconds: 2),
]) async {
  /// Register modules to use
  /// Inicializamos el responsive y la ux del usuario

  blocCore.addBlocModule<ResponsiveBloc>(
    ResponsiveBloc.name,
    ResponsiveBloc(),
  );
  blocCore.addBlocModule<BlocProcessing>(
    BlocProcessing.name,
    BlocProcessing(),
  );

  blocCore.addBlocModule<DrawerMainMenuBloc>(
    DrawerMainMenuBloc.name,
    DrawerMainMenuBloc(),
  );

  blocCore.addBlocModule<DrawerSecondaryMenuBloc>(
    DrawerSecondaryMenuBloc.name,
    DrawerSecondaryMenuBloc(),
  );
  blocCore.addBlocModule<BlocDemo>(
    BlocDemo.name,
    BlocDemo(
      drawerMainMenuBloc:
          blocCore.getBlocModule<DrawerMainMenuBloc>(DrawerMainMenuBloc.name),
      drawerSecondaryMenuBloc: blocCore.getBlocModule<DrawerSecondaryMenuBloc>(
        DrawerSecondaryMenuBloc.name,
      ),
    ),
  );

  blocCore.addBlocModule<CatBloc>(
    CatBloc.name,
    CatBloc(catService: CatService()),
  );

  if (!_init) {
    /// register onboarding
    blocCore.addBlocModule(
      OnboardingBloc.name,
      OnboardingBloc(
        <FutureOr<void> Function()>[
          testMe,
          testMe,
          testMe,
          () async {
            blocCore
                .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                .setHomePageAndUpdate(
                  DemoHomePage(
                    blocDemo: blocCore.getBlocModule<BlocDemo>(BlocDemo.name),
                  ),
                );
            blocCore
                .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                .setTitle('Demo Home');
          }
        ],
      ),
    );

    // Revisar el orden de agregar los modulos y una mejor forma de
    // implementar esta configuracion global inicial
    blocCore.addBlocModule<NavigatorBloc>(
      NavigatorBloc.name,
      NavigatorBloc(
        myPageManager,
        MyOnboardingPage(
          onboardingBloc:
              blocCore.getBlocModule<OnboardingBloc>(OnboardingBloc.name),
          responsiveBloc:
              blocCore.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name),
        ),
      ),
    );
    blocCore.addBlocModule<ThemeBloc>(
      ThemeBloc.name,
      ThemeBloc(
        ThemeService(
          lightColorScheme: lightColorScheme,
          darkColorScheme: darkColorScheme,
          colorSeed: colorSeed,
        ),
      ),
    );

    _init = true;
  }
}
