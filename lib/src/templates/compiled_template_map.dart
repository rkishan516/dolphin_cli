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
            relativeOutputPath: kAppMobileTemplatecommonSharedPerferencesServicePath,
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
      modificationFiles: [],
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
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetNotifierPath,
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
