/// Stores all the commands used throughout the app that
const String ksDart = 'dart';
const String ksFlutter = 'flutter';
const String ksCreate = 'create';
const String ksRun = 'run';
const String ksPub = 'pub';
const String ksGet = 'get';
const String ksAdd = 'add';
const String ksFormat = 'format';
const String ksBuild = 'build';
const String ksBuildRunner = 'build_runner';
const String ksDeleteConflictOutputs = 'delete-conflicting-outputs';
const String ksDeleteConflictingOutputs = '--delete-conflicting-outputs';
const String ksVersion = 'version';
const String ksEnableAnalytics = 'enable-analytics';
const String ksDisableAnalytics = 'disable-analytics';
const String ksExcludeRoute = 'exclude-route';
const String ksUseBuilder = 'use-builder';
const String ksLineLength = 'line-length';
const String ksTemplateType = 'template';
const String ksFeatureName = 'feature';
const String ksExcludeDependency = 'exclude-dependency';
const String ksCurrentDirectory = '.';
const String ksGlobal = 'global';
const String ksList = 'list';
const String ksActivate = 'activate';
const String ksDolphinCli = 'dolphin_cli';
const String ksAnalyze = 'analyze';
const String ksModel = 'model';
const String ksConfigPath = 'config-path';
const String ksWatch = 'watch';
const String ksPath = 'path';
const String ksAppMinimalTemplate = 'empty';
const String ksAppDescription = 'description';
const String ksAppOrganization = 'org';
const String ksAppPlatforms = 'platforms';
const String ksBackend = 'backend';

/// A list of strings that are used to run the run build_runner
/// [build or watch] --delete-conflicting-outputs command.
const List<String> buildRunnerArguments = [
  ksRun,
  ksBuildRunner,
];

/// A list of strings that are used to run the pub get command.
const List<String> pubGetArguments = [ksPub, ksGet];

const List<String> pubAddArguments = [ksPub, ksAdd];

/// A list of strings that are used to run the pub global list command.
const List<String> pubGlobalListArguments = [
  ksPub,
  ksGlobal,
  ksList,
];

/// A list of strings that are used to run the pub global activate command.
const List<String> pubGlobalActivateArguments = [
  ksPub,
  ksGlobal,
  ksActivate,
  ksDolphinCli
];

/// A list of strings that are used to run the analyze command.
const List<String> analyzeArguments = [ksAnalyze];
