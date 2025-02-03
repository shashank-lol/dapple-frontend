import '../../domain/entities/daily_goal.dart';

class DailyGoalModel extends DailyGoal{
  DailyGoalModel({
    required super.title,
    required super.description,
    required super.isCompleted
  });

  factory DailyGoalModel.fromJson(Map<String, dynamic> json) {
    return DailyGoalModel(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ,
    );
  }
}