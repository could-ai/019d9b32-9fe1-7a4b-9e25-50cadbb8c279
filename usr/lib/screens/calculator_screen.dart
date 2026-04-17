import 'package:flutter/material.dart';
import '../data/streams_data.dart';
import '../models/bac_stream.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const CalculatorScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late BacStream selectedStream;
  final TextEditingController ccController = TextEditingController();
  Map<String, TextEditingController> regionalControllers = {};
  Map<String, TextEditingController> nationalControllers = {};
  final _formKey = GlobalKey<FormState>();

  double? finalAverage;
  double? regionalAverage;
  double? nationalAverage;

  @override
  void initState() {
    super.initState();
    _initStream(moroccanStreams.first);
  }

  void _initStream(BacStream stream) {
    selectedStream = stream;
    _clearAndRebuildControllers();
  }

  void _clearAndRebuildControllers() {
    for (var c in regionalControllers.values) { c.dispose(); }
    for (var c in nationalControllers.values) { c.dispose(); }

    regionalControllers = {
      for (var s in selectedStream.regionalSubjects) s.name: TextEditingController()
    };
    nationalControllers = {
      for (var s in selectedStream.nationalSubjects) s.name: TextEditingController()
    };
    ccController.clear();
    _resetResults();
  }

  void _changeStream(BacStream? newStream) {
    if (newStream != null && newStream.id != selectedStream.id) {
      setState(() {
        _initStream(newStream);
      });
    }
  }

  void _resetResults() {
    setState(() {
      finalAverage = null;
      regionalAverage = null;
      nationalAverage = null;
    });
  }

  void _resetAll() {
    setState(() {
      _clearAndRebuildControllers();
    });
  }

  double _calculateAverage(List<BacSubject> subjects, Map<String, TextEditingController> controllers) {
    double totalGrades = 0;
    int totalCoeffs = 0;

    for (var subject in subjects) {
      final text = controllers[subject.name]?.text.replaceAll(',', '.') ?? '0';
      final grade = double.tryParse(text) ?? 0;
      totalGrades += grade * subject.coefficient;
      totalCoeffs += subject.coefficient;
    }

    if (totalCoeffs == 0) return 0.0;
    return totalGrades / totalCoeffs;
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final ccText = ccController.text.replaceAll(',', '.');
    final ccGrade = double.tryParse(ccText) ?? 0.0;

    final regAvg = _calculateAverage(selectedStream.regionalSubjects, regionalControllers);
    final natAvg = _calculateAverage(selectedStream.nationalSubjects, nationalControllers);

    final finalAvg = (ccGrade * 0.25) + (regAvg * 0.25) + (natAvg * 0.50);

    setState(() {
      regionalAverage = regAvg;
      nationalAverage = natAvg;
      finalAverage = finalAvg;
    });
  }

  String _getMention(double average) {
    if (average < 10) return "Rattrapage / Non Admis";
    if (average < 12) return "Passable";
    if (average < 14) return "Assez Bien";
    if (average < 16) return "Bien";
    return "Très Bien";
  }

  Color _getMentionColor(double average) {
    if (average < 10) return Colors.red;
    if (average < 12) return Colors.orange;
    if (average < 14) return Colors.blue;
    if (average < 16) return Colors.green;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moroccan Bac Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
            tooltip: 'Toggle Dark Mode',
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildStreamSelector(),
                const SizedBox(height: 16),
                _buildCCSection(),
                const SizedBox(height: 16),
                _buildSubjectsSection(
                  title: 'Examen Régional (25%)',
                  subjects: selectedStream.regionalSubjects,
                  controllers: regionalControllers,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                const SizedBox(height: 16),
                _buildSubjectsSection(
                  title: 'Examen National (50%)',
                  subjects: selectedStream.nationalSubjects,
                  controllers: nationalControllers,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _resetAll,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calculate Average'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.2),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                        child: child,
                      ),
                    );
                  },
                  child: finalAverage != null 
                      ? _buildResultsSection() 
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreamSelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Stream', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<BacStream>(
              value: selectedStream,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: moroccanStreams.map((stream) {
                return DropdownMenuItem(
                  value: stream,
                  child: Text(stream.name),
                );
              }).toList(),
              onChanged: _changeStream,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCCSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contrôle Continu (25%)', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _buildGradeField(
              label: 'Moyenne Générale',
              controller: ccController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsSection({
    required String title,
    required List<BacSubject> subjects,
    required Map<String, TextEditingController> controllers,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: subjects.map((subject) {
                return SizedBox(
                  width: 200,
                  child: _buildGradeField(
                    label: '${subject.name} (x${subject.coefficient})',
                    controller: controllers[subject.name]!,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeField({required String label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final val = double.tryParse(value.replaceAll(',', '.'));
        if (val == null) return 'Invalid number';
        if (val < 0 || val > 20) return '0 to 20 only';
        return null;
      },
    );
  }

  Widget _buildResultsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Your Results',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildResultItem('Regional', regionalAverage!),
                _buildResultItem('National', nationalAverage!),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Final Average',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              finalAverage!.toStringAsFixed(2),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                _getMention(finalAverage!),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: _getMentionColor(finalAverage!),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, double value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(2),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
