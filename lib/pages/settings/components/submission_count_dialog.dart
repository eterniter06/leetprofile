import 'package:flutter/material.dart';

class SubmissionCountDialogBox extends StatefulWidget {
  const SubmissionCountDialogBox({
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
  State<SubmissionCountDialogBox> createState() =>
      _SubmissionCountDialogBoxState();
}

class _SubmissionCountDialogBoxState extends State<SubmissionCountDialogBox> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitCountValue() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, int.parse(_textController.text));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
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
              key: _formKey,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                controller: _textController,
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
