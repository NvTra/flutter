import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAlertDialogDemo extends StatefulWidget {
  const CupertinoAlertDialogDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CupertinoAlertDialogDemoState();
  }
}

class _CupertinoAlertDialogDemoState extends State<CupertinoAlertDialogDemo> {
  Future<void> _dialogBuilder(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Thông báo'),
          content: Text("Bạn có muốn tiếp tục"),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text("Hủy"),
            ),
            CupertinoDialogAction(
              onPressed: () => {Navigator.pop(context)},
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialog demo')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _dialogBuilder(context),
          child: Text('Open Dialog'),
        ),
      ),
    );
  }
}
