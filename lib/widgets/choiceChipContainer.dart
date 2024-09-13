import 'package:flutter/material.dart';

class ChoiceChipContainer extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<String> onSelected;

  const ChoiceChipContainer({
    Key? key,
    required this.options,
    required this.selectedOptions,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 329,
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0,
          runSpacing: 4.0,
          children: options.map((option) {
            return ChoiceChip(
              showCheckmark: false,
              label: Text(option),
              selected: selectedOptions.contains(option),
              onSelected: (selected) {
                onSelected(option);
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.orange,
              labelStyle: TextStyle(
                color: selectedOptions.contains(option)
                    ? Colors.white
                    : Colors.black,
                fontFamily: 'Nunito',
                fontSize: 11,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
                side: BorderSide(
                  color: selectedOptions.contains(option)
                      ? Colors.orange
                      : Colors.white,
                  width: 1,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
