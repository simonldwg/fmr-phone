import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_music_recommender/features/exercise/data/heart_rate_repository.dart';
import 'package:fitness_music_recommender/features/exercise/domain/target_heart_rate_calculator.dart';

import '../../data/settings_controller_provider.dart';
import '../../domain/models/fmr_settings_defaults.dart';

class CalculateHrPage extends ConsumerStatefulWidget {
  const CalculateHrPage({
    super.key,
    this.isOnboarding = false,
    this.apiUrlFromOnboarding,
  });

  final bool isOnboarding;
  final String? apiUrlFromOnboarding;

  @override
  ConsumerState<CalculateHrPage> createState() => _CalculateHrPageState();
}

class _CalculateHrPageState extends ConsumerState<CalculateHrPage> {
  final _key = GlobalKey<FormState>();
  final _restingHrController = TextEditingController();

  int _age = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _restingHrController.dispose();
    super.dispose();
  }

  Future<void> _onReadRestingHr() async {
    try {
      final value = await const HeartRateRepository().readRestingHeartRate();
      if (!mounted) return;
      setState(() {
        _restingHrController.text = value.toString();
      });
    } on HeartRateAccessException catch (e) {
      if (!mounted) return;
      showFToast(
        context: context,
        variant: .destructive,
        icon: const Icon(FLucideIcons.circleX),
        title: Text('Ruheherzfrequenz konnte nicht gelesen werden'),
        description: Text(e.cause),
      );
    }
  }

  Future<void> _onContinue() async {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();

    int restingHr = int.parse(_restingHrController.text);

    TargetHeartRateCalculator calculator =
        TargetHeartRateCalculator.getCalculator(_age, restingHr);

    final targetHrModerate = calculator.calculateTargetHrModerate();
    final targetHrVigorous = calculator.calculateTargetHrVigorous();

    final settingsController = ref.read(settingsControllerProvider);

    if (widget.isOnboarding) {
      assert(widget.apiUrlFromOnboarding != null);
      final settings = SettingsDefaults.buildFromOnboarding(
        apiUrl: widget.apiUrlFromOnboarding!,
        targetHrModerate: targetHrModerate,
        targetHrVigorous: targetHrVigorous,
      );
      await settingsController.completeOnboarding(settings);
      if (!mounted) return;
      context.go('/exercise/overview');
    } else {
      await settingsController.updateWith(
        targetHrModerate: targetHrModerate,
        targetHrVigorous: targetHrVigorous,
      );
      if (!mounted) return;
      context.go('/settings');
    }
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib einen Wert ein.';
    }
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return 'Bitte gib eine ganze Zahl ein.';
    }
    if (parsed <= 0 || parsed > 120) {
      return 'Bitte gib einen realistischen Wert ein.';
    }
    return null;
  }

  String? _validateRestingHr(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib einen Wert ein.';
    }
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return 'Bitte gib eine ganze Zahl ein.';
    }
    if (parsed <= 0 || parsed > 250) {
      return 'Bitte gib einen realistischen Wert ein.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      resizeToAvoidBottomInset: false,
      header: FHeader.nested(
        prefixes: [FHeaderAction.back(onPress: () => context.pop())],
        title: const Text('Herzfrequenzen'),
        titleAlignment: .centerLeft,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: .start,
            children: [
              const SmallDescriptionText('Aus diesen Angaben werden die Ziel-Herzfrequenzen für moderates und starkes Training berechnet. Die Werte können in den Einstellungen später auch manuell festgelegt werden.'),
              const SizedBox(height: 16),
              FTextFormField(
                control: .managed(),
                label: const Text('Alter'),
                hint: 'z.B. 30',
                keyboardType: TextInputType.number,
                autovalidateMode: .onUserInteraction,
                validator: _validateAge,
                onSaved: (value) => _age = int.parse(value!),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: FTextFormField(
                      control: .managed(controller: _restingHrController),
                      label: const Text('Ruheherzfrequenz'),
                      hint: 'z.B. 60',
                      keyboardType: TextInputType.number,
                      autovalidateMode: .onUserInteraction,
                      validator: _validateRestingHr,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: FButton(
                      size: .sm,
                      mainAxisSize: .min,
                      onPress: _onReadRestingHr,
                      child: const Text('Auslesen'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SmallDescriptionText('Die Ruheherzfrequenz kann manuell eingetragen oder aus den Gesundheitsdaten deines Smartphones ausgelesen werden.'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: .end,
                children: [
                  FButton(
                    size: .sm,
                    mainAxisSize: .min,
                    onPress: _onContinue,
                    child: Text(widget.isOnboarding ? 'Weiter' : 'Berechnen'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
