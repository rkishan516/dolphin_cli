// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompliledTemplateFile _$CompliledTemplateFileFromJson(
        Map<String, dynamic> json) =>
    _CompliledTemplateFile(
      name: json['name'] as String,
      templateType: json['templateType'] as String,
      fileName: json['fileName'] as String,
      path: json['path'] as String,
      content: json['content'] as String,
      fileType: json['fileType'] as String,
      featureName: json['featureName'] as String? ?? '',
    );

Map<String, dynamic> _$CompliledTemplateFileToJson(
        _CompliledTemplateFile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'templateType': instance.templateType,
      'fileName': instance.fileName,
      'path': instance.path,
      'content': instance.content,
      'fileType': instance.fileType,
      'featureName': instance.featureName,
    };

_CompiledCreateCommand _$CompiledCreateCommandFromJson(
        Map<String, dynamic> json) =>
    _CompiledCreateCommand(
      name: json['name'] as String,
      templates: (json['templates'] as List<dynamic>)
          .map((e) => CompiledTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompiledCreateCommandToJson(
        _CompiledCreateCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'templates': instance.templates.map((e) => e.toJson()).toList(),
    };

_CompiledTemplate _$CompiledTemplateFromJson(Map<String, dynamic> json) =>
    _CompiledTemplate(
      type: json['type'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) => CompliledTemplateFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      modificationFiles: (json['modificationFiles'] as List<dynamic>?)
              ?.map((e) =>
                  CompiledFileModification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CompiledTemplateToJson(_CompiledTemplate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'modificationFiles':
          instance.modificationFiles.map((e) => e.toJson()).toList(),
    };

_CompiledFileModification _$CompiledFileModificationFromJson(
        Map<String, dynamic> json) =>
    _CompiledFileModification(
      description: json['description'] as String,
      path: json['path'] as String,
      identifier: json['identifier'] as String,
      template: json['template'] as String,
      error: json['error'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CompiledFileModificationToJson(
        _CompiledFileModification instance) =>
    <String, dynamic>{
      'description': instance.description,
      'path': instance.path,
      'identifier': instance.identifier,
      'template': instance.template,
      'error': instance.error,
      'name': instance.name,
    };
