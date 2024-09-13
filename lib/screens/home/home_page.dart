import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_bloc.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_event.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_state.dart';
import 'package:mood_diary/screens/home/date_time_display.dart';
import 'package:mood_diary/screens/home/statistic_tab.dart';
import 'package:mood_diary/screens/home/mood_diary_tab.dart';
import 'package:mood_diary/screens/home/save_dialog.dart';
import 'package:mood_diary/widgets/tabs.dart';
import 'package:showcaseview/showcaseview.dart';
import 'journal_tab.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodDiaryBloc(),
      child: MyHomePageContent(title: title),
    );
  }
}

class MyHomePageContent extends StatefulWidget {
  const MyHomePageContent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePageContent> createState() => _MyHomePageContentState();
}

class _MyHomePageContentState extends State<MyHomePageContent> {
  late TextEditingController notesController;
  late FocusNode notesFocusNode;




  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
    notesFocusNode = FocusNode();

    notesController.addListener(() {
      context.read<MoodDiaryBloc>().add(NoteChanged(notesController.text));
    });

    

  }

  @override
  void dispose() {
    notesController.dispose();
    notesFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MoodDiaryBloc>();
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: containerWidth,
            child: const DateTimeDisplay(),
          ),
          const SizedBox(height: 20),
          BlocBuilder<MoodDiaryBloc, MoodDiaryState>(
            builder: (context, state) {
              return CustomTabs(
                selectedIndex: state.selectedIndex,
                onTabSelected: (index) {
                  bloc.add(TabSelected(index));
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<MoodDiaryBloc, MoodDiaryState>(
              builder: (context, state) {
                return IndexedStack(
                  index: state.selectedIndex,
                  children: [
                    SingleChildScrollView(
                      child: MoodDiaryTab(
                        containerWidth: containerWidth,
                        selectedMoodTabs: state.selectedMoodTabs,
                        selectedMoodImages: state.selectedMoodImages,
                        selectedChips: state.selectedChips,
                        stressLevel: state.stressLevel,
                        selfEsteemLevel: state.selfEsteemLevel,
                        notesController: notesController,
                        notesFocusNode: notesFocusNode,
                        isSaveButtonEnabled: state.isSaveButtonEnabled,
                        onSave: () {
                          bloc.add(Save(
                            selectedMoodTabs: state.selectedMoodTabs,
                            selectedMoodImages: state.selectedMoodImages,
                            selectedChips: state.selectedChips,
                            stressLevel: state.stressLevel,
                            selfEsteemLevel: state.selfEsteemLevel,
                            notes: state.note,
                          ));
                          notesController.clear();
                          notesFocusNode.unfocus();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SaveDialog(
                                selectedMoodTabs: state.selectedMoodTabs,
                                selectedMoodImages: state.selectedMoodImages,
                                selectedChips: state.selectedChips,
                                stressLevel: state.stressLevel,
                                selfEsteemLevel: state.selfEsteemLevel,
                                notes: state.note,
                              );
                            },
                          );
                        },
                        onMoodTabsSelected: (tabs, images) {
                          bloc.add(MultipleMoodTabsSelected(tabs, images));
                        },
                        onChipsSelected: (chips) {
                          bloc.add(ChipsSelected(chips));
                        },
                        onStressLevelChanged: (value) {
                          bloc.add(StressLevelChanged(value));
                        },
                        onSelfEsteemLevelChanged: (value) {
                          bloc.add(SelfEsteemLevelChanged(value));
                        },
                      ),
                    ),
                    StatisticTab(
                      containerWidth: containerWidth,
                      userActivity: {
                        '01-07': 2,
                        '02-07': 4,
                        '03-07': 3,
                        '04-07': 5,
                        '05-07': 1,
                      },
                    ),
                    JournalScreen(),  
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
