abstract class Internationalization {
  Map<Translate, String> get languageMap;

  String translate(Translate key) {
    return languageMap[key] ?? 'NO_TRANSLATION';
  }
}

enum Translate {
  appName,
  welcome,
  login,
  logout,
  loading,
  homePage,
  loginSubtitle,
  // Navigation
  homeTab,
  matchesTab,
  teamsTab,
  profileTab,
  // Matches
  matchesTitle,
  matchesDescription,
  // Teams
  teamsTitle,
  teamsDescription,
  // Profile
  profileTitle,
  userDefault,
  // Home
  homeWelcome,
  homeDescription,
}

class SpanishInternationalization extends Internationalization {
  @override
  Map<Translate, String> get languageMap => {
    Translate.appName: "Futbolito",
    Translate.welcome: "¡Bienvenido a \nFutbolito!",
    Translate.login: "Iniciar sesión",
    Translate.logout: "Cerrar sesión",
    Translate.loading: "Cargando...",
    Translate.homePage: "Home",
    Translate.loginSubtitle: "La app para que no te falte nadie.",
    // Navigation
    Translate.homeTab: "Inicio",
    Translate.matchesTab: "Partidos",
    Translate.teamsTab: "Equipos",
    Translate.profileTab: "Perfil",
    // Matches
    Translate.matchesTitle: "Partidos",
    Translate.matchesDescription: "Aquí verás todos los partidos",
    // Teams
    Translate.teamsTitle: "Equipos",
    Translate.teamsDescription: "Aquí verás todos los equipos",
    // Profile
    Translate.profileTitle: "Perfil",
    Translate.userDefault: "Usuario",
    // Home
    Translate.homeWelcome: "Bienvenido a Futbolito",
    Translate.homeDescription:
        "Gestiona tus partidos y equipos de forma sencilla",
  };
}
