import 'package:dapple/features/test_section/presentation/bloc/result/result_cubit.dart';
import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'package:dapple/features/test_section/presentation/widgets/report_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/indicators/xp_arc_indicator.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';
import '../bloc/socket/socket_bloc.dart';

class TestReportScreen extends StatefulWidget {
  const TestReportScreen(
      {super.key, required this.sessionId, required this.sectionId});

  final String sessionId;
  final String sectionId;

  @override
  State<TestReportScreen> createState() => _TestReportScreenState();
}

class _TestReportScreenState extends State<TestReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  void initSocket() {
    context
        .read<ResultCubit>()
        .calculateResult(widget.sessionId, widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketBloc, SocketState>(
      listener: (context, state) {
        if (state is SocketMessageReceived && state.questionIndex!=null && state.questionIndex==3) {
          debugPrint("Now asking result");
          context
              .read<ResultCubit>()
              .calculateResult(widget.sessionId, widget.sectionId);
        }
        else{
          debugPrint(state.toString());
        }
      },
      child: Scaffold(
        body: BlocBuilder<ResultCubit, ResultState>(
          builder: (context, state) {
            if (state is ResultLoading || state is ResultInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ResultError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is ResultLoaded) {
              final questions = (context.read<TestQuestionsCubit>().state
                      as TestQuestionsLoaded)
                  .questions;
              int totalXp = 0;
              for (var question in questions) {
                totalXp += question.xp;
              }
              return Container(
                decoration: BoxDecoration(
                  color: AppPalette.white,
                  image: DecorationImage(
                      image: AssetImage('assets/section/image_bg_light.png')),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextRubik(
                                text: 'ANSWER REPORT',
                                weight: FontWeight.w600,
                                size: 20,
                                color: AppPalette.blackColor),
                            XpArcIndicator(
                              progress: state.testResult.obtainedXp,
                              max: totalXp,
                              color: AppPalette.secondaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomTextRubik(
                                    text: "Here is the question wise report - ",
                                    weight: FontWeight.w400,
                                    size: 14,
                                    color: AppPalette.blackColor),
                              ),
                            ),
                            for (int i = 0;
                                i < state.testResult.questionResults.length;
                                i++)
                              ReportTile(
                                title: "Question ${i + 1}",
                                description: questions[i].question,
                                xpGained: state
                                    .testResult.questionResults[i].obtainedXp,
                                totalXp: questions[i].xp,
                                type: 1,
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConsts.testQuestionReportScreen,
                                      extra: {
                                        'question': questions[i].question,
                                        'maxXp': questions[i].xp,
                                        'questionResult':
                                            state.testResult.questionResults[i]
                                      });
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PrimaryButton(
                          onTap: () {},
                          text: 'CONTINUE',
                          primaryColor: AppPalette.white,
                          bgColor: AppPalette.secondaryColor),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
