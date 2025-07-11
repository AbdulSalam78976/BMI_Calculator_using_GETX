import 'package:get/get.dart';

class BmiController extends GetxController {
  RxBool isMale = true.obs;
  RxDouble height = 160.0.obs; // Set default height
  RxDouble weight = 70.0.obs; // Set default weight
  RxInt age = 25.obs; // Set default age
  RxDouble bmi = 0.0.obs;

  double calculateBmi() {
    bmi.value = weight.value / ((height.value / 100) * (height.value / 100));
    return bmi.value;
  }

  String get bmiCategory {
    if (bmi.value < 18.5) {
      return "Underweight";
    } else if (bmi.value < 25) {
      return "Normal";
    } else if (bmi.value < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }
}
