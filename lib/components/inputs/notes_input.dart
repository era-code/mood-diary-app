import 'package:flutter/material.dart';

class NotesInput extends StatelessWidget {
  const NotesInput({
    super.key,
    required this.containerWidth,
    required TextEditingController notesController,
    required this.focusNode, 
  }) : _notesController = notesController;

  final double containerWidth;
  final TextEditingController _notesController;
  final FocusNode focusNode; 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: containerWidth,
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: _notesController,
        focusNode: focusNode, 
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Введите заметку',
          hintStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
