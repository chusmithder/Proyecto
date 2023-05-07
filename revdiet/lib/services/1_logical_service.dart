import 'package:revdiet/enums/activity_levels.dart';
import 'package:revdiet/enums/genders_enum.dart';
import 'package:revdiet/enums/physical_goals_enum.dart';

//clase con metodos estaticos para calcular las calorias a partir de la formula de Harris y Benedict
class LogicalService {
  static double calculateTMB(
      Genders gender, double weight, int height, int age) {
    switch (gender) {
      case Genders.male:
        return (10 * weight) + (6.25 * height) - (5 * age) + 5;
      case Genders.female:
        return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  static double calculateMaintenanceCalories(
      double tmb, ActivityLevels activityLevel) {
    switch (activityLevel) {
      case ActivityLevels.NotVeryActive:
        return tmb * 1.2;
      case ActivityLevels.SlightlyActive:
        return tmb * 1.375;
      case ActivityLevels.Active:
        return tmb * 1.55;
      case ActivityLevels.VeryActive:
        return tmb * 1.9;
    }
  }

  static double calculateCaloriesAccordingToGoal(
      double maintenanceCalories, PhysicalGoals physicalGoal) {
    switch (physicalGoal) {
      case PhysicalGoals.Lose:
        return maintenanceCalories * 0.85;
      case PhysicalGoals.Maintain:
        return maintenanceCalories;
      case PhysicalGoals.Gain:
        return maintenanceCalories * 1.15;
    }
  }

// calculateCarbsProteinsFats
  static List<int> calculateMacronutrients(double calories, double weight) {
    double fats = (calories * 0.3) / 9; //g
    double proteins = weight * 2.2; //g
    double carbs = (calories - (fats * 9 + proteins * 4)) / 4; //g
    return <int>[carbs.round(), proteins.round(), fats.round()];
  }

  static List<int> calculateCaloriesCarbsProteinsFats(
      {required Genders gender,
      required double weight,
      required int height,
      required int age,
      required ActivityLevels activityLevel,
      required PhysicalGoals physicalGoal}) {
    double tmb = calculateTMB(gender, weight, height, age);
    double maintenanceCalories =
        calculateMaintenanceCalories(tmb, activityLevel);
    double calories =
        calculateCaloriesAccordingToGoal(maintenanceCalories, physicalGoal);
    List<int> macros = calculateMacronutrients(calories, weight);

    return <int>[calories.round(), macros[0], macros[1], macros[2]];
  }
}
