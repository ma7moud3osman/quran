class AppServices {
  static final AppServices _appServices = AppServices._internal();

  factory AppServices() => _appServices;

  AppServices._internal();

  void initAppServices() {
    // Initialize common services here
  }

  void disposeAppServices() {
    // Dispose common services here
  }
}
