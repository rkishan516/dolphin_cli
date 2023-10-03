// ------- Template names --------
const String kTemplateNameApp = 'app';
const String kTemplateNameBottomSheet = 'bottom_sheet';
const String kTemplateNameDialog = 'dialog';
const String kTemplateNameGenerate = 'generate';
const String kTemplateNameService = 'service';
const String kTemplateNameView = 'view';
const String kTemplateNameWidget = 'widget';

// ------- Template Types --------
const String kTemplateTypeEmpty = 'empty';

// ------- File Modification identifiers --------

const String kModificationIdentifierAppImports = '// @dolphin-import';
const String kModificationIdentifierAppRoutes = '// @dolphin-route';
const String kModificationIdentifierAppServices = '// @dolphin-service';
const String kModificationIdentifierServiceMock = '// @dolphin-service-mock';
const String kModificationIdentifierServiceMockHelper =
    '// @dolphin-mock-create';
const String kModificationIdentifierServiceMockHelperRegister =
    '// @dolphin-mock-register';

// ------- Property names for Rendering replacement -------

/// The name of the view class in dart.
/// Given a name 'details' expects viewName to equal DetailsView
const String kTemplatePropertyViewName = 'viewName';
const String kTemplatePropertyViewNameSnake = 'viewNameSnake';

/// The name of the notifier class in dart.
/// Given a name 'details' expects notifierName to equal DetailsNotifier
const String kTemplatePropertyNotifierName = 'notifierName';

/// The name of the notifier class in dart.
/// Given a name 'details' expects notifierProviderName to equal detailsNotifierProvider
const String kTemplatePropertyNotifierProviderName = 'notifierProviderName';

/// The name of the file that the notifier is created in with the dart extension.
/// Given a name 'details' expects notifierFileName to equal details_notifier.dart
const String kTemplatePropertyNotifierFileName = 'notifierFileName';

/// The name of the folder that the view will be created in. This is a snake_case version
/// of the name.
const String kTemplatePropertyViewFolderName = 'viewFolderName';

/// The name of the file that the view is creatde in with the dart extension.
/// Given a name 'details' expects viewFileName to equal `details.dart`
const String kTemplatePropertyViewFileName = 'viewFileName';

const String kTemplatePropertyViewFileNameWithoutExtension =
    'viewFileNameWithoutExtension';

/// The name of the package that the cli tool is running in. This is read from the
/// pubspec.yaml file in the root folder.
const String kTemplatePropertyPackageName = 'packageName';

/// The description of the package.
const String kTemplatePropertyPackageDescription = 'packageDescription';

/// The name of the service class in pascal case
const String kTemplatePropertyServiceName = 'serviceName';

const String kTemplatePropertyRelativeBottomSheetFilePath =
    'relativeBottomSheetFilePath';

const String kTemplatePropertyRelativeDialogFilePath = 'relativeDialogFilePath';

const String kTemplatePropertyRelativeRouterFilePath = 'relativeRouterFilePath';

const String kTemplatePropertyRegisterMocksFunction = 'registerMocksFunction';

const String kTemplatePropertyServiceImportPath = 'serviceImportPath';

const String kTemplatePropertyServiceTestHelpersImport =
    'serviceTestHelpersImport';

const String kTemplatePropertyViewImportPath = 'viewImportPath';

const String kTemplatePropertyViewTestHelpersImport = 'viewTestHelpersImport';

const String kTemplatePropertySheetName = 'sheetName';
const String kTemplatePropertySheetNotifierName = 'sheetNotifierName';

const String kTemplatePropertyDialogName = 'dialogName';
const String kTemplatePropertyDialogNotifierName = 'dialogNotifierName';

const String kTemplatePropertyWidgetName = 'widgetName';

// -------- Compiled Template Structure ---------

const String kTemplateDataStructure = '''
/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.

{{#templateItems}}

// -------- {{fileName}} Template Data ----------

const String k{{name}}{{templateType}}Template{{featureName}}{{fileName}}Path =
    '{{{path}}}';

const String k{{name}}{{templateType}}Template{{featureName}}{{fileName}}Content = \'''
{{{content}}}
\''';

// --------------------------------------------------

{{/templateItems}}
''';

const String kTemplateMapDataStructure = '''
// ignore_for_file: unnecessary_string_escapes

import 'package:dolphin_cli/src/models/template_models.dart';
import 'package:dolphin_cli/src/templates/compiled_templates.dart';

Map<String, Map<String, DolphinTemplate>> kCompiledDolphinTemplates = {
  {{#dolphinTemplates}}
  '{{name}}': {
  {{#templates}}
    '{{type}}': DolphinTemplate(
      templateFiles: [
      {{#files}}
        TemplateFile(
            relativeOutputPath: k{{name}}{{templateType}}Template{{featureName}}{{fileName}}Path,
            content: k{{name}}{{templateType}}Template{{featureName}}{{fileName}}Content,
            fileType: FileType.{{fileType}}),
      {{/files}}
      ],
      modificationFiles: [{{#modificationFiles}}
        ModificationFile(
          relativeModificationPath: '{{{path}}}',
          modificationIdentifier: '{{{identifier}}}',
          modificationTemplate: \'''{{{template}}}\''',
          modificationProblemError: '{{{error}}}',
          modificationName: '{{{name}}}',
        ),
        {{/modificationFiles}}],
    ),
  {{/templates}}
  },
  {{/dolphinTemplates}}
};
''';

const String kTemplateTypesMap = '''
/// NOTE: This is generated code from the compileTemplates command. Do not 
///       modify by hand.
///       This file should be checked into source control.

Map<String, List<String>> kCompiledTemplateTypes = {
  {{#dolphinTemplates}}
  '{{name}}': [
    {{#templates}}
    '{{type}}',
    {{/templates}}
  ],
  {{/dolphinTemplates}}
};
''';
