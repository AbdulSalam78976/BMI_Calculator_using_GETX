import 'package:bmi_calculator/app_pallete.dart';
import 'package:bmi_calculator/controllers/bmi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //register the controller
  final bmicontroller = Get.put(BmiController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Gender selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => CategoryContainer(
                    icon: Icon(Icons.male, color: Colors.white, size: 50),
                    category: 'MALE',
                    isSelected: bmicontroller.isMale.value,
                    onTap: () {
                      bmicontroller.isMale.value = true;
                    },
                  ),
                ),
                SizedBox(width: 30),
                Obx(
                  () => CategoryContainer(
                    icon: Icon(Icons.female, color: Colors.white, size: 50),
                    category: 'FEMALE',
                    isSelected: !bmicontroller.isMale.value,
                    onTap: () {
                      bmicontroller.isMale.value = false;
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Container(
                height: height * 0.25,
                width: width * 0.76,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppPallete.gradient2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Height Slider Title
                    const Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Display current height
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${bmicontroller.height.value.toInt()}',
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(width: 5),
                          const Text(
                            'cm',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    /// Height slider
                    Obx(
                      () => Slider(
                        min: 50,
                        max: 250,
                        value: bmicontroller.height.value,
                        divisions: 200,
                        label: bmicontroller.height.value.round().toString(),
                        onChanged: (double value) {
                          bmicontroller.height.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WeightContainer(height: height, width: width),

                SizedBox(width: 30),
                AgeContainer(height: height, width: width),
              ],
            ),

            SizedBox(height: 20),

            Button(height: height, width: width),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button({super.key, required this.height, required this.width});

  final height;
  final width;

  //find the already registered controller
  final bmicontroller = Get.find<BmiController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final bmiValue = bmicontroller.calculateBmi();
        final bmiCategory = bmicontroller.bmiCategory;

        Get.defaultDialog(
          radius: 12,
          title: 'Your BMI is',
          titleStyle: TextStyle(color: Colors.white),
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(25),
          cancel: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppPallete.errorColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('Close'),
          ),
          backgroundColor: AppPallete.gradient3,
          content: Column(
            children: [
              Text(
                '${bmiValue.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                bmiCategory,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ],
          ),
        );
      },
      child: Container(
        height: height * 0.1,
        width: width * 0.76,
        decoration: BoxDecoration(
          color: AppPallete.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'CALCULATE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class WeightContainer extends StatelessWidget {
  WeightContainer({super.key, required this.height, required this.width});

  final height;
  final width;
  final bmicontroller = Get.find<BmiController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width * 0.35,
      decoration: BoxDecoration(
        color: AppPallete.gradient2,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'WEIGHT',
            style: TextStyle(fontSize: 22, color: Colors.grey.shade400),
          ),

          SizedBox(height: 5),

          Obx(
            () => Text(
              '${bmicontroller.weight.value.toInt()} kg',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  if (bmicontroller.weight.value > 1) {
                    bmicontroller.weight.value--;
                  }
                },
              ),
              IconButton(
                tooltip: "Add weight",
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  bmicontroller.weight.value++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AgeContainer extends StatelessWidget {
  AgeContainer({super.key, required this.height, required this.width});

  final height;
  final width;
  final bmicontroller = Get.find<BmiController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width * 0.35,
      decoration: BoxDecoration(
        color: AppPallete.gradient2,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'AGE',
            style: TextStyle(fontSize: 22, color: Colors.grey.shade400),
          ),

          SizedBox(height: 5),

          Obx(
            () => Text(
              '${bmicontroller.age.value}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  if (bmicontroller.age.value > 1) {
                    bmicontroller.age.value--;
                  }
                },
              ),
              IconButton(
                tooltip: "Add age",
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  bmicontroller.age.value++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Category Container Widget
class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.icon,
    required this.category,
    required this.onTap,
    required this.isSelected,
  });

  final Icon icon;
  final String category;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.2,
        width: width * 0.35,
        decoration: BoxDecoration(
          color: isSelected ? AppPallete.gradient3 : AppPallete.gradient2,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 10),
              Text(
                category.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
