// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompliledTemplateFile {
  /// Pascal case name of the template this file belongs too
  String get name;

  /// Pascal case name of the template type this file belongs too,
  String get templateType;

  /// Pascal case name of the file without the extension
  String get fileName;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get path;

  /// The content as is from the file that was read
  String get content;

  /// The type of file to determine how we'll store it
  String get fileType;

  /// The identifier to use to determine location of modifications
  String get featureName;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompliledTemplateFileCopyWith<CompliledTemplateFile> get copyWith =>
      _$CompliledTemplateFileCopyWithImpl<CompliledTemplateFile>(
          this as CompliledTemplateFile, _$identity);

  /// Serializes this CompliledTemplateFile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompliledTemplateFile &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.templateType, templateType) ||
                other.templateType == templateType) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, templateType, fileName,
      path, content, fileType, featureName);

  @override
  String toString() {
    return 'CompliledTemplateFile(name: $name, templateType: $templateType, fileName: $fileName, path: $path, content: $content, fileType: $fileType, featureName: $featureName)';
  }
}

/// @nodoc
abstract mixin class $CompliledTemplateFileCopyWith<$Res> {
  factory $CompliledTemplateFileCopyWith(CompliledTemplateFile value,
          $Res Function(CompliledTemplateFile) _then) =
      _$CompliledTemplateFileCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String templateType,
      String fileName,
      String path,
      String content,
      String fileType,
      String featureName});
}

/// @nodoc
class _$CompliledTemplateFileCopyWithImpl<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  _$CompliledTemplateFileCopyWithImpl(this._self, this._then);

  final CompliledTemplateFile _self;
  final $Res Function(CompliledTemplateFile) _then;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templateType = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
    Object? fileType = null,
    Object? featureName = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _self.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _self.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _self.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
      featureName: null == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CompliledTemplateFile implements CompliledTemplateFile {
  _CompliledTemplateFile(
      {required this.name,
      required this.templateType,
      required this.fileName,
      required this.path,
      required this.content,
      required this.fileType,
      this.featureName = ''});
  factory _CompliledTemplateFile.fromJson(Map<String, dynamic> json) =>
      _$CompliledTemplateFileFromJson(json);

  /// Pascal case name of the template this file belongs too
  @override
  final String name;

  /// Pascal case name of the template type this file belongs too,
  @override
  final String templateType;

  /// Pascal case name of the file without the extension
  @override
  final String fileName;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  @override
  final String path;

  /// The content as is from the file that was read
  @override
  final String content;

  /// The type of file to determine how we'll store it
  @override
  final String fileType;

  /// The identifier to use to determine location of modifications
  @override
  @JsonKey()
  final String featureName;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompliledTemplateFileCopyWith<_CompliledTemplateFile> get copyWith =>
      __$CompliledTemplateFileCopyWithImpl<_CompliledTemplateFile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompliledTemplateFileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompliledTemplateFile &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.templateType, templateType) ||
                other.templateType == templateType) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, templateType, fileName,
      path, content, fileType, featureName);

  @override
  String toString() {
    return 'CompliledTemplateFile(name: $name, templateType: $templateType, fileName: $fileName, path: $path, content: $content, fileType: $fileType, featureName: $featureName)';
  }
}

/// @nodoc
abstract mixin class _$CompliledTemplateFileCopyWith<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  factory _$CompliledTemplateFileCopyWith(_CompliledTemplateFile value,
          $Res Function(_CompliledTemplateFile) _then) =
      __$CompliledTemplateFileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String templateType,
      String fileName,
      String path,
      String content,
      String fileType,
      String featureName});
}

