abstract class Internationalization {
  Map<Translate, String> get languageMap;

  String translate(Translate key) {
    return languageMap[key] ?? 'NO_TRANSLATION';
  }
}

enum Translate { appName, login, logout, welcome, loading, homePage }

class SpanishInternationalization extends Internationalization {
  @override
  Map<Translate, String> get languageMap => {
    Translate.appName: "Futbolito",
    Translate.welcome: "¡Bienvenido a \nFutbolito!",
    Translate.login: "Iniciar sesión",
    Translate.logout: "Cerrar sesión",
    Translate.loading: "Cargando...",
    Translate.homePage: "Home",
  };
}
