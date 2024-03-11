import 'package:flutter/material.dart';

extension Context on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get size => MediaQuery.sizeOf(this);

  /// The same of [MediaQuery.of(context).size.height]
  double get height => MediaQuery.sizeOf(this).height;

  /// The same of [MediaQuery.of(context).size.width]
  double get width => MediaQuery.sizeOf(this).width;

  /// similar to [Theme.of(context)]
  ThemeData get theme => Theme.of(this);

  /// similar to [Theme.of(context).colorScheme]
  ColorScheme get color => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension FormatNumberExtension on String {
  String formatAsPrice() {
    final number = replaceAll(',', ''); // Remove existing commas if any
    if (int.tryParse(number) != null) {
      final formatted = int.parse(number).toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          );
      return formatted;
    }
    return this; // Return as is if not a valid number
  }

  String removeBracketsAndCapitalize() {
    // Remove brackets
    String modifiedString = replaceAll(RegExp(r'[()]'), '');

    // Capitalize first character
    if (modifiedString.isNotEmpty) {
      modifiedString =
          modifiedString[0].toUpperCase() + modifiedString.substring(1);
    }

    // Return the modified string if you want to use it elsewhere
    return modifiedString;
  }

  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
        for (int i = 0; i < length; i++) ...[
          if (i > 0) SizedBox(width: width, height: height),
          this[i],
        ],
      ];
}
