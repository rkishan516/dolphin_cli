import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value,
    {String? featureName});

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertyViewName: '${value.pascalCase}View',
      kTemplatePropertyViewNameSnake: '${value.snakeCase}_view',
      kTemplatePropertyViewFileName: '${value.snakeCase}.dart',
      kTemplatePropertyViewFileNameWithoutExtension: '${value.snakeCase}_view',
      kTemplatePropertyNotifierName: '${value.pascalCase}Notifier',
      kTemplatePropertyNotifierProviderName:
          '${value.camelCase}NotifierProvider',
      kTemplatePropertyNotifierFileName: '${value.snakeCase}_notifier.dart',
      kTemplatePropertyViewFolderName: value.snakeCase,
      'featureName': featureName ?? 'home'
    };
  },
  kTemplateNameService: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertyServiceName: value.pascalCase,
      'serviceNameSnake': value.snakeCase,
      'providerName': value.camelCase,
      'featureName': featureName ?? 'home',
    };
  },
  kTemplateNameApp: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertyRelativeBottomSheetFilePath: getFilePath(
        builder: 'bottomsheets',
      ),
      kTemplatePropertyRelativeDialogFilePath: getFilePath(builder: 'dialogs'),
      kTemplatePropertyRelativeRouterFilePath: getFilePath(builder: 'router'),
    };
  },
  kTemplateNameBottomSheet: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertySheetName: '${value.pascalCase}Sheet',
      'sheetNameSnake': value.snakeCase,
      kTemplatePropertySheetNotifierName:
          '${value.camelCase}SheetNotifierProvider',
      'featureName': featureName ?? 'home',
    };
  },
  kTemplateNameDialog: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertyDialogName: '${value.pascalCase}Dialog',
      'dialogNameSnake': value.snakeCase,
      kTemplatePropertyDialogNotifierName:
          '${value.camelCase}DialogNotifierProvider',
      'featureName': featureName ?? 'home',
    };
  },
  kTemplateNameWidget: (
    ReCase value, {
    String? featureName,
  }) {
    return {
      kTemplatePropertyWidgetName: value.pascalCase,
    };
  },
  kTemplateNameAppWrite: (
    ReCase value, {
    String? featureName,
  }) {
    return {};
  },
  kTemplateNameFirebase: (
    ReCase value, {
    String? featureName,
  }) {
    return {};
  },
  kTemplateNameSupabase: (
    ReCase value, {
    String? featureName,
  }) {
    return {};
  },
};

/// Returns file path of the [builder]
@visibleForTesting
String getFilePath({required String builder}) {
  final path = configService.dolphinAppFilePath
      .replaceFirst('lib/', '')
      .split('.')
    ..insert(1, builder);

  return path.join('.');
}
