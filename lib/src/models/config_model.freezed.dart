// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Config {
  /// Path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath;

  /// Path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath;

  /// Path where widgets will be genereated.
  @JsonKey(name: 'widgets_path')
  String get widgetsPath;

  /// Path where bottom sheets will be genereated.
  @JsonKey(name: 'bottom_sheets_path')
  String get bottomSheetsPath;

  /// Path where dialogs will be genereated.
  @JsonKey(name: 'dialogs_path')
  String get dialogsPath;

  /// File path where DolphinApp is setup.
  @JsonKey(name: 'dolphin_app_file_path')
  String get dolphinAppFilePath;

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @JsonKey(name: 'line_length')
  int get lineLength;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfigCopyWith<Config> get copyWith =>
      _$ConfigCopyWithImpl<Config>(this as Config, _$identity);

  /// Serializes this Config to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Config &&
            (identical(other.viewsPath, viewsPath) ||
                other.viewsPath == viewsPath) &&
            (identical(other.servicesPath, servicesPath) ||
                other.servicesPath == servicesPath) &&
            (identical(other.widgetsPath, widgetsPath) ||
                other.widgetsPath == widgetsPath) &&
            (identical(other.bottomSheetsPath, bottomSheetsPath) ||
                other.bottomSheetsPath == bottomSheetsPath) &&
            (identical(other.dialogsPath, dialogsPath) ||
                other.dialogsPath == dialogsPath) &&
            (identical(other.dolphinAppFilePath, dolphinAppFilePath) ||
                other.dolphinAppFilePath == dolphinAppFilePath) &&
            (identical(other.lineLength, lineLength) ||
                other.lineLength == lineLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewsPath,
      servicesPath,
      widgetsPath,
      bottomSheetsPath,
      dialogsPath,
      dolphinAppFilePath,
      lineLength);

  @override
  String toString() {
    return 'Config(viewsPath: $viewsPath, servicesPath: $servicesPath, widgetsPath: $widgetsPath, bottomSheetsPath: $bottomSheetsPath, dialogsPath: $dialogsPath, dolphinAppFilePath: $dolphinAppFilePath, lineLength: $lineLength)';
  }
}

