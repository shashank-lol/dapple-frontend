import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/new_widgets/section_tile.dart';
import 'package:dapple/features/home/presentation/widgets/level_status_icon.dart';
import 'package:flutter/material.dart';

class LevelWidget extends StatefulWidget {
  const LevelWidget(
      {super.key,
      required this.currentlevel,
      required this.heading,
      required this.status,
      required this.description,
      required this.level,
      required this.currentsection});

  final int currentlevel;
  final int currentsection;
  final String heading;
  final String description;
  final LevelStatus status;
  final int level;

  @override
  State<LevelWidget> createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {
  bool initialstate = false;

  @override
  void initState() {
    if (widget.status == LevelStatus.current) initialstate = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: widget.status == LevelStatus.locked ? 0.6 : 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.status != LevelStatus.locked)
                    initialstate = !initialstate;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppPalette.primaryGradient,
                  color: AppPalette.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: (width - 36) * 3 / 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LevelStatusIcon(
                              status: widget.status,
                              levelnumber: widget.level,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(widget.heading,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white, fontSize: 20)),
                            Text(widget.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Color(0xFFB3B3B3),
                                        fontSize: 12)),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/dapple-girl/point.png',
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: initialstate,
            child: Container(
                decoration: BoxDecoration(
                    color: AppPalette.white,
                    image: DecorationImage(
                        image: AssetImage('assets/icons/section_block_bg.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                  child: Column(
                    children: [
                      SectionTile(
                        status: getSectionStatus(
                            widget.currentlevel, widget.currentsection, 1),
                        currentsection: 1,
                      ),
                      SectionTile(
                        status: getSectionStatus(
                            widget.currentlevel, widget.currentsection, 2),
                        currentsection: 2,
                      ),
                      SectionTile(
                        status: getSectionStatus(
                            widget.currentlevel, widget.currentsection, 3),
                        currentsection: 3,
                      ),
                      SectionTile(
                        status: getSectionStatus(
                            widget.currentlevel, widget.currentsection, 4),
                        currentsection: 4,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  LevelStatus getSectionStatus(
      int currentLevel, int currentsection, int section) {
    section++;
    if (widget.level < currentLevel) {
      return LevelStatus.completed;
    } else if (widget.level == currentLevel) {
      if (currentsection > section) {
        return LevelStatus.completed;
      } else if (currentsection == section) {
        return LevelStatus.current;
      } else {
        return LevelStatus.locked;
      }
    } else {
      return LevelStatus.locked;
    }
  }
}
