import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';

class MockConfigService extends Mock implements ConfigService {}

class MockFileService extends Mock implements FileService {}

class MockPubService extends Mock implements PubService {}

class MockPubSpecService extends Mock implements PubspecService {}

class MockProcessService extends Mock implements ProcessService {}

class MockLoggerService extends Mock implements Logger {}

class MockPubUpdater extends Mock implements PubUpdater {}
