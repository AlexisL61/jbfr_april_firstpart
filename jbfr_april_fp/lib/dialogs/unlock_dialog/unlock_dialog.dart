import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/dialogs/unlock_dialog/unlock_dialog_controller.dart';

class UnlockDialog extends StatefulWidget {
  final String folderName;
  const UnlockDialog({super.key, required this.folderName});

  @override
  State<UnlockDialog> createState() => _UnlockDialogState();
}

class _UnlockDialogState extends State<UnlockDialog> {
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";
  UnlockDialogController controller = UnlockDialogController();

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Débloquer ce dossier"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Ce dossier a besoin d'un mot de passe pour être débloqué"),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Mot de passe",
            ),
          ),
          const SizedBox(height: 20),
          Text(errorMessage, style: const TextStyle(color: Colors.red))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            bool passResult = await controller.tryPassword(passwordController.text, widget.folderName);
            if (passResult) {
              Navigator.of(context).pop();
            } else {
              setState(() {
                errorMessage = "Mauvais mot de passe";
              });
            }
          },
          child: const Text("Débloquer"),
        ),
      ],
    );
  }
}
