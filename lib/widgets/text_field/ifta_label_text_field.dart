import 'package:flutter/material.dart';

class IFTALabelTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;

  const IFTALabelTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<IFTALabelTextField> createState() => _IFTALabelTextFieldState();
}

class _IFTALabelTextFieldState extends State<IFTALabelTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleContainerTap() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleContainerTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _isFocused ? Colors.blue : Colors.grey,
            // width: _isFocused ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: _isFocused ? Colors.blue : Colors.grey,
                // fontSize: 12.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                onChanged: widget.onChanged,
                decoration: const InputDecoration(
                  isDense: true, // Reduces the height of the input field
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  border: InputBorder.none,
                  // You can customize other properties of the input field here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
