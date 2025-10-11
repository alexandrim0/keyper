import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:amplitude_flutter/events/base_event.dart';

import 'package:guardian_keyper/consts.dart';

class AnalyticsService {
  static Future<AnalyticsService> init() async {
    if (amplitudeKey.isEmpty) {
      return AnalyticsService(
        logEvent: (_) => Future.value(),
      );
    }
    final amplitude = Amplitude(Configuration(
      apiKey: amplitudeKey,
      enableCoppaControl: true,
    ));
    return AnalyticsService(
      logEvent: (e) => amplitude.track(BaseEvent(e)),
    );
  }

  const AnalyticsService({
    required this.logEvent,
  });

  final Future<void> Function(String event) logEvent;

  Future<void> logStartCreateVault() => logEvent('Start CreateVault');
  Future<void> logFinishCreateVault() => logEvent('Finish CreateVault');

  Future<void> logStartRestoreVault() => logEvent('Start RestoreVault');
  Future<void> logFinishRestoreVault() => logEvent('Finish RestoreVault');

  Future<void> logStartAddGuardian() => logEvent('Start AddGuardian');
  Future<void> logFinishAddGuardian() => logEvent('Finish AddGuardian');

  Future<void> logStartAddSecret() => logEvent('Start AddSecret');
  Future<void> logFinishAddSecret() => logEvent('Finish AddSecret');

  Future<void> logStartRestoreSecret() => logEvent('Start RestoreSecret');
  Future<void> logFinishRestoreSecret() => logEvent('Finish RestoreSecret');
}
