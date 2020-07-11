import 'package:flutter/material.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final String buttonText;

  ResponseDialog({ this.title = '', this.message = '', this.icon, this.iconColor, this.buttonText = 'OK' });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        visible: title.isNotEmpty,
        child: Text(title),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Icon(
                icon,
                color: iconColor,
                size: 64,
              ),
            ),
          ),
          Visibility(
            visible: message.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonText),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  FailureDialog({ this.title = 'Failure', this.message, this.icon = Icons.warning });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      iconColor: Colors.red,
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  SuccessDialog({ this.title = 'Success', this.message, this.icon = Icons.done });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      iconColor: Colors.green,
    );
  }
}