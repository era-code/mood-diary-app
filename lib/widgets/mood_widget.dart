

import 'package:flutter/material.dart';
import 'package:mood_diary/widgets/choiceChipContainer.dart';

class MoodWidget extends StatefulWidget {
  final Function(List<String>, List<String>) onTabsSelected; 
  final ValueChanged<List<String>> onChipsSelected;
  final Function(List<String>) onImagesSelected;

  const MoodWidget({
    Key? key,
    required this.onTabsSelected,
    required this.onChipsSelected,
    required this.onImagesSelected,
  }) : super(key: key);

  @override
  _MoodWidgetState createState() => _MoodWidgetState();
}

class _MoodWidgetState extends State<MoodWidget> {
  Set<int> _selectedTabs = {};
  Map<int, List<String>> selectedOptions = {};

  final List<String> tabs = [
    'Радость',
    'Страх',
    'Бешенство',
    'Грусть',
    'Спокойствие',
    'Сила'
  ];

  final List<List<String>> chips = [
    [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Удовольствие',
      'Эйфория',
      'Умиротворение',
      'Довольство',
      'Воодушевление'
    ],
    [
      'Очарование',
      'Осознанность',
      'Смелость',
      'Тревога',
      'Паника',
      'Беспокойство',
      'Испуг',
      'Опасение',
      'Напряжение'
    ],
    [
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Гнев',
      'Злоба',
      'Раздражение',
      'Ярость',
      'Фрустрация',
      'Негодование'
    ],
    [
      'Экстравагантность',
      'Печаль',
      'Тоска',
      'Меланхолия',
      'Уныние',
      'Депрессия',
      'Огорчение'
    ],
    [
      'Мир',
      'Безмятежность',
      'Гармония',
      'Расслабление',
      'Спокойствие',
      'Уравновешенность'
    ],
    ['Мощь', 'Сила', 'Воля', 'Мужество', 'Решимость', 'Энергия', 'Власть'],
  ];

  final List<String> imagePaths = [
    'assets/emojis/happy.png',
    'assets/emojis/fear.png',
    'assets/emojis/madness.png',
    'assets/emojis/sadness.png',
    'assets/emojis/calmness.png',
    'assets/emojis/power.png',
  ];

  void _handleChipSelection(String option, int tabIndex) {
    setState(() {
      final options = selectedOptions[tabIndex] ?? [];
      if (options.contains(option)) {
        options.remove(option);
      } else {
        options.add(option);
      }
      selectedOptions[tabIndex] = options;
    });

    
    List<String> allSelectedChips = selectedOptions.values.expand((x) => x).toList();
    widget.onChipsSelected(allSelectedChips);
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedTabNames = _selectedTabs.map((i) => tabs[i]).toList();
    List<String> selectedImages =
    _selectedTabs.map((i) => imagePaths[i]).toList();

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTabsSelected(selectedTabNames, selectedImages);
      widget.onImagesSelected(selectedImages);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(tabs.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedTabs.contains(index)) {
                      _selectedTabs.remove(index);
                      selectedOptions.remove(index);
                    } else {
                      _selectedTabs.add(index);
                      selectedOptions[index] = [];
                    }
                  });
                  
                  List<String> updatedTabs = _selectedTabs.map((i) => tabs[i]).toList();
                  List<String> updatedImages = _selectedTabs.map((i) => imagePaths[i]).toList();
                  widget.onTabsSelected(updatedTabs, updatedImages);

                  
                  List<String> allSelectedChips = selectedOptions.values.expand((x) => x).toList();
                  widget.onChipsSelected(allSelectedChips);
                  widget.onImagesSelected(updatedImages);
                },
                child: Container(
                  height: 118,
                  width: 83,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: _selectedTabs.contains(index)
                          ? Colors.orange
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(76),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        imagePaths[index],
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        tabs[index],
                        style: const TextStyle(
                            fontFamily: 'Nunito', fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        
        if (_selectedTabs.isNotEmpty) ...[
          const SizedBox(height: 10),
          Column(
            children: _selectedTabs.map((index) {
              return Container(
                width: 329,
                margin: const EdgeInsets.only(bottom: 10),
                child: ChoiceChipContainer(
                  options: chips[index],
                  selectedOptions: selectedOptions[index] ?? [],
                  onSelected: (option) => _handleChipSelection(option, index),
                ),
              );
            }).toList(),
          ),
        ]
      ],
    );
  }
}
