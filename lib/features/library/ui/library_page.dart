import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) => FScaffold(
    header: const FHeader(title: Text('Musikbibliothek')),
    child: const Center(child: Text('Musikbibliothek')),
  );
}
