// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class Config with _$Config {
  factory Config({
    /// Path where views and viewmodels will be genereated.
    @JsonKey(name: 'views_path') @Default('presentation') String viewsPath,

    /// Path where services will be genereated.
    @JsonKey(name: 'services_path') @Default('services') String servicesPath,

    /// Path where widgets will be genereated.
    @JsonKey(name: 'widgets_path') @Default('presentation') String widgetsPath,

    /// Path where bottom sheets will be genereated.
    @JsonKey(name: 'bottom_sheets_path')
    @Default('presentation')
    String bottomSheetsPath,

    /// Path where dialogs will be genereated.
    @JsonKey(name: 'dialogs_path') @Default('presentation') String dialogsPath,

    /// File path where DolphinApp is setup.
    @JsonKey(name: 'dolphin_app_file_path')
    @Default('app/app.dart')
    String dolphinAppFilePath,

    /// Defines the integer value to determine the line length when formatting
    /// the code.
    @JsonKey(name: 'line_length') @Default(80) int lineLength,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
