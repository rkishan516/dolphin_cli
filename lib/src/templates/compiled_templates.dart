// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
//       This file should be checked into source control.

// -------- PubspecYamlStub Template Data ----------

// ignore_for_file: constant_identifier_names

const String kAppMobileTemplatePubspecYamlStubPath = 'pubspec.yaml.stub';

const String kAppMobileTemplatePubspecYamlStubContent = '''
name: {{packageName}}
description: {{packageDescription}}
publish_to: 'none'
version: 0.1.0

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  equatable: ^2.0.5
  flex_color_scheme: ^8.0.0
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  freezed_annotation: ^2.4.4
  go_router: ^14.4.1
  json_annotation: ^4.9.0
  package_info_plus: ^8.1.1
  riverpod_annotation: ^2.6.1
  shared_preferences: ^2.3.3
  supercharged: ^2.1.1
  talker_flutter: ^4.4.1

dev_dependencies:
  build_runner: ^2.4.13
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  freezed: ^2.5.7
  go_router_builder: ^2.7.1
  json_serializable: ^6.8.0
  mockito: ^5.4.4
  riverpod_generator: ^2.6.2
  riverpod_lint: ^2.6.2

flutter:
  uses-material-design: true

''';

// --------------------------------------------------

// -------- READMEMdStub Template Data ----------

const String kAppMobileTemplateREADMEMdStubPath = 'README.md.stub';

const String kAppMobileTemplateREADMEMdStubContent = '''
# {{packageName}}

{{packageDescription}}
''';

// --------------------------------------------------

// -------- DolphinJsonStub Template Data ----------

const String kAppMobileTemplateDolphinJsonStubPath = 'dolphin.json.stub';

const String kAppMobileTemplateDolphinJsonStubContent = '''
{
    "bottom_sheets_path": "presentation",
    "dialogs_path": "presentation",
    "line_length": 80,
    "services_path": "services",
    "dolphin_app_file_path": "app/app.dart",
    "views_path": "presentation",
    "widgets_path": "presentation"
}
''';

// --------------------------------------------------

// -------- IntJsonStub Template Data ----------

const String kAppMobileTemplateIntJsonStubPath = '.env/int.json.stub';

const String kAppMobileTemplateIntJsonStubContent = '''
{
  "PROD": false
}

''';

// --------------------------------------------------

// -------- Main Template Data ----------

const String kAppMobileTemplateMainPath = 'lib/main.dart.stub';

const String kAppMobileTemplateMainContent = '''
// Do not remove or change this comment
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:{{packageName}}/app/app.dart';
import 'package:{{packageName}}/app/common/services/package_info_service.dart';
import 'package:{{packageName}}/app/common/services/shared_perferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();
  runApp(
    ProviderScope(
      overrides: [
        sharedPerferencesServiceProvider.overrideWithValue(sharedPreferences),
        packageInfoProvider.overrideWithValue(packageInfo),
      ],
      child: const MainApp(),
    ),
  );
}



''';

// --------------------------------------------------

// -------- PageState Template Data ----------

const String kAppMobileTemplatehomePageStatePath =
    'lib/app/home/state/page_state.dart.stub';

const String kAppMobileTemplatehomePageStateContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_state.freezed.dart';

@freezed
class HomePageState with _\$HomePageState {
  const factory HomePageState({
    required int counter,
  }) = _HomePageState;
}

''';

// --------------------------------------------------

// -------- PageNotifier Template Data ----------

const String kAppMobileTemplatehomePageNotifierPath =
    'lib/app/home/notifiers/page_notifier.dart.stub';

const String kAppMobileTemplatehomePageNotifierContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/home/state/page_state.dart';

part 'page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _\$HomePageNotifier {
  @override
  HomePageState build() {
    return const HomePageState(counter: 0);
  }

  void incrementCounter() {
    state = state.copyWith(counter: state.counter + 1);
  }
}

''';

// --------------------------------------------------

