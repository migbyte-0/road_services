import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool? obscureText; // Nullable
  final VoidCallback? onToggleObscureText;
  final VoidCallback? onClear;
final int? maxLength;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText, // Nullable
    this.onToggleObscureText,
    this.onClear,
        this.maxLength,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength:maxLength ,
      obscureText: obscureText ?? false, // Default to false if null
      decoration: InputDecoration(counterStyle: TextStyle(color: Colors.white),
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(prefixIcon, color: const Color.fromARGB(255, 22, 159, 143)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.green),
        ),
        suffixIcon: _buildSuffixIcon(),
      ),
      validator: validator,
    );
  }

 Widget? _buildSuffixIcon() {
  // Check for password fields (visiblePassword keyboardType or obscureText set)
  if (keyboardType == TextInputType.visiblePassword || obscureText != null) {
    return IconButton(
      icon: Icon(obscureText == true ? Icons.visibility_off : Icons.visibility),
      onPressed: onToggleObscureText,
    );
  } else if (onClear != null) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: onClear,
    );
  }
  return null; // Return null if no suffix icon is needed
}

}
