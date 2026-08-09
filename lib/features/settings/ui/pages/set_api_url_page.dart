import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../data/settings_controller_provider.dart';
import '../../domain/models/fmr_settings.dart';

class SetApiUrlPage extends ConsumerStatefulWidget {
  const SetApiUrlPage({super.key, this.isOnboarding = false});
  final bool isOnboarding;
  @override
  ConsumerState<SetApiUrlPage> createState() => _SetApiUrlPageState();
}

class _SetApiUrlPageState extends ConsumerState<SetApiUrlPage> {
  final _key = GlobalKey<FormState>();
  FMRSettings? _currentSettings;
  String _apiUrl = '';

  @override
  void initState() {
    super.initState();
    _currentSettings = ref.read(settingsControllerProvider).settings;
    _apiUrl = _currentSettings?.apiUrl ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();
    if (widget.isOnboarding) {
      context.push('/onboarding/calculate-hr', extra: _apiUrl);
    } else {
      await ref.read(settingsControllerProvider).updateWith(apiUrl: _apiUrl);
      if (mounted) context.go('/settings');
    }
  }

  String? _validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'Bitte gib eine URL ein.';
    }
    if (!url.startsWith('http')) {
      return 'URLs müssen mit http beginnen.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => FScaffold(
    resizeToAvoidBottomInset: false,
    header: FHeader.nested(
      prefixes: (widget.isOnboarding)
          ? []
          : [FHeaderAction.back(onPress: () => context.pop())],
      title: const Text('API-URL'),
      titleAlignment: .centerLeft,
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: .start,
          children: [
            FTextFormField(
              control: .managed(
                initial: TextEditingValue(text: _currentSettings?.apiUrl ?? ''),
              ),
              label: const Text('API-URL'),
              description: const Text(
                'Bitte gib die URL an, unter der auf die Backend-API zugegriffen werden kann.',
              ),
              clearable: (value) => value.text.isNotEmpty,
              hint: 'z.B. http://10.3.3.8:8000/',
              keyboardType: TextInputType.url,
              autovalidateMode: .onUserInteraction,
              validator: _validateUrl,
              onSaved: (value) => _apiUrl = value ?? '',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: .end,
              children: [
                FButton(
                  size: .sm,
                  mainAxisSize: .min,
                  onPress: _onContinue,
                  child: Text(widget.isOnboarding ? 'Weiter' : 'Speichern'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
