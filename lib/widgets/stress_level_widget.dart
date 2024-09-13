import 'package:flutter/material.dart';
import 'package:mood_diary/widgets/custm_thumb_shape.dart';

class StressLevelWidget extends StatefulWidget {
  final String title;
  final String lowLabel;
  final String highLabel;
  final Function(double) onChanged;

  const StressLevelWidget({
    Key? key,
    required this.title,
    required this.lowLabel,
    required this.highLabel,
    required this.onChanged,
  }) : super(key: key);

  @override
  _StressLevelWidgetState createState() => _StressLevelWidgetState();
}

class _StressLevelWidgetState extends State<StressLevelWidget> {
  double _currentValue = 3.0;

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    Color activeColor = _currentValue != 3.0 ? Colors.orange : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito-bold',
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              height: 77,
              width: containerWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => Container(
                          height: 8,
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: activeColor,
                        inactiveTrackColor: Colors.grey,
                        thumbColor: activeColor,
                        overlayColor: activeColor.withOpacity(0.2),
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 4.0,
                        thumbShape: CustomThumbShape(
                          enabledThumbRadius: 10.0,
                          borderWidth: 5.0,
                          borderColor: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _currentValue,
                        min: 0.0,
                        max: 10.0,
                        label: _currentValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentValue = value;
                          });
                          widget.onChanged(value);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.lowLabel,
                          style: const TextStyle(
                              fontFamily: 'Nunito', fontSize: 11),
                        ),
                        Text(
                          widget.highLabel,
                          style: const TextStyle(
                              fontFamily: 'Nunito', fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
