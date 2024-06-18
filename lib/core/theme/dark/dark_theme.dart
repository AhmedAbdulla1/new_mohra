part of '../theme_config.dart';

ThemeData _getDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColorDark,
    // accentColor: AppColors.accentColorDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentColorDark,
      secondary: AppColors.accentColorDark,
    ),

    /// Specifying fonts for application
    fontFamily: 'Inter-Regular',

    textTheme: TextTheme(
      bodyLarge: AppColors.textDark.bodyText1,
      bodyMedium: AppColors.textDark.bodyText2,
      labelLarge: AppColors.textDark.button,
      bodySmall: AppColors.textDark.caption,
      displayLarge: AppColors.textDark.headline1,
      displayMedium: AppColors.textDark.headline2,
      displaySmall: AppColors.textDark.headline3,
      headlineMedium: AppColors.textDark.headline4,
      headlineSmall: AppColors.textDark.headline5,
      titleLarge: AppColors.textDark.headline6,
      labelSmall: AppColors.textDark.overline,
      titleMedium: AppColors.textDark.subtitle1,
      titleSmall: AppColors.textDark.subtitle2,
    ),
  );
}
