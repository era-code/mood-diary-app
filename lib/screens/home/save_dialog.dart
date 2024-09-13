

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_event.dart';
import 'package:mood_diary/screens/home/journal_tab.dart';
import 'package:mood_diary/screens/home/mood_entry.dart';

class SaveDialog extends StatelessWidget {
  final List<String> selectedMoodTabs;
  final List<String> selectedMoodImages; 
  final List<String> selectedChips;
  final double stressLevel;
  final double selfEsteemLevel;
  final String notes;

  const SaveDialog({
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
    
    int displayLength = selectedMoodTabs.length < selectedMoodImages.length
        ? selectedMoodTabs.length
        : selectedMoodImages.length;

    return AlertDialog(
      contentTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Nunito-bold',
      ),
      backgroundColor: Colors.white.withOpacity(0.75),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            const SizedBox(height: 20),
            MoodEntryWidget(
              selectedMoodTabs: selectedMoodTabs,
              selectedMoodImages: selectedMoodImages,
              selectedChips: selectedChips,
              stressLevel: stressLevel,
              selfEsteemLevel: selfEsteemLevel,
              notes: notes,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: 100,
          height: 50,
          child: TextButton(
            child: const Text('OK', style: TextStyle(color: Colors.black, fontSize: 20),),
            onPressed: () {
              context.read<MoodDiaryBloc>().add(Save( selectedMoodTabs: selectedMoodTabs,
                selectedMoodImages: selectedMoodImages,
                selectedChips: selectedChips,
                stressLevel: stressLevel,
                selfEsteemLevel: selfEsteemLevel,
                notes: notes,));
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalScreen()),
              );
            },
          ),
        ),
      ],
    ).animate().scale(duration: 500.ms, curve: Curves.easeInOut);
  }
}
