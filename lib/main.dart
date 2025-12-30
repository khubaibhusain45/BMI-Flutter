import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return true to allow pop, false to prevent it
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App?'),
            content: const Text('Do you really want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldExit;
      },
      child: GestureDetector(
        onTap: () {
          // Removes focus from any text field
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'BMI Calculator',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                Card(
                  elevation: 7,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        TextField(
                          controller: weight,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            labelText: "Weight",
                            hint: Text("Enter your weight (kg)"),
                            labelStyle: const TextStyle(color: Colors.red),
                            prefixIcon: const Icon(Icons.monitor_weight),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: height,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            labelText: "Height",
                            hint: Text("Enter your height (m)"),
                            labelStyle: const TextStyle(color: Colors.red),
                            prefixIcon: const Icon(Icons.height),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    var w = weight.text.trim();
                    var h = height.text.trim();

                    if (w.isEmpty || h.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Alert!"),
                          content: const Text(
                            "None of the fields can be empty",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      double weightValue = double.parse(w);
                      double heightValue = double.parse(h);
                      double bmi = weightValue / pow(heightValue, 2).toDouble();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("BMI Value"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your BMI is ${bmi.toStringAsFixed(2)}"),
                              Container(height: 20),
                              Text(
                                bmi < 18.5
                                    ? "You are Underweight"
                                    : bmi < 24.9
                                    ? "You are Normal weight"
                                    : bmi < 29.9
                                    ? "You are Overweight"
                                    : "You are Obese",
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "OK",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Calculate BMI",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(height: 20),
                ElevatedButton(
                  onPressed: () {
                    weight.text = "";
                    height.text = "";
                  },
                  child: Text(
                    "Clear All Fields",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
