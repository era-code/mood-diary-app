import 'dart:convert';

class MoodEntry {
  final DateTime date;
  final Set<String> selectedMoodTabs;
  final Map<String, List<String>> selectedChips;
  final List<String> selectedImages;
  final double stressLevel;
  final double selfEsteemLevel;
  final String notes;

  MoodEntry({
    required this.date,
    required this.selectedMoodTabs,
    required this.selectedChips,
    required this.selectedImages,
    required this.stressLevel,
    required this.selfEsteemLevel,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'selectedMoodTabs': selectedMoodTabs.toList(),
      'selectedChips': selectedChips,
      'selectedImages': selectedImages,
      'stressLevel': stressLevel,
      'selfEsteemLevel': selfEsteemLevel,
      'notes': notes,
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      date: DateTime.parse(json['date']),
      selectedMoodTabs: Set<String>.from(json['selectedMoodTabs']),
      selectedChips: Map<String, List<String>>.from(json['selectedChips']),
      selectedImages: List<String>.from(json['selectedImages']),
      stressLevel: json['stressLevel'],
      selfEsteemLevel: json['selfEsteemLevel'],
      notes: json['notes'],
    );
  }
}
