import 'package:flutter/material.dart';

class SettingsPopup extends StatefulWidget {
  const SettingsPopup(
      {super.key,
      required this.sessionDuration,
      required this.nbOfSets,
      required this.pause,
      required this.updateSettings});

  final int sessionDuration;
  final int nbOfSets;
  final int pause;
  final void Function(int sessionDuration, int nbOfSets, int pause)
      updateSettings;

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  final _formKey = GlobalKey<FormState>();
  late int _sessionDuration = 10;
  late int _nbOfSets = 2;
  late int _pause = 10;

  @override
  void initState() {
    super.initState();
    // Initialize with some default values or from the current state
    _sessionDuration = widget.sessionDuration;
    _nbOfSets = widget.nbOfSets;
    _pause = widget.pause;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.updateSettings(_sessionDuration, _nbOfSets, _pause);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: _sessionDuration.toString(),
              decoration:
                  const InputDecoration(labelText: 'Set Duration (seconds)'),
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _sessionDuration = int.tryParse(value ?? '') ?? 0,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter session duration';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _nbOfSets.toString(),
              decoration: const InputDecoration(labelText: 'Number of Sets'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _nbOfSets = int.tryParse(value ?? '') ?? 0,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter number of sets';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _pause.toString(),
              decoration:
                  const InputDecoration(labelText: 'Pause Duration (seconds)'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _pause = int.tryParse(value ?? '') ?? 0,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter pause duration';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
