import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/domain/entities/section.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/new_widgets/section_tile.dart';
import 'package:dapple/features/home/presentation/widgets/level_status_icon.dart';
import 'package:flutter/material.dart';

class LevelWidget extends StatefulWidget {
  const LevelWidget(
      {super.key,
      required this.currentLevel,
      required this.heading,
      required this.status,
      required this.description,
      required this.level,
      required this.currentSection,
      required this.sections});

  final int currentLevel;
  final int currentSection;
  final String heading;
  final String description;
  final LevelStatus status;
  final int level;
  final List<Section> sections;

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
    return Opacity(
      opacity: widget.status == LevelStatus.locked ? 0.6 : 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.status != LevelStatus.locked) {
                    initialstate = !initialstate;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppPalette.primaryGradient,
                  color: AppPalette.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LevelStatusIcon(
                            status: widget.status,
                            levelnumber: widget.level,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(widget.heading,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white, fontSize: 20)),
                          Text(widget.description,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Color(0xFFB3B3B3), fontSize: 12)),
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/dapple-girl/point.png',
                        height: MediaQuery.of(context).size.height / 6,
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
                  padding: const EdgeInsets.fromLTRB(24, 6, 24, 0),
                  child: Column(
                    children: [
                      for (int i = 0; i < widget.sections.length; i++)
                        SectionTile(
                          status: getSectionStatus(
                              widget.currentLevel, widget.currentSection, i),
                          title: widget.sections[i].title,
                          xp: widget.sections[i].sectionXp,
                          sectionNo: i + 1,
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
