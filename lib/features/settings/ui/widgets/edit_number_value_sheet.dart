import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class EditNumberValueSheet extends StatefulWidget {
  final String title;
  final String description;
  final String label;
  final String hint;
  final int initialValue;
  final int min;
  final int max;
  final ValueChanged<int> onSave;

  const EditNumberValueSheet({
    required this.title,
    required this.description,
    required this.label,
    required this.hint,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.onSave,
    super.key,
  });

  @override
  State<EditNumberValueSheet> createState() => _EditNumberValueSheetState();
}

class _EditNumberValueSheetState extends State<EditNumberValueSheet> {
  final _key = GlobalKey<FormState>();

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib eine Zahl ein.';
    }
    final number = int.tryParse(value.trim());
    if (number == null || number < widget.min || number > widget.max) {
      return 'Bitte gib eine gültige Zahl zwischen ${widget.min} und ${widget.max} ein.';
    }
    return null;
  }

  void _save(String? value) {
    if (value == null) return;
    widget.onSave(int.parse(value));
  }

  void _onSubmitButtonPressed() {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        border: Border(top: BorderSide(color: context.theme.colors.border)),
      ),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: const .only(left: 16, right: 16, top: 32, bottom: 48),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(
                widget.title,
                style: context.theme.typography.display.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: context.theme.typography.body.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              FTextFormField(
                control: .managed(
                  initial: TextEditingValue(
                    text: widget.initialValue.toString(),
                  ),
                ),
                label: Text(widget.label),
                hint: widget.hint,
                keyboardType: TextInputType.number,
                autovalidateMode: .onUserInteraction,
                validator: _validateNumber,
                onSaved: _save,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: .end,
                children: [
                  FButton(
                    size: .sm,
                    mainAxisSize: .min,
                    onPress: _onSubmitButtonPressed,
                    child: const Text('Speichern'),
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

void showEditNumberValueSheet({
  required BuildContext context,
  required String title,
  required String description,
  required String label,
  required String hint,
  required int initialValue,
  required int min,
  required int max,
  required ValueChanged<int> onSave,
}) => showFSheet(
  context: context,
  side: FLayout.btt,
  style: .delta(
    barrierFilter: (_, animation) => .compose(
      outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
      inner: ColorFilter.mode(context.theme.colors.barrier, .srcOver),
    ),
  ),
  useSafeArea: true,
  useRootNavigator: true,
  builder: (sheetContext) => EditNumberValueSheet(
    title: title,
    description: description,
    initialValue: initialValue,
    onSave: onSave,
    label: label,
    hint: hint,
    min: min,
    max: max,
  ),
);
