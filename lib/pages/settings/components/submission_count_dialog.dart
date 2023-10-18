import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeCountDialogBox extends StatefulWidget {
  const ChangeCountDialogBox({
    super.key,
    required this.previousSubmissionCount,
    required this.title,
    this.semanticLabel,
    this.subtitle,
  });

  final int previousSubmissionCount;
  final String title;
  final String? subtitle;
  final String? semanticLabel;

  @override
  State<ChangeCountDialogBox> createState() => _ChangeCountDialogBoxState();
}

class _ChangeCountDialogBoxState extends State<ChangeCountDialogBox> {
  final _countController = TextEditingController();
  final _countFormKey = GlobalKey<FormState>();

  void submitCountValue() {
    if (_countFormKey.currentState?.validate() ?? false) {
      Navigator.pop(context, int.parse(_countController.text));
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      semanticLabel: widget.semanticLabel,
      children: [
        if (widget.subtitle != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Text(widget.subtitle!),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
          child: Column(children: [
            Form(
              key: _countFormKey,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: true,
                controller: _countController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                validator: (String? count) {
                  if (count == null || count.isEmpty) {
                    return 'Submission to show cannot be empty. If you do not want any submission to be shown by default, enter 0';
                  }
                  return null;
                },
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                onFieldSubmitted: (value) => submitCountValue(),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  label: Text('Submission count'),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 8),
                  errorMaxLines: 2,
                ),
                enableSuggestions: true,
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: ElevatedButton(
            onPressed: () => submitCountValue(),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Change'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
