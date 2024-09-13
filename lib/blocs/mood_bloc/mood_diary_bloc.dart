

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/home/journal_entry.dart';
import 'mood_diary_event.dart';
import 'mood_diary_state.dart';

class MoodDiaryBloc extends Bloc<MoodDiaryEvent, MoodDiaryState> {
  MoodDiaryBloc() : super(MoodDiaryState(selectedMoodTabs: [], selectedMoodImages: [])) {
    on<NoteChanged>(_onNoteChanged);
    on<MultipleMoodTabsSelected>(_onMultipleMoodTabsSelected);
    on<TabSelected>(_onTabSelected);
    on<MoodTabSelected>(_onMoodTabSelected);
    on<ChipsSelected>(_onChipsSelected);
    on<StressLevelChanged>(_onStressLevelChanged);
    on<SelfEsteemLevelChanged>(_onSelfEsteemLevelChanged);
    on<Save>(_onSave);
  }

  void _onNoteChanged(NoteChanged event, Emitter<MoodDiaryState> emit) {
    final isSaveButtonEnabled = event.note.trim().isNotEmpty;
    emit(state.copyWith(
      note: event.note,
      isSaveButtonEnabled: isSaveButtonEnabled,
    ));
  }

  void _onMultipleMoodTabsSelected(MultipleMoodTabsSelected event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(
      selectedMoodTabs: event.moodTabs,
      selectedMoodImages: event.imagePaths,
    ));
  }

  void _onTabSelected(TabSelected event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onMoodTabSelected(MoodTabSelected event, Emitter<MoodDiaryState> emit) {
    final List<String> updatedMoodTabs = List.from(state.selectedMoodTabs);
    final List<String> updatedMoodImages = List.from(state.selectedMoodImages);

    if (updatedMoodTabs.contains(event.moodTab)) {
      final index = updatedMoodTabs.indexOf(event.moodTab);
      updatedMoodTabs.removeAt(index);
      if (index < updatedMoodImages.length) {
        updatedMoodImages.removeAt(index);
      }
    } else {
      updatedMoodTabs.add(event.moodTab);
      if (event.moodImage != null) {
        updatedMoodImages.add(event.moodImage!);
      }
    }

    emit(state.copyWith(
      selectedMoodTabs: updatedMoodTabs,
      selectedMoodImages: updatedMoodImages,
    ));
  }

  void _onChipsSelected(ChipsSelected event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(selectedChips: event.chips));
  }

  void _onStressLevelChanged(StressLevelChanged event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(stressLevel: event.stressLevel));
  }

  void _onSelfEsteemLevelChanged(SelfEsteemLevelChanged event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(selfEsteemLevel: event.selfEsteemLevel));
  }

  void _onSave(Save event, Emitter<MoodDiaryState> emit) async {
    
    final newEntry = JournalEntry(
      date: DateTime.now(),
      moodTabs: event.selectedMoodTabs,
      moodImages: event.selectedMoodImages,
      chips: event.selectedChips,
      stressLevel: event.stressLevel,
      selfEsteemLevel: event.selfEsteemLevel,
      notes: event.notes,
    );

    
    final updatedJournalEntries = List<JournalEntry>.from(state.journalEntries)..add(newEntry);

    
    await _saveToSharedPreferences(updatedJournalEntries);

    
    emit(state.copyWith(
      journalEntries: updatedJournalEntries,
      selectedMoodTabs: [],
      selectedMoodImages: [],
      selectedChips: [],
      stressLevel: 0.0,
      selfEsteemLevel: 0.0,
      note: '',
      isSaveButtonEnabled: false,
    ));
  }


  Future<void> _saveToSharedPreferences(List<JournalEntry> journalEntries) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(journalEntries.map((entry) => entry.toJson()).toList());
    await prefs.setString('journal_entries', encodedData);
  }

}
