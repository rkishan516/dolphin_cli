// ignore_for_file: unnecessary_string_escapes

import 'package:dolphin_cli/src/models/template_models.dart';
import 'package:dolphin_cli/src/templates/compiled_templates.dart';

Map<String, Map<String, DolphinTemplate>> kCompiledDolphinTemplates = {
  'app': {
    'mobile': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateDolphinJsonStkPath,
            content: kAppMobileTemplateDolphinJsonStkContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateBuildYamlStkPath,
            content: kAppMobileTemplateBuildYamlStkContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateREADMEMdStkPath,
            content: kAppMobileTemplateREADMEMdStkContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateMainPath,
            content: kAppMobileTemplateMainContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatelibAppPath,
            content: kAppMobileTemplatelibAppContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatehomePageStatePath,
            content: kAppMobileTemplatehomePageStateContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatehomePageNotifierPath,
            content: kAppMobileTemplatehomePageNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatehomePagePath,
            content: kAppMobileTemplatehomePageContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatesplashPageNotifierPath,
            content: kAppMobileTemplatesplashPageNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatesplashPagePath,
            content: kAppMobileTemplatesplashPageContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatedeveloper_menuPagePath,
            content: kAppMobileTemplatedeveloper_menuPageContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatecommonThemeModeNotifierPath,
            content: kAppMobileTemplatecommonThemeModeNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatecommonLoggerViewPath,
            content: kAppMobileTemplatecommonLoggerViewContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatecommonPackageInfoServicePath,
            content: kAppMobileTemplatecommonPackageInfoServiceContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath:
                kAppMobileTemplatecommonEnvironmentConfigServicePath,
            content: kAppMobileTemplatecommonEnvironmentConfigServiceContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatecommonLoggerServicePath,
            content: kAppMobileTemplatecommonLoggerServiceContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath:
                kAppMobileTemplatecommonSharedPerferencesServicePath,
            content: kAppMobileTemplatecommonSharedPerferencesServiceContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateroutesAppRouterPath,
            content: kAppMobileTemplateroutesAppRouterContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateroutesAppRoutesPath,
            content: kAppMobileTemplateroutesAppRoutesContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateroutesAnalyticsObserverPath,
            content: kAppMobileTemplateroutesAnalyticsObserverContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplatePubspecYamlStkPath,
            content: kAppMobileTemplatePubspecYamlStkContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kAppMobileTemplateSettingsJsonStkPath,
            content: kAppMobileTemplateSettingsJsonStkContent,
            fileType: FileType.text),
      ],
      modificationFiles: [],
    ),
  },
  'widget': {
    'empty': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kWidgetEmptyTemplateGenericWidgetPath,
            content: kWidgetEmptyTemplateGenericWidgetContent,
            fileType: FileType.text),
      ],
      modificationFiles: [],
    ),
  },
  'dialog': {
    'empty': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogStatePath,
            content: kDialogEmptyTemplateGenericDialogStateContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogNotifierPath,
            content: kDialogEmptyTemplateGenericDialogNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogPath,
            content: kDialogEmptyTemplateGenericDialogContent,
            fileType: FileType.text),
      ],
      modificationFiles: [],
    ),
  },
  'view': {
    'empty': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewStatePath,
            content: kViewEmptyTemplateGenericViewStateContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewNotifierPath,
            content: kViewEmptyTemplateGenericViewNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewPath,
            content: kViewEmptyTemplateGenericViewContent,
            fileType: FileType.text),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: '../routes/notifiers/app_router.dart',
          modificationIdentifier: '// Other routes nested under the home route',
          modificationTemplate: '''TypedGoRoute<{{viewName}}PageRoute>(
path: {{viewName}}PageRoute.path,
name: {{viewName}}PageRoute.name,
),''',
          modificationProblemError: 'Adding view to route failed',
          modificationName: 'Add view to route',
        ),
        ModificationFile(
          relativeModificationPath: '../routes/notifiers/app_router.dart',
          modificationIdentifier: '// Other routes definations',
          modificationTemplate:
              '''class {{viewName}}PageRoute extends GoRouteData {
static const path = '{{viewName}}';
static const name = '{{viewName}}';
const {{viewName}}PageRoute();
@override
Widget build(BuildContext context, GoRouterState state) => const {{viewName}}();
}''',
          modificationProblemError: 'Adding route defination for view failed',
          modificationName: 'Add route defination for view',
        ),
        ModificationFile(
          relativeModificationPath: '../routes/notifiers/app_router.dart',
          modificationIdentifier: '// View routes imports',
          modificationTemplate:
              '''import 'package:{{packageName}}/app/{{featureName}}/presentation/{{viewNameSnake}}.dart';''',
          modificationProblemError: 'Import for view in app routes failed',
          modificationName: 'Add import for view in app routes',
        ),
      ],
    ),
  },
  'appwrite': {
    'mini': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kAppwriteMiniTemplateAppwriteServicePath,
            content: kAppwriteMiniTemplateAppwriteServiceContent,
            fileType: FileType.text),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: 'environment_config_service.dart',
          modificationIdentifier: '// EnvironmentConfigService - variables',
          modificationTemplate:
              '''final appwriteEndpoint = String.fromEnvironment('APPWRITE_ENDPOINT', defaultValue: 'https://localhost/v1'); final appWriteProjectId = String.fromEnvironment('APPWRITE_PROJECT_ID',);''',
          modificationProblemError:
              'The environment config generation failed for app write',
          modificationName: 'Add appwrite environemnt config',
        ),
      ],
    ),
  },
  'service': {
    'empty': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kServiceEmptyTemplateGenericServicePath,
            content: kServiceEmptyTemplateGenericServiceContent,
            fileType: FileType.text),
      ],
      modificationFiles: [],
    ),
  },
  'bottom_sheet': {
    'empty': DolphinTemplate(
      templateFiles: [
        TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetStatePath,
            content: kBottomSheetEmptyTemplateGenericSheetStateContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath:
                kBottomSheetEmptyTemplateGenericSheetNotifierPath,
            content: kBottomSheetEmptyTemplateGenericSheetNotifierContent,
            fileType: FileType.text),
        TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetPath,
            content: kBottomSheetEmptyTemplateGenericSheetContent,
            fileType: FileType.text),
      ],
      modificationFiles: [],
    ),
  },
};