// -------- Page Template Data ----------

const String kAppMobileTemplatehomePagePath =
    'lib/app/home/presentation/page.dart.stub';

const String kAppMobileTemplatehomePageContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{packageName}}/app/home/notifiers/page_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageState = ref.watch(homePageNotifierProvider);
    final notifier = ref.watch(homePageNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, Dolphin!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.onPrimary,
                onPressed: notifier.incrementCounter,
                child: Text(
                  homePageState.counter.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------

// -------- PageNotifier Template Data ----------

const String kAppMobileTemplatesplashPageNotifierPath =
    'lib/app/splash/notifiers/page_notifier.dart.stub';

const String kAppMobileTemplatesplashPageNotifierContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supercharged/supercharged.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_router.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_routes.dart';


part 'page_notifier.g.dart';

@riverpod
class SplashPageNotifier extends _\$SplashPageNotifier {
  @override
  void build() {
    return;
  }

  Future<void> runStartUpLogic() async {
    await 3.seconds.delay;

    ref.read(navigatorProvider).goNamed(HomePageRoute.name);
  }
}

''';

// --------------------------------------------------

// -------- Page Template Data ----------

const String kAppMobileTemplatesplashPagePath =
    'lib/app/splash/presentation/page.dart.stub';

const String kAppMobileTemplatesplashPageContent = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{packageName}}/app/splash/notifiers/page_notifier.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.watch(splashPageNotifierProvider.notifier).runStartUpLogic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Text(
              'Hello, Dolphin!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------

// -------- Page Template Data ----------

const String kAppMobileTemplatedeveloper_menuPagePath =
    'lib/app/developer_menu/presentation/page.dart.stub';

const String kAppMobileTemplatedeveloper_menuPageContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{packageName}}/app/common/presentation/logger_view.dart';

class DeveloperMenuPage extends ConsumerWidget {
  const DeveloperMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Developer Menu',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: PageView(
        children: const [
          LoggerView(),
        ],
      ),
    );
  }
}

''';

// --------------------------------------------------

// -------- ThemeModeNotifier Template Data ----------

const String kAppMobileTemplatecommonThemeModeNotifierPath =
    'lib/app/common/notifiers/theme_mode_notifier.dart.stub';

const String kAppMobileTemplatecommonThemeModeNotifierContent = '''
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/common/services/shared_perferences_service.dart';

part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _\$ThemeModeNotifier {
  final _sharedPrefKey = 'theme_mode';

  @override
  ThemeMode build() {
    final savedTheme =
        ref.read(sharedPerferencesServiceProvider).getString(_sharedPrefKey);
    try {
      if (savedTheme == null) return ThemeMode.system;
      return ThemeMode.values.byName(savedTheme);
    } catch (e) {
      return ThemeMode.system;
    }
  }

  void updateThemeMode(ThemeMode mode) {
    state = mode;
    ref
        .read(sharedPerferencesServiceProvider)
        .setString(_sharedPrefKey, mode.name);
  }
}

''';

// --------------------------------------------------

// -------- LoggerView Template Data ----------

const String kAppMobileTemplatecommonLoggerViewPath =
    'lib/app/common/presentation/logger_view.dart.stub';

const String kAppMobileTemplatecommonLoggerViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:{{packageName}}/app/common/services/logger_service.dart';

class LoggerView extends ConsumerWidget {
  const LoggerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.watch(loggerServiceProvider);
    return TalkerScreen(
      talker: logger,
      itemsBuilder: (context, data) {
        return TalkerDataCard(
          data: data,
          color: {
            LogLevel.critical: Colors.red,
            LogLevel.error: Colors.redAccent,
            LogLevel.info: Colors.cyan,
            LogLevel.warning: Colors.yellow,
            LogLevel.debug: Colors.blue,
            LogLevel.verbose: Colors.grey,
          }[data.logLevel]!,
        );
      },
      appBarTitle: 'Logs',
    );
  }
}

''';

// --------------------------------------------------

// -------- LoggerService Template Data ----------

const String kAppMobileTemplatecommonLoggerServicePath =
    'lib/app/common/services/logger_service.dart.stub';

const String kAppMobileTemplatecommonLoggerServiceContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'logger_service.g.dart';

@Riverpod(keepAlive: true)
Talker loggerService(Ref ref) {
  return TalkerFlutter.init(
    logger: TalkerLogger(
      filter: const LogLevelTalkerLoggerFilter(LogLevel.debug),
      formatter: const ColoredLoggerFormatter(),
      settings: TalkerLoggerSettings(
        maxLineWidth: 20,
        colors: {
          LogLevel.critical: AnsiPen()..red(),
          LogLevel.error: AnsiPen()..magenta(),
          LogLevel.info: AnsiPen()..cyan(),
          LogLevel.warning: AnsiPen()..yellow(),
          LogLevel.debug: AnsiPen()..blue(),
          LogLevel.verbose: AnsiPen()..gray(),
        },
        enableColors: true,
      ),
    ),
  );
}

class LogLevelTalkerLoggerFilter implements LoggerFilter {
  const LogLevelTalkerLoggerFilter(this.logLevel);

  final LogLevel logLevel;

  /// List of levels sorted by priority
  final logLevelPriorityList = const [
    LogLevel.critical,
    LogLevel.error,
    LogLevel.warning,
    LogLevel.info,
    LogLevel.debug,
    LogLevel.verbose,
  ];

  @override
  bool shouldLog(dynamic msg, LogLevel level) {
    final currLogLevelIndex = logLevelPriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logLevelPriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}

''';

// --------------------------------------------------

// -------- PackageInfoService Template Data ----------

const String kAppMobileTemplatecommonPackageInfoServicePath =
    'lib/app/common/services/package_info_service.dart.stub';

const String kAppMobileTemplatecommonPackageInfoServiceContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_service.g.dart';

@Riverpod(keepAlive: true)
PackageInfo packageInfo(Ref _) => throw UnimplementedError();

''';

// --------------------------------------------------

// -------- EnvironmentConfigService Template Data ----------

const String kAppMobileTemplatecommonEnvironmentConfigServicePath =
    'lib/app/common/services/environment_config_service.dart.stub';

const String kAppMobileTemplatecommonEnvironmentConfigServiceContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment_config_service.g.dart';

@Riverpod(keepAlive: true)
EnvironmentConfigService environmentConfig(Ref ref) {
  return EnvironmentConfigService();
}

class EnvironmentConfigService {
  // EnvironmentConfigService - variables
}

''';

// --------------------------------------------------

// -------- SharedPerferencesService Template Data ----------

const String kAppMobileTemplatecommonSharedPerferencesServicePath =
    'lib/app/common/services/shared_perferences_service.dart.stub';

const String kAppMobileTemplatecommonSharedPerferencesServiceContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_perferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPerferencesService(Ref ref) {
  throw UnimplementedError();
}

''';

// --------------------------------------------------

// -------- App Template Data ----------

const String kAppMobileTemplatelibAppPath = 'lib/app/app.dart.stub';

const String kAppMobileTemplatelibAppContent = '''
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName}}/app/common/notifiers/theme_mode_notifier.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_router.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: FlexThemeData.light(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
      ),
      themeMode: ref.watch(themeModeNotifierProvider),
      routerConfig: ref.watch(navigatorProvider),
      builder: (context, child) {
        return _VersionOverlay(
          child: child!,
        );
      },
    );
  }
}

