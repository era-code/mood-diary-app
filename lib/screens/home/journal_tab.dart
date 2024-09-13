

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_state.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'journal_entry.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<JournalEntry> journalEntries = [];

  @override
  void initState() {
    super.initState();
    _loadJournalEntries();
  }


  Future<List<JournalEntry>> _loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('journal_entries');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((entryJson) => JournalEntry.fromJson(entryJson)).toList();
    }
    return [];
  }
  Future<void> _loadJournalEntries() async {
    final entries = await _loadFromSharedPreferences();
    setState(() {
      journalEntries = entries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Журнал'),
      ),
      body: journalEntries.isEmpty
          ? Center(
        child: Text(
          'Нет записей пока',
          style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
        ),
      )
          : ListView.builder(
        itemCount: journalEntries.length,
        itemBuilder: (context, index) {
          final entry = journalEntries[index];
          return JournalEntryCard(entry: entry);
        },
      ),
    );
  }
}


class JournalEntryCard extends StatelessWidget {
  final JournalEntry entry;

  const JournalEntryCard({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(entry.date);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito',
                color: Colors.grey[600],
                decoration: TextDecoration.underline,  
              ),
            ),

            SizedBox(height: 10),
            
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List<Widget>.generate(entry.moodTabs.length, (index) {
                return Column(
                  children: [
                   Image.asset(
                        entry.moodImages[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),





                  ],
                );
              }),
            ),
            SizedBox(height: 10),
            
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: entry.chips.map((chip) {
                return Chip(
                  label: Text(
                    chip,
                    style: const TextStyle(color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  backgroundColor: Color(0xffFF8702),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            
          Row(
            children: [
              const Text('😖',
                style: TextStyle(  color: Colors.green, fontSize: 35),

              ),
              const SizedBox(width: 10),
              Expanded(
                child: LinearProgressIndicator(borderRadius: BorderRadius.circular(20),
                  value: entry.stressLevel / 6, 
                  backgroundColor: Colors.black12,
                  color: Colors.red,
                  minHeight: 10,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${entry.stressLevel.toStringAsFixed(0)} / 10',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
            SizedBox(height: 10),
            
            Row(
              children: [
                const Text('😌',
                  style: TextStyle(  color: Colors.green, fontSize: 35),

                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(borderRadius: BorderRadius.circular(20),
                    value: entry.selfEsteemLevel / 6, 
                    backgroundColor: Colors.black12,
                    color: Colors.green,
                    minHeight: 10,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${entry.selfEsteemLevel.toStringAsFixed(0)} / 10',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            
            Column(
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
                  entry.notes.isNotEmpty ? entry.notes : 'Нет заметок.',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
