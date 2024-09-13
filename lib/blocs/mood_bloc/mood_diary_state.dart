

import 'package:equatable/equatable.dart';

import '../../screens/home/journal_entry.dart';

class MoodDiaryState extends Equatable {
  final List<String> selectedMoodTabs;
  final List<String> selectedMoodImages;
  final int selectedIndex;
  final List<String> selectedChips;
  final double stressLevel;
  final double selfEsteemLevel;
  final String note;
  final bool isSaveButtonEnabled;
  final List<JournalEntry> journalEntries; 

  const MoodDiaryState({
    required this.selectedMoodTabs,
    required this.selectedMoodImages,
    this.selectedIndex = 0,
    this.selectedChips = const [],
    this.stressLevel = 0.0,
    this.selfEsteemLevel = 0.0,
    this.note = '',
    this.isSaveButtonEnabled = false,
    this.journalEntries = const [], 
  });

  MoodDiaryState copyWith({
    List<String>? selectedMoodTabs,
    List<String>? selectedMoodImages,
    int? selectedIndex,
    List<String>? selectedChips,
    double? stressLevel,
    double? selfEsteemLevel,
    String? note,
    bool? isSaveButtonEnabled,
    List<JournalEntry>? journalEntries, 
  }) {
    return MoodDiaryState(
      selectedMoodTabs: selectedMoodTabs ?? this.selectedMoodTabs,
      selectedMoodImages: selectedMoodImages ?? this.selectedMoodImages,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedChips: selectedChips ?? this.selectedChips,
      stressLevel: stressLevel ?? this.stressLevel,
      selfEsteemLevel: selfEsteemLevel ?? this.selfEsteemLevel,
      note: note ?? this.note,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
      journalEntries: journalEntries ?? this.journalEntries, 
    );
  }

  @override
  List<Object?> get props => [
    selectedMoodTabs,
    selectedMoodImages,
    selectedIndex,
    selectedChips,
    stressLevel,
    selfEsteemLevel,
    note,
    isSaveButtonEnabled,
    journalEntries, 
  ];
}