/// @nodoc
abstract mixin class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) _then) =
      _$ConfigCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'views_path') String viewsPath,
      @JsonKey(name: 'services_path') String servicesPath,
      @JsonKey(name: 'widgets_path') String widgetsPath,
      @JsonKey(name: 'bottom_sheets_path') String bottomSheetsPath,
      @JsonKey(name: 'dialogs_path') String dialogsPath,
      @JsonKey(name: 'dolphin_app_file_path') String dolphinAppFilePath,
      @JsonKey(name: 'line_length') int lineLength});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._self, this._then);

  final Config _self;
  final $Res Function(Config) _then;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewsPath = null,
    Object? servicesPath = null,
    Object? widgetsPath = null,
    Object? bottomSheetsPath = null,
    Object? dialogsPath = null,
    Object? dolphinAppFilePath = null,
    Object? lineLength = null,
  }) {
    return _then(_self.copyWith(
      viewsPath: null == viewsPath
          ? _self.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _self.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      widgetsPath: null == widgetsPath
          ? _self.widgetsPath
          : widgetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      bottomSheetsPath: null == bottomSheetsPath
          ? _self.bottomSheetsPath
          : bottomSheetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dialogsPath: null == dialogsPath
          ? _self.dialogsPath
          : dialogsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dolphinAppFilePath: null == dolphinAppFilePath
          ? _self.dolphinAppFilePath
          : dolphinAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      lineLength: null == lineLength
          ? _self.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Config implements Config {
  _Config(
      {@JsonKey(name: 'views_path') this.viewsPath = 'presentation',
      @JsonKey(name: 'services_path') this.servicesPath = 'services',
      @JsonKey(name: 'widgets_path') this.widgetsPath = 'presentation',
      @JsonKey(name: 'bottom_sheets_path')
      this.bottomSheetsPath = 'presentation',
      @JsonKey(name: 'dialogs_path') this.dialogsPath = 'presentation',
      @JsonKey(name: 'dolphin_app_file_path')
      this.dolphinAppFilePath = 'app/app.dart',
      @JsonKey(name: 'line_length') this.lineLength = 80});
  factory _Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  /// Path where views and viewmodels will be genereated.
  @override
  @JsonKey(name: 'views_path')
  final String viewsPath;

  /// Path where services will be genereated.
  @override
  @JsonKey(name: 'services_path')
  final String servicesPath;

  /// Path where widgets will be genereated.
  @override
  @JsonKey(name: 'widgets_path')
  final String widgetsPath;

  /// Path where bottom sheets will be genereated.
  @override
  @JsonKey(name: 'bottom_sheets_path')
  final String bottomSheetsPath;

  /// Path where dialogs will be genereated.
  @override
  @JsonKey(name: 'dialogs_path')
  final String dialogsPath;

  /// File path where DolphinApp is setup.
  @override
  @JsonKey(name: 'dolphin_app_file_path')
  final String dolphinAppFilePath;

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @override
  @JsonKey(name: 'line_length')
  final int lineLength;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConfigCopyWith<_Config> get copyWith =>
      __$ConfigCopyWithImpl<_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Config &&
            (identical(other.viewsPath, viewsPath) ||
                other.viewsPath == viewsPath) &&
            (identical(other.servicesPath, servicesPath) ||
                other.servicesPath == servicesPath) &&
            (identical(other.widgetsPath, widgetsPath) ||
                other.widgetsPath == widgetsPath) &&
            (identical(other.bottomSheetsPath, bottomSheetsPath) ||
                other.bottomSheetsPath == bottomSheetsPath) &&
            (identical(other.dialogsPath, dialogsPath) ||
                other.dialogsPath == dialogsPath) &&
            (identical(other.dolphinAppFilePath, dolphinAppFilePath) ||
                other.dolphinAppFilePath == dolphinAppFilePath) &&
            (identical(other.lineLength, lineLength) ||
                other.lineLength == lineLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewsPath,
      servicesPath,
      widgetsPath,
      bottomSheetsPath,
      dialogsPath,
      dolphinAppFilePath,
      lineLength);

  @override
  String toString() {
    return 'Config(viewsPath: $viewsPath, servicesPath: $servicesPath, widgetsPath: $widgetsPath, bottomSheetsPath: $bottomSheetsPath, dialogsPath: $dialogsPath, dolphinAppFilePath: $dolphinAppFilePath, lineLength: $lineLength)';
  }
}

/// @nodoc
abstract mixin class _$ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$ConfigCopyWith(_Config value, $Res Function(_Config) _then) =
      __$ConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'views_path') String viewsPath,
      @JsonKey(name: 'services_path') String servicesPath,
      @JsonKey(name: 'widgets_path') String widgetsPath,
      @JsonKey(name: 'bottom_sheets_path') String bottomSheetsPath,
      @JsonKey(name: 'dialogs_path') String dialogsPath,
      @JsonKey(name: 'dolphin_app_file_path') String dolphinAppFilePath,
      @JsonKey(name: 'line_length') int lineLength});
}

/// @nodoc
class __$ConfigCopyWithImpl<$Res> implements _$ConfigCopyWith<$Res> {
  __$ConfigCopyWithImpl(this._self, this._then);

  final _Config _self;
  final $Res Function(_Config) _then;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? viewsPath = null,
    Object? servicesPath = null,
    Object? widgetsPath = null,
    Object? bottomSheetsPath = null,
    Object? dialogsPath = null,
    Object? dolphinAppFilePath = null,
    Object? lineLength = null,
  }) {
    return _then(_Config(
      viewsPath: null == viewsPath
          ? _self.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _self.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      widgetsPath: null == widgetsPath
          ? _self.widgetsPath
          : widgetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      bottomSheetsPath: null == bottomSheetsPath
          ? _self.bottomSheetsPath
          : bottomSheetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dialogsPath: null == dialogsPath
          ? _self.dialogsPath
          : dialogsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dolphinAppFilePath: null == dolphinAppFilePath
          ? _self.dolphinAppFilePath
          : dolphinAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      lineLength: null == lineLength
          ? _self.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
