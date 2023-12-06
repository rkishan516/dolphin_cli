/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.


// -------- DolphinJsonStk Template Data ----------

const String kAppMobileTemplateDolphinJsonStkPath =
    'dolphin.json.stk';

const String kAppMobileTemplateDolphinJsonStkContent = '''
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


// -------- BuildYamlStk Template Data ----------

const String kAppMobileTemplateBuildYamlStkPath =
    'build.yaml.stk';

const String kAppMobileTemplateBuildYamlStkContent = '''
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


// -------- READMEMdStk Template Data ----------

const String kAppMobileTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppMobileTemplateREADMEMdStkContent = '''
# {{packageName}}

{{packageDescription}}
''';

// --------------------------------------------------


// -------- Main Template Data ----------

const String kAppMobileTemplateMainPath =
    'lib/main.dart.stk';

const String kAppMobileTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}



''';

// --------------------------------------------------


// -------- App Template Data ----------

const String kAppMobileTemplatelibAppPath =
    'lib/app/app.dart.stk';

const String kAppMobileTemplatelibAppContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(navigatorProvider),
    );
  }
}
''';

// --------------------------------------------------


// -------- PageState Template Data ----------

const String kAppMobileTemplatehomePageStatePath =
    'lib/app/home/state/page_state.dart.stk';

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
    'lib/app/home/notifiers/page_notifier.dart.stk';

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
    'lib/app/home/presentation/page.dart.stk';

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
              const Text(
                'Hello, Dolphin!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.black,
                onPressed: notifier.incrementCounter,
                child: Text(
                  homePageState.counter.toString(),
                  style: const TextStyle(color: Colors.white),
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
    'lib/app/splash/notifiers/page_notifier.dart.stk';

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
    'lib/app/splash/presentation/page.dart.stk';

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
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello, Dolphin!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- AppRouter Template Data ----------

const String kAppMobileTemplateroutesAppRouterPath =
    'lib/app/routes/notifiers/app_router.dart.stk';

const String kAppMobileTemplateroutesAppRouterContent = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName}}/app/home/presentation/page.dart';
import 'package:{{packageName}}/app/splash/presentation/page.dart';

part 'app_router.g.dart';

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
''';

// --------------------------------------------------


// -------- AppRoutes Template Data ----------

const String kAppMobileTemplateroutesAppRoutesPath =
    'lib/app/routes/notifiers/app_routes.dart.stk';

const String kAppMobileTemplateroutesAppRoutesContent = '''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{packageName}}/app/routes/notifiers/app_router.dart';

part 'app_routes.g.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter navigator(NavigatorRef ref) {
  final router = ref.watch(routerNotifierProvider.notifier);

  List<NavigatorObserver>? observers = [];

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


// -------- PubspecYamlStk Template Data ----------

const String kAppMobileTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppMobileTemplatePubspecYamlStkContent = '''
name: {{packageName}}
description: {{packageDescription}}
publish_to: 'none'
version: 0.1.0

environment:
  sdk: '>=3.0.3 <4.0.0'

dependencies:
  equatable: ^2.0.5
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  freezed_annotation: ^2.4.1
  go_router: ^12.1.1
  json_annotation: ^4.8.1
  riverpod_annotation: ^2.1.5
  supercharged: ^2.1.1
  talker_flutter: ^3.3.0

dev_dependencies:
  build_runner: ^2.4.6
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  freezed: ^2.4.1
  go_router_builder: ^2.3.2
  json_serializable: ^6.7.1
  mockito: ^5.4.1
  riverpod_generator: ^2.3.2
  riverpod_lint: ^2.0.4

flutter:
  uses-material-design: true

''';

// --------------------------------------------------


// -------- SettingsJsonStk Template Data ----------

const String kAppMobileTemplateSettingsJsonStkPath =
    '.vscode/settings.json.stk';

const String kAppMobileTemplateSettingsJsonStkContent = '''
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
    'presentation/generic_widget.dart.stk';

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


// -------- GenericDialogState Template Data ----------

const String kDialogEmptyTemplateGenericDialogStatePath =
    'state/generic_dialog_state.dart.stk';

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
    'notifiers/generic_dialog_notifier.dart.stk';

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
    'presentation/generic_dialog.dart.stk';

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


// -------- GenericViewState Template Data ----------

const String kViewEmptyTemplateGenericViewStatePath =
    'state/generic_view_state.dart.stk';

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
    'notifiers/generic_view_notifier.dart.stk';

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
    'presentation/generic_view.dart.stk';

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
              const Text(
                'Hello, Dolphin!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.black,
                onPressed: notifier.incrementCounter,
                child: Text(
                  state.counter.toString(),
                  style: const TextStyle(color: Colors.white),
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


// -------- GenericService Template Data ----------

const String kServiceEmptyTemplateGenericServicePath =
    'services/generic_service.dart.stk';

const String kServiceEmptyTemplateGenericServiceContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{serviceNameSnake}}_service.g.dart';

@riverpod
{{serviceName}}Service {{providerName}}Service({{serviceName}}ServiceRef ref) {
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
    'state/generic_sheet_state.dart.stk';

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
    'notifiers/generic_sheet_notifier.dart.stk';

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
    'presentation/generic_sheet.dart.stk';

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

