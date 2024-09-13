import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.containerWidth,
    required bool isSaveButtonEnabled,
    required this.onSave,
  }) : _isSaveButtonEnabled = isSaveButtonEnabled;

  final double containerWidth;
  final bool _isSaveButtonEnabled;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: containerWidth,
        height: 44,
        child: ElevatedButton(
          onPressed: _isSaveButtonEnabled ? onSave : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Color(0xffF2F2F2);
                }
                return Color(0xffFF8702); 
              },
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70),
              ),
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Color(
                      0xffBCBCBF); 
                }
                return Colors.white; 
              },
            ),
          ),
          child: const Text(
            'Сохранить',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
