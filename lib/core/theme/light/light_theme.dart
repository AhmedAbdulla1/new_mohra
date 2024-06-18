 part of '../theme_config.dart';

ThemeData _getLightTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColorLight,
    // accentColor: AppColors.accentColorLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.accentColorLight,
      secondary: AppColors.accentColorLight,
    ),
    /// Specifying fonts for application
    fontFamily:isArabic? 'Tajawal':'Inter-Regular',

    textTheme: TextTheme(
      bodyLarge: AppColors.textLight.bodyText1,
      bodyMedium: AppColors.textLight.bodyText2,
      labelLarge: AppColors.textLight.button,
      bodySmall: AppColors.textLight.caption,
      displayLarge: AppColors.textLight.headline1,
      displayMedium: AppColors.textLight.headline2,
      displaySmall: AppColors.textLight.headline3,
      headlineMedium: AppColors.textLight.headline4,
      headlineSmall: AppColors.textLight.headline5,
      titleLarge: AppColors.textLight.headline6,
      labelSmall: AppColors.textLight.overline,
      titleMedium: AppColors.textLight.subtitle1,
      titleSmall: AppColors.textLight.subtitle2,
    ),
  );
}
