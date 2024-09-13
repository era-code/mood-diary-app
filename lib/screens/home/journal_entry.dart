class JournalEntry {
  final DateTime date;
  final List<String> moodTabs;
  final List<String> moodImages;
  final List<String> chips;
  final double stressLevel;
  final double selfEsteemLevel;
  final String notes;

  JournalEntry({
    required this.date,
    required this.moodTabs,
    required this.moodImages,
    required this.chips,
    required this.stressLevel,
    required this.selfEsteemLevel,
    required this.notes,
  });

  
  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'moodTabs': moodTabs,
    'moodImages': moodImages,
    'chips': chips,
    'stressLevel': stressLevel,
    'selfEsteemLevel': selfEsteemLevel,
    'notes': notes,
  };

  
  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      date: DateTime.parse(json['date']),
      moodTabs: List<String>.from(json['moodTabs']),
      moodImages: List<String>.from(json['moodImages']),
      chips: List<String>.from(json['chips']),
      stressLevel: json['stressLevel'].toDouble(),
      selfEsteemLevel: json['selfEsteemLevel'].toDouble(),
      notes: json['notes'],
    );
  }
}
