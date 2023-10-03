// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  /// Path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath => throw _privateConstructorUsedError;

  /// Path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath => throw _privateConstructorUsedError;

  /// Path where widgets will be genereated.
  @JsonKey(name: 'widgets_path')
  String get widgetsPath => throw _privateConstructorUsedError;

  /// Path where bottom sheets will be genereated.
  @JsonKey(name: 'bottom_sheets_path')
  String get bottomSheetsPath => throw _privateConstructorUsedError;

  /// Path where dialogs will be genereated.
  @JsonKey(name: 'dialogs_path')
  String get dialogsPath => throw _privateConstructorUsedError;

  /// File path where DolphinApp is setup.
  @JsonKey(name: 'dolphin_app_file_path')
  String get dolphinAppFilePath => throw _privateConstructorUsedError;

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @JsonKey(name: 'line_length')
  int get lineLength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
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
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      viewsPath: null == viewsPath
          ? _value.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _value.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      widgetsPath: null == widgetsPath
          ? _value.widgetsPath
          : widgetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      bottomSheetsPath: null == bottomSheetsPath
          ? _value.bottomSheetsPath
          : bottomSheetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dialogsPath: null == dialogsPath
          ? _value.dialogsPath
          : dialogsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dolphinAppFilePath: null == dolphinAppFilePath
          ? _value.dolphinAppFilePath
          : dolphinAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      lineLength: null == lineLength
          ? _value.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
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
class __$$_ConfigCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$_Config>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, _then);

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
    return _then(_$_Config(
      viewsPath: null == viewsPath
          ? _value.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _value.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      widgetsPath: null == widgetsPath
          ? _value.widgetsPath
          : widgetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      bottomSheetsPath: null == bottomSheetsPath
          ? _value.bottomSheetsPath
          : bottomSheetsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dialogsPath: null == dialogsPath
          ? _value.dialogsPath
          : dialogsPath // ignore: cast_nullable_to_non_nullable
              as String,
      dolphinAppFilePath: null == dolphinAppFilePath
          ? _value.dolphinAppFilePath
          : dolphinAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      lineLength: null == lineLength
          ? _value.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  _$_Config(
      {@JsonKey(name: 'views_path') this.viewsPath = 'presentation',
      @JsonKey(name: 'services_path') this.servicesPath = 'services',
      @JsonKey(name: 'widgets_path') this.widgetsPath = 'presentation',
      @JsonKey(name: 'bottom_sheets_path')
      this.bottomSheetsPath = 'presentation',
      @JsonKey(name: 'dialogs_path') this.dialogsPath = 'presentation',
      @JsonKey(name: 'dolphin_app_file_path')
      this.dolphinAppFilePath = 'app/app.dart',
      @JsonKey(name: 'line_length') this.lineLength = 80});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

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

  @override
  String toString() {
    return 'Config(viewsPath: $viewsPath, servicesPath: $servicesPath, widgetsPath: $widgetsPath, bottomSheetsPath: $bottomSheetsPath, dialogsPath: $dialogsPath, dolphinAppFilePath: $dolphinAppFilePath, lineLength: $lineLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  factory _Config(
      {@JsonKey(name: 'views_path') final String viewsPath,
      @JsonKey(name: 'services_path') final String servicesPath,
      @JsonKey(name: 'widgets_path') final String widgetsPath,
      @JsonKey(name: 'bottom_sheets_path') final String bottomSheetsPath,
      @JsonKey(name: 'dialogs_path') final String dialogsPath,
      @JsonKey(name: 'dolphin_app_file_path') final String dolphinAppFilePath,
      @JsonKey(name: 'line_length') final int lineLength}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override

  /// Path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath;
  @override

  /// Path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath;
  @override

  /// Path where widgets will be genereated.
  @JsonKey(name: 'widgets_path')
  String get widgetsPath;
  @override

  /// Path where bottom sheets will be genereated.
  @JsonKey(name: 'bottom_sheets_path')
  String get bottomSheetsPath;
  @override

  /// Path where dialogs will be genereated.
  @JsonKey(name: 'dialogs_path')
  String get dialogsPath;
  @override

  /// File path where DolphinApp is setup.
  @JsonKey(name: 'dolphin_app_file_path')
  String get dolphinAppFilePath;
  @override

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @JsonKey(name: 'line_length')
  int get lineLength;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}
