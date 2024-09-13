

import 'package:equatable/equatable.dart';

abstract class MoodDiaryEvent extends Equatable {
  const MoodDiaryEvent();

  @override
  List<Object?> get props => [];
}

class NoteChanged extends MoodDiaryEvent {
  final String note;

  const NoteChanged(this.note);

  @override
  List<Object?> get props => [note];
}
class MultipleMoodTabsSelected extends MoodDiaryEvent {
  final List<String> moodTabs;
  final List<String> imagePaths;

  const MultipleMoodTabsSelected(this.moodTabs, this.imagePaths);

  @override
  List<Object?> get props => [moodTabs, imagePaths];
}

class TabSelected extends MoodDiaryEvent {
  final int index;

  const TabSelected(this.index);

  @override
  List<Object?> get props => [index];
}

class MoodTabSelected extends MoodDiaryEvent {
  final String moodTab;
  final String? moodImage;

  const MoodTabSelected(this.moodTab, this.moodImage);

  @override
  List<Object?> get props => [moodTab, moodImage];
}

class ChipsSelected extends MoodDiaryEvent {
  final List<String> chips;

  const ChipsSelected(this.chips);

  @override
  List<Object?> get props => [chips];
}

class StressLevelChanged extends MoodDiaryEvent {
  final double stressLevel;

  const StressLevelChanged(this.stressLevel);

  @override
  List<Object?> get props => [stressLevel];
}

class SelfEsteemLevelChanged extends MoodDiaryEvent {
  final double selfEsteemLevel;

  const SelfEsteemLevelChanged(this.selfEsteemLevel);

  @override
  List<Object?> get props => [selfEsteemLevel];
}

class Save extends MoodDiaryEvent {
  final List<String> selectedMoodTabs;
  final List<String> selectedMoodImages;
  final List<String> selectedChips;
  final double stressLevel;
  final double selfEsteemLevel;
  final String notes;

  Save({
    required this.selectedMoodTabs,
    required this.selectedMoodImages,
    required this.selectedChips,
    required this.stressLevel,
    required this.selfEsteemLevel,
    required this.notes,
  });
}

