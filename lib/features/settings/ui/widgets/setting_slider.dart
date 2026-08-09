import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class SettingSlider extends StatefulWidget {
  const SettingSlider({
    required this.label,
    required this.min,
    required this.max,
    required this.initialValue,
    this.defaultValue = 0.0,
    this.showSwitch = false,
    this.switchInitialValue = true,
    this.saveDebounceDuration = const Duration(milliseconds: 200),
    this.onValueChanged,
    this.onSwitchChanged,
    super.key,
  });

  final String label;
  final double min;
  final double max;
  final double initialValue;
  final double defaultValue;

  final Duration saveDebounceDuration;

  final bool showSwitch;
  final bool switchInitialValue;

  final ValueChanged<double>? onValueChanged;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  State<SettingSlider> createState() => _SettingSliderState();
}

class _SettingSliderState extends State<SettingSlider> {
  late bool _enabled = !widget.showSwitch || widget.switchInitialValue;
  late double _value = _enabled ? widget.initialValue : widget.defaultValue;
  double get _fraction =>
      ((_value - widget.min) / (widget.max - widget.min)).clamp(0.0, 1.0);

  // We need to use debouncing because the slider calls _handleSliderChange even
  // for the slightest changes. This could result in a large number of redundant
  // setting changes
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSliderChange(FSliderValue v) {
    final value = widget.min + v.max * (widget.max - widget.min);
    setState(() => _value = value);

    // After the debounce time, save the settings to the setting state
    // (provided by the onValueChanged function)
    _debounce?.cancel();
    _debounce = Timer(widget.saveDebounceDuration, () {
      widget.onValueChanged?.call(value);
    });
  }

  void _handleSwitchChange(bool enabled) {
    setState(() {
      _enabled = enabled;
      _value = widget.defaultValue;
    });
    widget.onSwitchChanged?.call(enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: context.theme.typography.body.xs,
              ),
            ),
            if (widget.showSwitch) ...[
              FSwitch(value: _enabled, onChange: _handleSwitchChange),
            ],
          ],
        ),
        FSlider(
          enabled: _enabled,
          control: .liftedContinuous(
            value: FSliderValue(max: _fraction),
            onChange: _handleSliderChange,
          ),
          marks: [
            .mark(value: 0, label: Text(widget.min.toStringAsFixed(1))),
            .mark(value: 1, label: Text(widget.max.toStringAsFixed(1))),
          ],
          tooltipBuilder: (s, v) {
            return Text(_value.toStringAsFixed(2));
          },
        ),
      ],
    );
  }
}
