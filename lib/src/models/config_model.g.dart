// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      viewsPath: json['views_path'] as String? ?? 'presentation',
      servicesPath: json['services_path'] as String? ?? 'services',
      widgetsPath: json['widgets_path'] as String? ?? 'presentation',
      bottomSheetsPath: json['bottom_sheets_path'] as String? ?? 'presentation',
      dialogsPath: json['dialogs_path'] as String? ?? 'presentation',
      dolphinAppFilePath:
          json['dolphin_app_file_path'] as String? ?? 'app/app.dart',
      lineLength: json['line_length'] as int? ?? 80,
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'views_path': instance.viewsPath,
      'services_path': instance.servicesPath,
      'widgets_path': instance.widgetsPath,
      'bottom_sheets_path': instance.bottomSheetsPath,
      'dialogs_path': instance.dialogsPath,
      'dolphin_app_file_path': instance.dolphinAppFilePath,
      'line_length': instance.lineLength,
    };
