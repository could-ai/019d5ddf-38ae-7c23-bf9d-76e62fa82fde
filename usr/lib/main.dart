import 'package:flutter/material.dart';

void main() {
  runApp(const SoftoneApp());
}

class SoftoneApp extends StatelessWidget {
  const SoftoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softone HR Solution',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)), // Professional Blue Theme
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ReportGeneratorScreen(),
      },
    );
  }
}

class ReportGeneratorScreen extends StatefulWidget {
  const ReportGeneratorScreen({super.key});

  @override
  State<ReportGeneratorScreen> createState() => _ReportGeneratorScreenState();
}

class _ReportGeneratorScreenState extends State<ReportGeneratorScreen> {
  final TextEditingController _timesheetController = TextEditingController();
  String _generatedReport = '';
  bool _isLoading = false;

  void _generateReport() async {
    if (_timesheetController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter timesheet data first.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedReport = '';
    });

    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock humanized report generation based on input
    final inputText = _timesheetController.text.trim();
    final date = DateTime.now();
    final formattedDate = "${date.day}/${date.month}/${date.year}";

    final report = '''
Hi Team,

Hope you are having a great day! 

Here is my daily work update for $formattedDate. Based on today's timesheet, here is a summary of what I focused on:

$inputText

I have completed the tasks planned for today and ensured everything is up to date. Please let me know if you need any further details or clarifications regarding these tasks.

Thanks & Regards,
[Your Name]
Softone HR Solution
''';

    setState(() {
      _isLoading = false;
      _generatedReport = report;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Softone HR Solution', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Daily Report Generator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your timesheet details below to generate a humanized daily report.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _timesheetController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'E.g., \n9 AM - 11 AM: Client Meeting\n11 AM - 1 PM: Resume Screening\n2 PM - 5 PM: Interviews...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateReport,
              icon: _isLoading 
                  ? const SizedBox(
                      width: 20, 
                      height: 20, 
                      child: CircularProgressIndicator(strokeWidth: 2)
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(
                _isLoading ? 'Generating...' : 'Generate Humanized Report',
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_generatedReport.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Generated Report:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      // In a real app, this would copy to clipboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Report copied to clipboard!')),
                      );
                    },
                    tooltip: 'Copy Report',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: SelectableText(
                  _generatedReport,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
