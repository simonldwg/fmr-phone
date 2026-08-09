import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class ExerciseOverviewPage extends StatelessWidget {
  const ExerciseOverviewPage({super.key});

  @override
  Widget build(BuildContext context) => FScaffold(
    header: const FHeader(title: Text('Training')),
    child: const Center(child: Text('Training')),
  );
}