class _VersionOverlay extends ConsumerWidget {
  final Widget child;

  const _VersionOverlay({
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (kDebugMode)
          SafeArea(
            child: Align(
              alignment: const Alignment(1, -0.95),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final router = ref.read(navigatorProvider);
                    final lastMatch =
                        router.routerDelegate.currentConfiguration.last;
                    final matchList = lastMatch is ImperativeRouteMatch
                        ? lastMatch.matches
                        : router.routerDelegate.currentConfiguration;
                    final String location = matchList.uri.toString();
                    if (!location.contains(DeveloperMenuPageRoute.name)) {
                      router.pushNamed(DeveloperMenuPageRoute.name);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: ColoredBox(
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          child: Text(
                            'Dev',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

''';

// --------------------------------------------------

// -------- AppRoutes Template Data ----------

const String kAppMobileTemplateroutesAppRoutesPath =
    'lib/app/routes/notifiers/app_routes.dart.stub';

const String kAppMobileTemplateroutesAppRoutesContent = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// View routes imports
import 'package:{{packageName}}/app/developer_menu/presentation/page.dart';
import 'package:{{packageName}}/app/home/presentation/page.dart';
import 'package:{{packageName}}/app/splash/presentation/page.dart';


part 'app_routes.g.dart';

@TypedGoRoute<HomePageRoute>(
  path: HomePageRoute.path,
  name: HomePageRoute.name,
  routes: [
    // Other routes nested under the home route
  ],
)
class HomePageRoute extends GoRouteData {
  static const path = '/';
  static const name = 'home';
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

// Other routes definations

@TypedGoRoute<SplashPageRoute>(
  path: SplashPageRoute.path,
  name: SplashPageRoute.name,
)
class SplashPageRoute extends GoRouteData {
  static const path = '/splash';
  static const name = 'splash';
  const SplashPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<DeveloperMenuPageRoute>(
  path: DeveloperMenuPageRoute.path,
  name: DeveloperMenuPageRoute.name,
)
class DeveloperMenuPageRoute extends GoRouteData {
  static const path = '/developerMenu';
  static const name = 'developerMenu';
  const DeveloperMenuPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeveloperMenuPage();
}

''';

// --------------------------------------------------

// -------- AppRouter Template Data ----------

const String kAppMobileTemplateroutesAppRouterPath =
    'lib/app/routes/notifiers/app_router.dart.stub';

const String kAppMobileTemplateroutesAppRouterContent = '''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_router.dart';
import 'package:{{packageName}}/app/routes/observers/analytics_observer.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter navigator(Ref ref) {
  final router = ref.watch(routerNotifierProvider.notifier);

  List<NavigatorObserver>? observers = [
    DolphinAnalyticsNavigatorObserver(),
  ];

  return GoRouter(
    observers: observers,
    navigatorKey: appNavigatorKey,
    initialLocation: SplashPageRoute.path,
    refreshListenable: router,
    routes: router.routes,
    debugLogDiagnostics: kDebugMode,
  );
}

@riverpod
class RouterNotifier extends _\$RouterNotifier implements Listenable {
  List<RouteBase> get routes => \$appRoutes;

  @override
  void build() {}

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
''';

// --------------------------------------------------

// -------- AnalyticsObserver Template Data ----------

const String kAppMobileTemplateroutesAnalyticsObserverPath =
    'lib/app/routes/observers/analytics_observer.dart.stub';

const String kAppMobileTemplateroutesAnalyticsObserverContent = '''
import 'package:flutter/material.dart';

class DolphinAnalyticsNavigatorObserver extends NavigatorObserver {
  void screenChanged(Route route) {
      if (route.settings.name == null) return;
      Map<String, Object>? parameters;
      if (route.settings.arguments is Map<String, Object>?) {
        parameters = route.settings.arguments as Map<String, Object>?;
      }
      // TODO(dev): Track page analytics here
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    screenChanged(route);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    screenChanged(route);
  }
}
''';

// --------------------------------------------------

// -------- BuildYamlStub Template Data ----------

const String kAppMobileTemplateBuildYamlStubPath = 'build.yaml.stub';

const String kAppMobileTemplateBuildYamlStubContent = '''
targets:
  \$default:
    builders:
      json_serializable:
        generate_for:
          include:
            - lib/app/**/model/*.dart
        options:
          explicit_to_json: true
      freezed:freezed:
        generate_for:
          include:
            - lib/app/**/model/*.dart
            - lib/app/*/state/*_state.dart
      riverpod_generator:
        generate_for:
          include:
            - lib/app/*/notifiers/*.dart
            - lib/app/*/services/*.dart
            - lib/app/routes/**/*.dart
      
''';

// --------------------------------------------------

// -------- LaunchJsonStub Template Data ----------

const String kAppMobileTemplateLaunchJsonStubPath = '.vscode/launch.json.stub';

const String kAppMobileTemplateLaunchJsonStubContent = '''
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "lib/main.dart",
            "args": [
                "--dart-define-from-file",
                ".env/int.json"
            ]
        },
        {
            "name": "Profile",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "program": "lib/main.dart",
            "args": [
                "--dart-define-from-file",
                ".env/int.json"
            ]
        },
    ]
}
''';

// --------------------------------------------------

// -------- SettingsJsonStub Template Data ----------

const String kAppMobileTemplateSettingsJsonStubPath =
    '.vscode/settings.json.stub';

const String kAppMobileTemplateSettingsJsonStubContent = '''
{
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "*.dart": "\${capture}.mobile.dart, \${capture}.tablet.dart, \${capture}.desktop.dart, \${capture}.form.dart, \${capture}.g.dart, \${capture}.freezed.dart, \${capture}.logger.dart, \${capture}.locator.dart, \${capture}.router.dart, \${capture}.dialogs.dart, \${capture}.bottomsheets.dart"
    }
}

''';

// --------------------------------------------------

// -------- GenericWidget Template Data ----------

const String kWidgetEmptyTemplateGenericWidgetPath =
    'presentation/generic_widget.dart.stub';

const String kWidgetEmptyTemplateGenericWidgetContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{widgetName}} extends ConsumerWidget {
  const {{widgetName}}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }
}

''';

// --------------------------------------------------

// -------- SupabaseService Template Data ----------

const String kSupabaseMiniTemplateSupabaseServicePath =
    'supabase_service.dart.stub';

const String kSupabaseMiniTemplateSupabaseServiceContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_service.g.dart';

@Riverpod(keepAlive: true)
SupabaseClient supbaseClient(Ref ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true)
GoTrueClient supabaseAccount(Ref ref) {
  return ref.watch(supbaseClientProvider).auth;
}

@riverpod
SupabaseQueryBuilder supabaseDatabase(Ref ref, {required String tableName}) {
  return ref.watch(supbaseClientProvider).from(tableName);
}

@Riverpod(keepAlive: true)
SupabaseStorageClient supabaseStorage(Ref ref) {
  return ref.watch(supbaseClientProvider).storage;
}

@Riverpod(keepAlive: true)
FunctionsClient supabaseFunctions(Ref ref) {
  return ref.watch(supbaseClientProvider).functions;
}

''';

// --------------------------------------------------

// -------- GenericDialogState Template Data ----------

const String kDialogEmptyTemplateGenericDialogStatePath =
    'state/generic_dialog_state.dart.stub';

const String kDialogEmptyTemplateGenericDialogStateContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{dialogNameSnake}}_dialog_state.freezed.dart';

@freezed
class {{dialogName}}Model with _\${{dialogName}}Model {
  const factory {{dialogName}}Model({
    required int counter,
  }) = _{{dialogName}}Model;
}

''';

// --------------------------------------------------

// -------- GenericDialogNotifier Template Data ----------

const String kDialogEmptyTemplateGenericDialogNotifierPath =
    'notifiers/generic_dialog_notifier.dart.stub';

const String kDialogEmptyTemplateGenericDialogNotifierContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/{{featureName}}/state/{{dialogNameSnake}}_dialog_state.dart';

part '{{dialogNameSnake}}_dialog_notifier.g.dart';

@riverpod
class {{dialogName}}Notifier extends _\${{dialogName}}Notifier {
  @override
  {{dialogName}}Model build() {
    return const {{dialogName}}Model(counter: 0);
  }

  void update(int counter) {
    state = state.copyWith(counter: counter);
  }
}

''';

// --------------------------------------------------

// -------- GenericDialog Template Data ----------

const String kDialogEmptyTemplateGenericDialogPath =
    'presentation/generic_dialog.dart.stub';

const String kDialogEmptyTemplateGenericDialogContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supercharged/supercharged.dart';
import 'package:{{packageName}}/app/{{featureName}}/notifiers/{{dialogNameSnake}}_dialog_notifier.dart';

class {{dialogName}} extends ConsumerWidget {
  const {{dialogName}}({super.key});

  static Future showDialog({required BuildContext context}) {
    const backgroundColor = Color(0xFF1D2732);
    const borderColor = Color(0xFFB9B9B9);
    final height = MediaQuery.sizeOf(context).height * 0.5;
    final width = MediaQuery.sizeOf(context).width * 0.9;
    bool barrierDismissible = true;
    bool showDecoration = true;
    return showGeneralDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierLabel: 'Barrier Label',
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: Container(
                clipBehavior: Clip.none,
                decoration: showDecoration
                    ? BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      )
                    : null,
                child: const {{dialogName}}(),
              ),
            ),
          ),
        );
      },
      transitionDuration: 300.milliseconds,
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeOutBack.transform(a1.value);

        return Transform.scale(
          scale: curve,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter =
        ref.watch({{dialogNotifierName}}.select((value) => value.counter));
    return  Center(
      child: Text('Hello, Dolphin \$counter!'),
    );
  }
}

''';

// --------------------------------------------------

// -------- FirebaseService Template Data ----------

const String kFirebaseMiniTemplateFirebaseServicePath =
    'firebase_service.dart.stub';

const String kFirebaseMiniTemplateFirebaseServiceContent = '''
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_service.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAccount(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseDatabase(Ref ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(Ref ref) {
  return FirebaseStorage.instance;
}

@Riverpod(keepAlive: true)
FirebaseFunctions firebaseFunctions(Ref ref) {
  return FirebaseFunctions.instance;
}

''';

// --------------------------------------------------

// -------- GenericViewState Template Data ----------

const String kViewEmptyTemplateGenericViewStatePath =
    'state/generic_view_state.dart.stub';

const String kViewEmptyTemplateGenericViewStateContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{viewNameSnake}}_state.freezed.dart';

@freezed
class {{viewName}}State with _\${{viewName}}State {
  const factory {{viewName}}State({
    required int counter,
  }) = _{{viewName}}State;
}

''';

// --------------------------------------------------

// -------- GenericViewNotifier Template Data ----------

const String kViewEmptyTemplateGenericViewNotifierPath =
    'notifiers/generic_view_notifier.dart.stub';

const String kViewEmptyTemplateGenericViewNotifierContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/{{featureName}}/state/{{viewNameSnake}}_state.dart';

part '{{viewNameSnake}}_notifier.g.dart';

@riverpod
class {{notifierName}} extends _\${{notifierName}} {
  @override
  {{viewName}}State build() {
    return const {{viewName}}State(counter: 0);
  }

  void incrementCounter() {
    state = state.copyWith(counter: state.counter + 1);
  }
}

''';

// --------------------------------------------------

// -------- GenericView Template Data ----------

const String kViewEmptyTemplateGenericViewPath =
    'presentation/generic_view.dart.stub';

const String kViewEmptyTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{packageName}}/app/{{featureName}}/notifiers/{{viewNameSnake}}_notifier.dart';

class {{viewName}} extends ConsumerWidget {
  const {{viewName}}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch({{notifierProviderName}});
    final notifier = ref.watch({{notifierProviderName}}.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, Dolphin!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.onPrimary,
                onPressed: notifier.incrementCounter,
                child: Text(
                  state.counter.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------

// -------- AppwriteService Template Data ----------

const String kAppwriteMiniTemplateAppwriteServicePath =
    'appwrite_service.dart.stub';

const String kAppwriteMiniTemplateAppwriteServiceContent = '''
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_magic_app/app/common/services/environment_config_service.dart';

part 'appwrite_service.g.dart';

@Riverpod(keepAlive: true)
Client appwriteClient(Ref ref) {
  final envConfig = ref.read(environmentConfigProvider);
  return Client()
      .setEndpoint(envConfig.appwriteEndpoint)
      .setProject(envConfig.appWriteProjectId);
}

@Riverpod(keepAlive: true)
Account appwriteAccount(Ref ref) {
  return Account(ref.watch(appwriteClientProvider));
}

@Riverpod(keepAlive: true)
Databases appwriteDatabase(Ref ref) {
  return Databases(ref.watch(appwriteClientProvider));
}

@Riverpod(keepAlive: true)
Storage appwriteStorage(Ref ref) {
  return Storage(ref.watch(appwriteClientProvider));
}

@Riverpod(keepAlive: true)
Functions appwriteFunctions(Ref ref) {
  return Functions(ref.watch(appwriteClientProvider));
}

''';

// --------------------------------------------------

// -------- GenericService Template Data ----------

const String kServiceEmptyTemplateGenericServicePath =
    'services/generic_service.dart.stub';

const String kServiceEmptyTemplateGenericServiceContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{serviceNameSnake}}_service.g.dart';

@riverpod
{{serviceName}}Service {{providerName}}Service(Ref ref) {
  return {{serviceName}}Service(ref);
}

class {{serviceName}}Service {
  final Ref ref;
  {{serviceName}}Service(this.ref);

  void init() {
    debugPrint('Service init');
  }
}

''';

// --------------------------------------------------

// -------- GenericSheetState Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetStatePath =
    'state/generic_sheet_state.dart.stub';

const String kBottomSheetEmptyTemplateGenericSheetStateContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{sheetNameSnake}}_sheet_state.freezed.dart';

@freezed
class {{sheetName}}Model with _\${{sheetName}}Model {
  const factory {{sheetName}}Model({
    required int counter,
  }) = _{{sheetName}}Model;
}

''';

// --------------------------------------------------

// -------- GenericSheetNotifier Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetNotifierPath =
    'notifiers/generic_sheet_notifier.dart.stub';

const String kBottomSheetEmptyTemplateGenericSheetNotifierContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/{{featureName}}/state/{{sheetNameSnake}}_sheet_state.dart';

part '{{sheetNameSnake}}_sheet_notifier.g.dart';

@riverpod
class {{sheetName}}Notifier extends _\${{sheetName}}Notifier {
  @override
  {{sheetName}}Model build() {
    return const {{sheetName}}Model(counter: 0);
  }

  void update(int counter) {
    state = state.copyWith(counter: counter);
  }
}

''';

// --------------------------------------------------

// -------- GenericSheet Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetPath =
    'presentation/generic_sheet.dart.stub';

const String kBottomSheetEmptyTemplateGenericSheetContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{packageName}}/app/{{featureName}}/notifiers/{{sheetNameSnake}}_sheet_notifier.dart';

class {{sheetName}}Sheet extends ConsumerWidget {
  const {{sheetName}}Sheet({super.key});

  static Future showSheet({required BuildContext context}) {
    bool isDismmissable = true;
    double? height = null;
    bool? isScrollControlled;
    Color? backgroundColor;
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismmissable,
      enableDrag: isDismmissable,
      isScrollControlled: isScrollControlled ?? height != null,
      backgroundColor: backgroundColor ?? const Color(0xFF2E3947),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: height,
            child: const {{sheetName}}Sheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter =
        ref.watch({{sheetNotifierName}}.select((value) => value.counter));
    return  Center(
      child: Text('Hello, Dolphin \$counter!'),
    );
  }
}

''';

// --------------------------------------------------