/// @nodoc
class __$CompliledTemplateFileCopyWithImpl<$Res>
    implements _$CompliledTemplateFileCopyWith<$Res> {
  __$CompliledTemplateFileCopyWithImpl(this._self, this._then);

  final _CompliledTemplateFile _self;
  final $Res Function(_CompliledTemplateFile) _then;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? templateType = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
    Object? fileType = null,
    Object? featureName = null,
  }) {
    return _then(_CompliledTemplateFile(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _self.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _self.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _self.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
      featureName: null == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CompiledCreateCommand {
  String get name;
  List<CompiledTemplate> get templates;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompiledCreateCommandCopyWith<CompiledCreateCommand> get copyWith =>
      _$CompiledCreateCommandCopyWithImpl<CompiledCreateCommand>(
          this as CompiledCreateCommand, _$identity);

  /// Serializes this CompiledCreateCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompiledCreateCommand &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.templates, templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(templates));

  @override
  String toString() {
    return 'CompiledCreateCommand(name: $name, templates: $templates)';
  }
}

/// @nodoc
abstract mixin class $CompiledCreateCommandCopyWith<$Res> {
  factory $CompiledCreateCommandCopyWith(CompiledCreateCommand value,
          $Res Function(CompiledCreateCommand) _then) =
      _$CompiledCreateCommandCopyWithImpl;
  @useResult
  $Res call({String name, List<CompiledTemplate> templates});
}

/// @nodoc
class _$CompiledCreateCommandCopyWithImpl<$Res>
    implements $CompiledCreateCommandCopyWith<$Res> {
  _$CompiledCreateCommandCopyWithImpl(this._self, this._then);

  final CompiledCreateCommand _self;
  final $Res Function(CompiledCreateCommand) _then;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templates = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templates: null == templates
          ? _self.templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplate>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CompiledCreateCommand implements CompiledCreateCommand {
  _CompiledCreateCommand(
      {required this.name, required final List<CompiledTemplate> templates})
      : _templates = templates;
  factory _CompiledCreateCommand.fromJson(Map<String, dynamic> json) =>
      _$CompiledCreateCommandFromJson(json);

  @override
  final String name;
  final List<CompiledTemplate> _templates;
  @override
  List<CompiledTemplate> get templates {
    if (_templates is EqualUnmodifiableListView) return _templates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templates);
  }

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompiledCreateCommandCopyWith<_CompiledCreateCommand> get copyWith =>
      __$CompiledCreateCommandCopyWithImpl<_CompiledCreateCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompiledCreateCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledCreateCommand &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._templates, _templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_templates));

  @override
  String toString() {
    return 'CompiledCreateCommand(name: $name, templates: $templates)';
  }
}

/// @nodoc
abstract mixin class _$CompiledCreateCommandCopyWith<$Res>
    implements $CompiledCreateCommandCopyWith<$Res> {
  factory _$CompiledCreateCommandCopyWith(_CompiledCreateCommand value,
          $Res Function(_CompiledCreateCommand) _then) =
      __$CompiledCreateCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String name, List<CompiledTemplate> templates});
}

/// @nodoc
class __$CompiledCreateCommandCopyWithImpl<$Res>
    implements _$CompiledCreateCommandCopyWith<$Res> {
  __$CompiledCreateCommandCopyWithImpl(this._self, this._then);

  final _CompiledCreateCommand _self;
  final $Res Function(_CompiledCreateCommand) _then;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? templates = null,
  }) {
    return _then(_CompiledCreateCommand(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templates: null == templates
          ? _self._templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplate>,
    ));
  }
}

/// @nodoc
mixin _$CompiledTemplate {
  String get type;
  List<CompliledTemplateFile> get files;
  List<CompiledFileModification> get modificationFiles;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompiledTemplateCopyWith<CompiledTemplate> get copyWith =>
      _$CompiledTemplateCopyWithImpl<CompiledTemplate>(
          this as CompiledTemplate, _$identity);

  /// Serializes this CompiledTemplate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompiledTemplate &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.files, files) &&
            const DeepCollectionEquality()
                .equals(other.modificationFiles, modificationFiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(files),
      const DeepCollectionEquality().hash(modificationFiles));

  @override
  String toString() {
    return 'CompiledTemplate(type: $type, files: $files, modificationFiles: $modificationFiles)';
  }
}

/// @nodoc
abstract mixin class $CompiledTemplateCopyWith<$Res> {
  factory $CompiledTemplateCopyWith(
          CompiledTemplate value, $Res Function(CompiledTemplate) _then) =
      _$CompiledTemplateCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      List<CompliledTemplateFile> files,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class _$CompiledTemplateCopyWithImpl<$Res>
    implements $CompiledTemplateCopyWith<$Res> {
  _$CompiledTemplateCopyWithImpl(this._self, this._then);

  final CompiledTemplate _self;
  final $Res Function(CompiledTemplate) _then;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? files = null,
    Object? modificationFiles = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
          ? _self.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CompiledTemplate implements CompiledTemplate {
  _CompiledTemplate(
      {required this.type,
      required final List<CompliledTemplateFile> files,
      final List<CompiledFileModification> modificationFiles = const []})
      : _files = files,
        _modificationFiles = modificationFiles;
  factory _CompiledTemplate.fromJson(Map<String, dynamic> json) =>
      _$CompiledTemplateFromJson(json);

  @override
  final String type;
  final List<CompliledTemplateFile> _files;
  @override
  List<CompliledTemplateFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final List<CompiledFileModification> _modificationFiles;
  @override
  @JsonKey()
  List<CompiledFileModification> get modificationFiles {
    if (_modificationFiles is EqualUnmodifiableListView)
      return _modificationFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modificationFiles);
  }

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompiledTemplateCopyWith<_CompiledTemplate> get copyWith =>
      __$CompiledTemplateCopyWithImpl<_CompiledTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompiledTemplateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledTemplate &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            const DeepCollectionEquality()
                .equals(other._modificationFiles, _modificationFiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_files),
      const DeepCollectionEquality().hash(_modificationFiles));

  @override
  String toString() {
    return 'CompiledTemplate(type: $type, files: $files, modificationFiles: $modificationFiles)';
  }
}

