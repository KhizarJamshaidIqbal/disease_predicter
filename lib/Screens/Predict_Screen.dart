import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:typed_data';

class PredictScreen extends StatefulWidget {
  const PredictScreen({Key? key}) : super(key: key);

  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  bool _modelLoaded = false;
  String _output = '';
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadModel(); // Initialize the plugin
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _loadModel() async {
    setState(() {
      _modelLoaded = false; // Set _modelLoaded to false when starting to load
    });

    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );

    // Check if the model is loaded successfully
    if (res == 'success') {
      print("Model loaded successfully");
      setState(() {
        _modelLoaded = true; // Set _modelLoaded to true after model is loaded
      });
    } else {
      print("Failed to load model: $res");
      // Handle initialization error (e.g., show error message)
    }
  }

  Future<void> _runModel() async {
    if (!_modelLoaded) return;

    String userInput = _inputController.text.trim();

    // Convert user input to a format suitable for model input
    // For example, parse it to a list of doubles

    // Example conversion: Split input by comma and parse to doubles
    List<double> input = userInput.split(',').map(double.parse).toList();

    var inputBuffer = Float32List.fromList(input).buffer.asUint8List();

    var output = await Tflite.runModelOnBinary(
      binary: inputBuffer,
    );

    setState(() {
      _output = output.toString();
    });

    print("Model output: $output");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _modelLoaded
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        labelText: 'Enter input data',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                        onPressed: _runModel,
                        child: Text(
                          "Run Model",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _output,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(), // Show loading indicator while model is being loaded
      ),
    );
  }
}
