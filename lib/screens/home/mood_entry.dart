

import 'package:flutter/material.dart';

class MoodEntryWidget extends StatelessWidget {
  final List<String> selectedMoodTabs;
  final List<String> selectedMoodImages;
  final List<String> selectedChips;
  final double stressLevel;
  final double selfEsteemLevel;
  final String notes;

  const MoodEntryWidget({
    Key? key,
    required this.selectedMoodTabs,
    required this.selectedMoodImages,
    required this.selectedChips,
    required this.stressLevel,
    required this.selfEsteemLevel,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMoodInfo(),
        const SizedBox(height: 10),
        _buildChipInfo(),
        const SizedBox(height: 10),
        _buildStressLevelInfo(),
        const SizedBox(height: 10),
        _buildSelfEsteemLevelInfo(),
        const SizedBox(height: 10),
        _buildNotesInfo(),
      ],
    );
  }

  Widget _buildMoodInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ваше настроение:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito-bold',
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(selectedMoodTabs.length, (index) {
            return  Column(
              children: [
                Image.asset(
                    selectedMoodImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                Text( selectedMoodTabs[index],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),)
              ],
            );

          }),

        ),

      ],
    );
  }

  Widget _buildChipInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Вы испытываете:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito-bold',
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: selectedChips.map((chip) {
            return Chip(elevation: 0,
              label: Text(
                chip,
                style: const TextStyle(color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                ),
              ),
              backgroundColor: Color(0xffFF8702),

            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStressLevelInfo() {
    return Row(
      children: [
        const Text('😖',
          style: TextStyle(  color: Colors.green, fontSize: 35),

        ),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(borderRadius: BorderRadius.circular(20),
            value: stressLevel / 6, 
            backgroundColor: Colors.black12,
            color: Colors.red,
            minHeight: 10,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${stressLevel.toStringAsFixed(0)} / 10',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  Widget _buildSelfEsteemLevelInfo() {
    return Row(
      children: [
        const Text('😌',
     style: TextStyle(  color: Colors.green, fontSize: 35),

        ),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(borderRadius: BorderRadius.circular(20),
            value: selfEsteemLevel / 6, 
            backgroundColor: Colors.black12,
            color: Colors.green,
            minHeight: 10,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${selfEsteemLevel.toStringAsFixed(0)} / 10',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  Widget _buildNotesInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ваша заметка:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito-bold',
          ),
        ),
        const SizedBox(height: 5),
        Text(
          notes.isNotEmpty ? notes : 'Нет заметок.',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}
