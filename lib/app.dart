import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_friend_moments_screen.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';
import 'core/common/provider/provider_list.dart';
import 'core/constants/app/app_constants.dart';
import 'core/localization/flutter_localization.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/route_generator.dart';
import 'di/service_locator.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart'
    as c;
import 'generated/l10n.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    FlutterAppBadger.removeBadge();
    WidgetsBinding.instance.addObserver(this);
    initDynamicLinks();
    super.initState();
  }

  void initDynamicLinks() async {
    print("initdynamiclnk");
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('onclik');
      print(dynamicLinkData.link);
      print(dynamicLinkData.link.queryParameters);
      if (dynamicLinkData.link.queryParameters['type'] ==
          VisitUserProfileScreen.routeName) {
        int id = int.tryParse(
              dynamicLinkData.link.queryParameters['userId']!,
            ) ??
            0;
        print("dynamic link user id "  +id.toString());
        bool isAuth = BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
            .isAuth;
        if(isAuth) {


        if (id != UserSessionDataModel.userId) {
          Nav.to(
            // AppConfig().appContext,
            VisitUserProfileScreen.routeName,
            arguments: VisitUserProfileScreenParams(
              id: id,
            ),
          );
        } else {
          Nav.to(
            ViewFriendMomentsScreen.routeName,
            arguments: c.ClientEntity(
              addresses: [],
              hasAvatar: true,
              surname: UserSessionDataModel.surname,
              qrCode: UserSessionDataModel.qrCode ?? "",
              code: UserSessionDataModel.code ?? "",
              fullName: UserSessionDataModel.fullName,
              id: UserSessionDataModel.userId,
              imageUrl: UserSessionDataModel.imageUrl,
              emailAddress: UserSessionDataModel.emailAddress,
              name: UserSessionDataModel.name,
              phoneNumber: UserSessionDataModel.phoneNumber,
              countryCode: UserSessionDataModel.countryCode ?? "",
            ),
          );
        }
      }}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

    // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    // final Uri? deepLink = initialLink?.link;
    // if (deepLink != null) {
    //   Navigator.pushNamed(context, deepLink.path);
    // }
  }

  // restart() {
  //   RestartWidget.restartApp(getIt<NavigationService>().appContext!);
  // }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: [
          ...ApplicationProvider().dependItems,
        ],
        child: Consumer<LocalizationProvider>(
          builder: (_, provider, __) {
            return ScreenUtilInit(
              designSize: AppConfig.screenUtilDesignSize(),
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConstants.TITLE_APP_NAME,

                  /// Routing
                  navigatorKey: getIt<NavigationService>().getNavigationKey,
                  onGenerateRoute: getIt<NavigationRoute>().generateRoute,
                  initialRoute: "/",
                  navigatorObservers: [],

                  /// Setup app localization
                  supportedLocales: Translation.delegate.supportedLocales,
                  locale: provider.appLocal,
                  localizationsDelegates: [
                    Translation.delegate,
                    // Built-in localization of basic text for Material widgets
                    GlobalMaterialLocalizations.delegate,
                    // Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],

                  /// Run app at first time on device language
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (provider.firstStart) {
                      /// Check if the current device locale is supported
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                            locale!.languageCode) {
                          /// Set _firstStart false
                          provider.firstStartOff();

                          /// Change language
                          provider.changeLanguage(
                            const Locale("ar"),
                            context,
                          );
                          AppConfig().setAppLanguage = "ar";
                          return supportedLocale;
                        }
                      }

                      /// If the locale of the device is not supported, use the first one
                      /// from the list (English, in this case).
                      provider.changeLanguage(
                        supportedLocales.first,
                        context,
                      );
                      AppConfig().setAppLanguage =
                          supportedLocales.first.languageCode;
                      return supportedLocales.first;
                    } else
                      return null;
                  },

                  /// Theming
                  theme: AppConfig().themeData,
                  themeMode: AppConfig().themeMode,

                  /// Init match
                  //  home: HomeScreen(),
                  home: SplashScreen(),
                  // home: BookingServicesScreen(),
                  // home: ProfileBookingScreen(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    ApplicationProvider().dispose(context);
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
