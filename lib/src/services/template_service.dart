import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/exceptions/invalid_dolphin_structure_exception.dart';
import 'package:dolphin_cli/src/models/template_models.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/templates/compiled_template_map.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:dolphin_cli/src/templates/template_helper.dart';
import 'package:dolphin_cli/src/templates/template_render_functions.dart';
import 'package:mustache_template/mustache_template.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:scoped_zone/scoped_zone.dart';

/// A reference to a [TemplateService] instance.
final templateServiceRef = create(TemplateService.new);

/// The [TemplateService] instance available in the current zone.
TemplateService get templateService => read(templateServiceRef);

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  /// Reads the template folder and creates the dart code that will be used to
  /// generate the templates
  Future<void> compileTemplateInformation() async {
    final templatesPath = templateHelper.templatesPath;

    final dolphinTemplateFolderPaths = await fileService.getFoldersInDirectory(
      directoryPath: templatesPath,
    );

    final dolphinTemplates = <CompiledCreateCommand>[];
    final allTemplateItems = <CompliledTemplateFile>[];

    for (final dolphinTemplateFolderPath in dolphinTemplateFolderPaths) {
      final templateName = templateHelper.getTemplateFolderName(
        templateFilePath: dolphinTemplateFolderPath,
      );

      final templateTypes = await templateHelper.getTemplateTypesFromTemplate(
        templateDirectoryPath: dolphinTemplateFolderPath,
      );

      var compiledCreateCommand = CompiledCreateCommand(
        name: templateName,
        templates: [],
      );

      for (var templateType in templateTypes) {
        final templateItemsToRender = await templateHelper
            .getTemplateItemsToRender(
              templateName: templateName,
              templateType: templateType,
            );

        allTemplateItems.addAll(templateItemsToRender);

        final templateModificationsToApply = await templateHelper
            .getTemplateModificationsToApply(
              templateName: templateName,
              templateType: templateType,
            );

        compiledCreateCommand = compiledCreateCommand.copyWith(
          templates: [
            ...compiledCreateCommand.templates,
            CompiledTemplate(
              type: templateType,
              files: templateItemsToRender,
              modificationFiles: templateModificationsToApply,
            ),
          ],
        );
      }

      dolphinTemplates.add(compiledCreateCommand);
    }

    final outputTemplate = Template(kTemplateDataStructure);
    final templateItemsData = {
      'templateItems': allTemplateItems.map((e) => e.toJson()).toList(),
    };

    final allTemplateItemsContent = outputTemplate.renderString(
      templateItemsData,
    );

    await fileService.writeStringFile(
      file: File(path.join(templatesPath, 'compiled_templates.dart')),
      fileContent: allTemplateItemsContent,
    );

    final templateMap = Template(kTemplateMapDataStructure);
    final templateMapData = {
      'dolphinTemplates': dolphinTemplates.map((e) => e.toJson()).toList(),
    };

    final templateMapContent = templateMap.renderString(templateMapData);
    await fileService.writeStringFile(
      file: File(path.join(templatesPath, 'compiled_template_map.dart')),
      fileContent: templateMapContent,
    );

    await _createTemplateTypesConstantMap(
      templatesPath: templatesPath,
      dolphinTemplates: dolphinTemplates,
    );
  }

  /// Using the [templateName] this function will write out the template
  /// files in the directory the cli is currently running.
  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    required String name,

    /// When value is true, should log on stdout what is happening during command execution.
    bool verbose = false,

    /// When set to true the newly generated view will not be added to the app.dart file
    bool excludeRoute = false,

    /// When the value is true, the bottom sheet or dialog will extends from ConsumerWidget
    /// to use a model which will be also created.
    bool hasModel = true,

    /// When supplied the templates will be created using the folder supplied here as the
    /// output location.
    ///
    /// i.e. When the template writes too lib/ui/view.dart if output path is playground
    /// the final output path will be playground/lib/ui/view.dart
    String? outputPath,

    /// When supplied the templates will be created using the folder supplied here as the
    /// output location.
    String? featureName,

    /// When supplied it selects the template type to use within the command that's being
    /// run. This is supplied using --template=web or similar based on the command being run
    required String templateType,
  }) async {
    // Get the template that we want to render
    final template =
        kCompiledDolphinTemplates[templateName]![templateType] ??
        DolphinTemplate(templateFiles: []);

    await writeOutTemplateFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputFolder: outputPath,
      featureName: featureName,
      hasModel: hasModel,
    );

    if (templateName == kTemplateNameView && excludeRoute) {
      return;
    }

    await modifyExistingFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputPath: outputPath,
      featureName: featureName,
    );
  }

  Future<void> writeOutTemplateFiles({
    required DolphinTemplate template,
    required String templateName,
    required String name,
    String? outputFolder,
    String? featureName,
    bool hasModel = true,
  }) async {
    /// Sort template files to ensure default view will be always after v1 view.
    template.templateFiles.sort(
      (a, b) => b.relativeOutputPath.compareTo(a.relativeOutputPath),
    );

    for (var i = 0; i < template.templateFiles.length; i++) {
      final templateFile = template.templateFiles[i];

      const templatesAllowed = ['bottom_sheet', 'dialog', 'widget'];
      if (templatesAllowed.any((template) => template == templateName)) {
        if (!hasModel && templateFile.relativeOutputPath.contains('model')) {
          continue;
        }
      }

      final templateContent = templateFile.fileType == FileType.text
          ? renderContentForTemplate(
              content: templateFile.content,
              templateName: templateName,
              name: name,
              featureName: featureName,
            )
          : base64Decode(templateFile.content.trim().replaceAll('\n', ''));

      final templateFileOutputPath = getTemplateOutputPath(
        inputTemplatePath: templateFile.relativeOutputPath,
        name: name,
        outputFolder: outputFolder,
      );

      if (templateFile.fileType == FileType.text) {
        await fileService.writeStringFile(
          file: File(templateFileOutputPath),
          fileContent: templateContent as String,
          forceAppend: false,
          verbose: true,
        );
      } else {
        await fileService.writeDataFile(
          file: File(templateFileOutputPath),
          fileContent: templateContent as Uint8List,
          forceAppend: false,
          verbose: true,
        );
      }
    }
  }

  /// Returns the output path for the file given the input path of the template
  String getTemplateOutputPath({
    required String inputTemplatePath,
    required String name,
    String? outputFolder,
  }) {
    final hasOutputFolder = outputFolder != null;
    final recaseName = ReCase(name);
    final modifiedOutputPath = configService
        .replaceCustomPaths(inputTemplatePath)
        .replaceAll('generic', recaseName.snakeCase)
        .replaceFirst('.stub', '');

    if (hasOutputFolder) {
      return path.join(outputFolder, modifiedOutputPath);
    }

    return modifiedOutputPath;
  }

  /// Takes in a templated string [content] and builds the template data
  /// to use when rendering
  String renderContentForTemplate({
    required String content,
    required String templateName,
    required String name,
    String? featureName,
  }) {
    var viewTemplate = Template(content, lenient: true);

    final renderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
      featureName: featureName,
    );

    return viewTemplate.renderString(renderData);
  }

  /// Returns a render data map from the [template_render_functions.dart] file with map
  Map<String, String> getTemplateRenderData({
    required String templateName,
    required String name,
    String? featureName,

    /// This value is only for testing
    Map<String, RenderFunction>? testRenderFunctions,
  }) {
    final nameRecase = ReCase(name);

    final renderFunction = testRenderFunctions != null
        ? testRenderFunctions[templateName]
        : renderFunctions[templateName];

    if (renderFunction == null) {
      throw Exception(
        'No render function has been defined for the template $templateName. Please define a render function before running the command again.',
      );
    }

    Map<String, String> renderDataForTemplate = renderFunction(
      nameRecase,
      featureName: featureName,
    );

    final packageName = templateName == kTemplateNameApp ? name : null;

    return applyGlobalTemplateProperties(
      renderDataForTemplate,
      packageName: packageName,
    );
  }

  Map<String, String> applyGlobalTemplateProperties(
    Map<String, String> renderTemplate, {
    String? packageName,
  }) {
    return {
      ...renderTemplate,
      // All template data will have the values added below
      kTemplatePropertyPackageDescription: templateHelper.packageDescription,
      kTemplatePropertyPackageName:
          packageName ?? pubspecService.getPackageName,
      kTemplatePropertyServiceImportPath: configService.serviceImportPath,
      kTemplatePropertyViewImportPath: configService.viewImportPath,
    };
  }

  Future<void> modifyExistingFiles({
    required DolphinTemplate template,
    required String templateName,
    required String name,
    String? outputPath,
    String? featureName,
  }) async {
    final hasOutputPath = outputPath != null;
    for (final fileToModify in template.modificationFiles) {
      final customRelativeModificationPath = configService.replaceCustomPaths(
        fileToModify.relativeModificationPath,
      );
      final modificationPath = hasOutputPath
          ? path.join(outputPath, customRelativeModificationPath)
          : customRelativeModificationPath;

      final fileExists = await fileService.fileExists(
        filePath: modificationPath,
      );

      if (!fileExists) {
        logger.warn(
          'Modification not applied. The file $modificationPath does not exist',
        );
        throw InvalidDolphinStructureException(kInvalidDolphinStructureAppFile);
      }

      final fileContent = await fileService.readFileAsString(
        filePath: modificationPath,
      );

      if (!fileContent.contains(fileToModify.modificationIdentifier)) {
        logger.warn(
          'Modification not applied. The identifier `${fileToModify.modificationIdentifier}` does not exist in the file.',
        );
      }

      final updatedFileContent = templateModificationFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        name: name,
        templateName: templateName,
        featureName: featureName,
      );

      final verboseMessage = templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
        featureName: featureName,
      );

      // Write the file back that was modified
      await fileService.writeStringFile(
        file: File(modificationPath),
        fileContent: updatedFileContent,
        verbose: true,
        type: FileModificationType.Modify,
        verboseMessage: verboseMessage,
      );
    }

    await processService.runFormat(appName: outputPath);
  }

  String templateModificationName({
    required String modificationName,
    required String name,
    required String templateName,
    String? featureName,
  }) {
    final template = Template(modificationName, lenient: true);

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
      featureName: featureName,
    );

    final renderedTemplate = template.renderString(templateRenderData);
    return renderedTemplate;
  }

  String templateModificationFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
    String? featureName,
  }) {
    final template = Template(modificationTemplate, lenient: true);

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
      featureName: featureName,
    );

    final renderedTemplate = template.renderString(templateRenderData);

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$modificationIdentifier\n$renderedTemplate',
    );
  }

  /// Creates `kCompiledTemplateTypes` on `compiled_constants.dart` file.
  Future<void> _createTemplateTypesConstantMap({
    required String templatesPath,
    required List<CompiledCreateCommand> dolphinTemplates,
  }) async {
    final templateTypesMap = Template(kTemplateTypesMap);
    final templateTypesMapData = {
      'dolphinTemplates': dolphinTemplates.map((e) => e.toJson()).toList(),
    };

    final templateMapContent = templateTypesMap.renderString(
      templateTypesMapData,
    );

    await fileService.writeStringFile(
      file: File(path.join(templatesPath, 'compiled_constants.dart')),
      fileContent: templateMapContent,
    );
  }
}
