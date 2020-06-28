import 'package:flutter/material.dart';

class CustomPreferenceText extends StatelessWidget {
  final String text;
  final bool isSingleLine;

  final TextStyle style;
  final Decoration decoration;

  final Widget leading;
  final Widget trailing;
  final Text subtitle;

  final Function onTap;

  CustomPreferenceText(this.text,
      {this.style,
      this.decoration,
      this.leading,
      this.trailing,
      this.subtitle,
      this.onTap,
      this.isSingleLine = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: ListTile(
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        title: Text(
          text,
          style: style,
          overflow: isSingleLine ? TextOverflow.ellipsis : TextOverflow.visible,
        ),
        subtitle: subtitle,
      ),
    );
  }
}
