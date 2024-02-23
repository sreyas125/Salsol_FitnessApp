import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({Key? key}) : super(key: key);

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  final TextEditingController _heightController = TextEditingController(text: '6.0');
  final TextEditingController _weightController = TextEditingController();
  String selectedWeight = '161 Ibs';
  final int minHeight = 30;

  void _showHeightDialog(BuildContext context) {
    final TextEditingController feetController = TextEditingController();
    final TextEditingController inchesController = TextEditingController();

    // Extract feet and inches parts from the current height
    final List<String> currentHeightParts = _heightController.text.split('.');
    feetController.text = currentHeightParts[0];
    inchesController.text = currentHeightParts.length > 1 ? currentHeightParts[1] : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: feetController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Feet',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: inchesController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Inches',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final String feetPart = feetController.text;
                    final String inchesPart = inchesController.text;
                    _heightController.text = '$feetPart.$inchesPart';
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About You'),
        backgroundColor: Colors.white10,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We'd like this information to provide more accurate results,\nsuch as run distance, pace and calories. For coaching plans, this information, in addition to your age, helps personalize your plan to be right for you.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Height', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        _showHeightDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text('Weight', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: selectedWeight,
                        onChanged: (newValue) {
                          setState(() {
                            selectedWeight = newValue!;
                            _weightController.text = newValue;
                          });
                        },
                        items: List.generate(481, (index) => '${index + minHeight} Ibs')
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
