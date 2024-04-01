import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/dialogs/unlock_dialog/unlock_dialog.dart';
import 'package:jbfr_april_fp/features/usb_key/components/file_widget.dart';
import 'package:jbfr_april_fp/features/usb_key/usb_key_controller.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class UsbKeyWidget extends StatefulWidget {
  const UsbKeyWidget({super.key});

  @override
  State<UsbKeyWidget> createState() => _UsbKeyWidgetState();
}

class _UsbKeyWidgetState extends State<UsbKeyWidget> {
  UsbKeyController controller = UsbKeyController();
  int selectedFolder = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildFoldersTab(),
        Expanded(child: _buildFiles()),
      ],
    );
  }

  Widget _buildFoldersTab() {
    return Container(
        color: Theme.of(context).colorScheme.shadow,
        child: Column(
            children: List.generate(
                UserService().player!.gameFolders.length,
                (index) => InkWell(
                      onTap: () async {
                        if (UserService().player!.gameFolders[index].files.length == 0) {
                          await showDialog(
                              context: context,
                              builder: (context) =>
                                  UnlockDialog(folderName: UserService().player!.gameFolders[index].id));
                          setState(() {
                            
                          });
                        } else {
                          if (UserService().player!.gameFolders[index].unlocked){
                            setState(() {
                              selectedFolder = index;
                            });
                          }
                        }
                      },
                      child: Container(
                          width: 160,
                          color: index == selectedFolder ? Colors.blue : Colors.transparent,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (!UserService().player!.gameFolders[index].unlocked)
                                    Icon(Icons.timer)
                                  else if (UserService().player!.gameFolders[index].files.length == 0)
                                    Icon(Icons.lock),
                                  SizedBox(width: 8),
                                  Text(UserService().player!.gameFolders[index].name),
                                ],
                              ))),
                    ))));
  }

  Widget _buildFiles() {
    return GridView.count(
      crossAxisCount: ((MediaQuery.of(context).size.width-300) ~/ 350)+1,
      childAspectRatio: 0.75,
      children: List.generate(UserService().player!.gameFolders[selectedFolder].files.length,
          (index) => FileWidget(file: UserService().player!.gameFolders[selectedFolder].files[index])),
    );
  }
}