/// @nodoc
abstract mixin class _$CompiledTemplateCopyWith<$Res>
    implements $CompiledTemplateCopyWith<$Res> {
  factory _$CompiledTemplateCopyWith(
          _CompiledTemplate value, $Res Function(_CompiledTemplate) _then) =
      __$CompiledTemplateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      List<CompliledTemplateFile> files,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class __$CompiledTemplateCopyWithImpl<$Res>
    implements _$CompiledTemplateCopyWith<$Res> {
  __$CompiledTemplateCopyWithImpl(this._self, this._then);

  final _CompiledTemplate _self;
  final $Res Function(_CompiledTemplate) _then;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? files = null,
    Object? modificationFiles = null,
  }) {
    return _then(_CompiledTemplate(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
          ? _self._modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
mixin _$CompiledFileModification {
  /// A short description for what this modiciation does
  String get description;

  /// The relative path to the file that needs to be modified
  String get path;

  /// The identifier to use to determine location of modifications
  String get identifier;

  /// The mustache template to use when rendering the modification
  String get template;

  /// The message to show the user of the cli if the modification fails
  String get error;

  /// The message to show the user of the cli if the modification succeeds
  String get name;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompiledFileModificationCopyWith<CompiledFileModification> get copyWith =>
      _$CompiledFileModificationCopyWithImpl<CompiledFileModification>(
          this as CompiledFileModification, _$identity);

  /// Serializes this CompiledFileModification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompiledFileModification &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, path, identifier, template, error, name);

  @override
  String toString() {
    return 'CompiledFileModification(description: $description, path: $path, identifier: $identifier, template: $template, error: $error, name: $name)';
  }
}

/// @nodoc
abstract mixin class $CompiledFileModificationCopyWith<$Res> {
  factory $CompiledFileModificationCopyWith(CompiledFileModification value,
          $Res Function(CompiledFileModification) _then) =
      _$CompiledFileModificationCopyWithImpl;
  @useResult
  $Res call(
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
}

/// @nodoc
class _$CompiledFileModificationCopyWithImpl<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  _$CompiledFileModificationCopyWithImpl(this._self, this._then);

  final CompiledFileModification _self;
  final $Res Function(CompiledFileModification) _then;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _self.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CompiledFileModification implements CompiledFileModification {
  _CompiledFileModification(
      {required this.description,
      required this.path,
      required this.identifier,
      required this.template,
      required this.error,
      required this.name});
  factory _CompiledFileModification.fromJson(Map<String, dynamic> json) =>
      _$CompiledFileModificationFromJson(json);

  /// A short description for what this modiciation does
  @override
  final String description;

  /// The relative path to the file that needs to be modified
  @override
  final String path;

  /// The identifier to use to determine location of modifications
  @override
  final String identifier;

  /// The mustache template to use when rendering the modification
  @override
  final String template;

  /// The message to show the user of the cli if the modification fails
  @override
  final String error;

  /// The message to show the user of the cli if the modification succeeds
  @override
  final String name;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompiledFileModificationCopyWith<_CompiledFileModification> get copyWith =>
      __$CompiledFileModificationCopyWithImpl<_CompiledFileModification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompiledFileModificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledFileModification &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, path, identifier, template, error, name);

  @override
  String toString() {
    return 'CompiledFileModification(description: $description, path: $path, identifier: $identifier, template: $template, error: $error, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$CompiledFileModificationCopyWith<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  factory _$CompiledFileModificationCopyWith(_CompiledFileModification value,
          $Res Function(_CompiledFileModification) _then) =
      __$CompiledFileModificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
}

/// @nodoc
class __$CompiledFileModificationCopyWithImpl<$Res>
    implements _$CompiledFileModificationCopyWith<$Res> {
  __$CompiledFileModificationCopyWithImpl(this._self, this._then);

  final _CompiledFileModification _self;
  final $Res Function(_CompiledFileModification) _then;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_CompiledFileModification(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _self.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
