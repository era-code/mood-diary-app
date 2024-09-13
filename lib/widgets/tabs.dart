import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomTabs extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabs({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  
  final GlobalKey _journalKey = GlobalKey();
  final GlobalKey _emotionKey = GlobalKey();
  final GlobalKey _statisticKey = GlobalKey();
 @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback(
         (_) {
       ShowCaseWidget.of(context).startShowCase(
         [_emotionKey,_statisticKey,_journalKey ],  
       );
     },
   );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: containerWidth,
            height: 44,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 100),
                  left: widget.selectedIndex == 0
                      ? 0
                      : widget.selectedIndex == 1
                      ? containerWidth * 0.35
                      : containerWidth * 0.7, 
                  child: Container(
                    width: widget.selectedIndex == 2
                        ? 0
                        : containerWidth * 0.65, 
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: widget.selectedIndex == 0 ? 10 : 5,
                      fit: FlexFit.loose,
                      child: GestureDetector(
                        onTap: () => widget.onTabSelected(0),
                        child: Showcase( key: _emotionKey, description: 'Здес вы можете загрузить ваше настроение',
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.book,
                                  color: widget.selectedIndex == 0
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Дневник настроения',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: widget.selectedIndex == 0
                                            ? Colors.white
                                            : Colors.grey,
                                        fontFamily: 'Nunito',
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: widget.selectedIndex == 1 ? 10 : 5,
                      fit: FlexFit.loose,
                      child: GestureDetector(
                        onTap: () => widget.onTabSelected(1),
                        child: Showcase( key: _statisticKey, description: 'Здесь находится ваша статистика(Правда сейчас не рабочая 😉)',
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bar_chart,
                                  color: widget.selectedIndex == 1
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Статистика',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: widget.selectedIndex == 1
                                            ? Colors.white
                                            : Colors.grey,
                                        fontFamily: 'Nunito',
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), 
        Center(
          child: GestureDetector(
            onTap: () => widget.onTabSelected(2),
            child: Showcase(
              key: _journalKey, 
              description: 'Здесь хранятся все ваши записки',
              child: Container(
                width: containerWidth * 0.6,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.selectedIndex == 2
                      ? Colors.orange
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article,
                      color: widget.selectedIndex == 2
                          ? Colors.white
                          : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Журнал',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.selectedIndex == 2
                              ? Colors.white
                              : Colors.grey,
                          fontFamily: 'Nunito',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
