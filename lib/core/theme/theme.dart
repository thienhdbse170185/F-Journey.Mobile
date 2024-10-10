import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284831119),
      surfaceTint: Color(4284960932),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293582335),
      onPrimaryContainer: Color(4280352861),
      secondary: Color(4284636017),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293451512),
      onSecondaryContainer: Color(4280097067),
      tertiary: Color(4286403168),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957284),
      onTertiaryContainer: Color(4281405725),
      error: Color(4289930782),
      onError: Color(4294967295),
      errorContainer: Color(4294565596),
      onErrorContainer: Color(4282453515),
      background: Color(4294899711),
      onBackground: Color(4280097568),
      surface: Color(4294899711),
      onSurface: Color(4280097568),
      surfaceVariant: Color(4293386476),
      onSurfaceVariant: Color(4282991951),
      outline: Color(4286149758),
      outlineVariant: Color(4291478736),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294307831),
      inversePrimary: Color(4291869951),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4280352861),
      primaryFixedDim: Color(4291869951),
      onPrimaryFixedVariant: Color(4283381643),
      secondaryFixed: Color(4293451512),
      onSecondaryFixed: Color(4280097067),
      secondaryFixedDim: Color(4291609308),
      onSecondaryFixedVariant: Color(4283057240),
      tertiaryFixed: Color(4294957284),
      onTertiaryFixed: Color(4281405725),
      tertiaryFixedDim: Color(4293900488),
      onTertiaryFixedVariant: Color(4284693320),
      surfaceDim: Color(4292794593),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294176247),
      surfaceContainerHigh: Color(4293715696),
      surfaceContainerHighest: Color(4293320937),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282988913),
      surfaceTint: Color(4284831119),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286278567),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282988913),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286344103),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4285214533),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4289027959),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285411116),
      onError: Color(4294967295),
      errorContainer: Color(4289355610),
      onErrorContainer: Color(4294967295),
      background: Color(4294834175),
      onBackground: Color(4280097568),
      surface: Color(4294834175),
      onSurface: Color(4280032032),
      surfaceVariant: Color(4293320940),
      onSurfaceVariant: Color(4282663242),
      outline: Color(4284571239),
      outlineVariant: Color(4286413187),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294307831),
      inversePrimary: Color(4291804670),
      primaryFixed: Color(4286278567),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284633996),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286344103),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284633996),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4289027959),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4287186782),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294834175),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293321193),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280751950),
      surfaceTint: Color(4284831119),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282988913),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280751950),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282988913),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282519076),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285214533),
      onTertiaryContainer: Color(4294967295),
      error: Color(4282650382),
      onError: Color(4294967295),
      errorContainer: Color(4285411116),
      onErrorContainer: Color(4294967295),
      background: Color(4294834175),
      onBackground: Color(4280097568),
      surface: Color(4294834175),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293320940),
      onSurfaceVariant: Color(4280623915),
      outline: Color(4282663242),
      outlineVariant: Color(4282663242),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294043903),
      primaryFixed: Color(4282988913),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281475929),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282988913),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281475929),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285214533),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283439407),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294834175),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293321193),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4291869950),
      surfaceTint: Color(4291869951),
      onPrimary: Color(4281867890),
      primaryContainer: Color(4283381643),
      onPrimaryContainer: Color(4293582335),
      secondary: Color(4291609308),
      onSecondary: Color(4281544001),
      secondaryContainer: Color(4283057240),
      onSecondaryContainer: Color(4293451512),
      tertiary: Color(4293900488),
      onTertiary: Color(4282983730),
      tertiaryContainer: Color(4284693320),
      onTertiaryContainer: Color(4294957284),
      error: Color(4294097077),
      onError: Color(4284486672),
      errorContainer: Color(4287372568),
      onErrorContainer: Color(4294565596),
      background: Color(4279505432),
      onBackground: Color(4293320937),
      surface: Color(4279505432),
      onSurface: Color(4293320937),
      surfaceVariant: Color(4282991951),
      onSurfaceVariant: Color(4291478736),
      outline: Color(4287860633),
      outlineVariant: Color(4282991951),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293320937),
      inverseOnSurface: Color(4281478965),
      inversePrimary: Color(4284960932),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4280352861),
      primaryFixedDim: Color(4291869951),
      onPrimaryFixedVariant: Color(4283381643),
      secondaryFixed: Color(4293451512),
      onSecondaryFixed: Color(4280097067),
      secondaryFixedDim: Color(4291609308),
      onSecondaryFixedVariant: Color(4283057240),
      tertiaryFixed: Color(4294957284),
      onTertiaryFixed: Color(4281405725),
      tertiaryFixedDim: Color(4293900488),
      onTertiaryFixedVariant: Color(4284693320),
      surfaceDim: Color(4279505432),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280097568),
      surfaceContainer: Color(4280360742),
      surfaceContainerHigh: Color(4281018672),
      surfaceContainerHighest: Color(4281742395),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292067839),
      surfaceTint: Color(4291804670),
      onPrimary: Color(4279961922),
      primaryContainer: Color(4288186309),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4292067839),
      onSecondary: Color(4279961922),
      secondaryContainer: Color(4288186309),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294948813),
      onTertiary: Color(4281532952),
      tertiaryContainer: Color(4291132307),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949299),
      onError: Color(4281533445),
      errorContainer: Color(4291591028),
      onErrorContainer: Color(4278190080),
      background: Color(4279505432),
      onBackground: Color(4293320937),
      surface: Color(4279505688),
      onSurface: Color(4294965759),
      surfaceVariant: Color(4282926414),
      onSurfaceVariant: Color(4291742164),
      outline: Color(4289044908),
      outlineVariant: Color(4286939532),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321193),
      inverseOnSurface: Color(4281018671),
      inversePrimary: Color(4283318135),
      primaryFixed: Color(4293516799),
      onPrimaryFixed: Color(4279632701),
      primaryFixedDim: Color(4291804670),
      onPrimaryFixedVariant: Color(4282133859),
      secondaryFixed: Color(4293516799),
      onSecondaryFixed: Color(4279632701),
      secondaryFixedDim: Color(4291804670),
      onSecondaryFixedVariant: Color(4282133859),
      tertiaryFixed: Color(4294957539),
      onTertiaryFixed: Color(4281008147),
      tertiaryFixedDim: Color(4294947017),
      onTertiaryFixedVariant: Color(4284162616),
      surfaceDim: Color(4279505688),
      surfaceBright: Color(4282005566),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280032032),
      surfaceContainer: Color(4280360740),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294965759),
      surfaceTint: Color(4291804670),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292067839),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965759),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292067839),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965753),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294948813),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949299),
      onErrorContainer: Color(4278190080),
      background: Color(4279505432),
      onBackground: Color(4293320937),
      surface: Color(4279505688),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282926414),
      onSurfaceVariant: Color(4294900223),
      outline: Color(4291742164),
      outlineVariant: Color(4291742164),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321193),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4281278550),
      primaryFixed: Color(4293780223),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292067839),
      onPrimaryFixedVariant: Color(4279961922),
      secondaryFixed: Color(4293780223),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4292067839),
      onSecondaryFixedVariant: Color(4279961922),
      tertiaryFixed: Color(4294959079),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294948813),
      onTertiaryFixedVariant: Color(4281532952),
      surfaceDim: Color(4279505688),
      surfaceBright: Color(4282005566),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280032032),
      surfaceContainer: Color(4280360740),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
