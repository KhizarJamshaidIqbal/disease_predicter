import 'package:flutter/material.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class PredictScreen extends StatefulWidget {
  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  bool _isLoading = false;
  String _prediction = "";

  @override
  void initState() {
    super.initState();
    _downloadModel();
  }

  Future<void> _downloadModel() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final model = await FirebaseModelDownloader.instance.getModel(
        "model", // replace with your model name in Firebase
        FirebaseModelDownloadType.latestModel,
      );

      final modelFile = model.file;
      await _loadModel(modelFile);
    } catch (e) {
      print("Error downloading model: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadModel(File modelFile) async {
    try {
      String? res = await Tflite.loadModel(
        model: modelFile.path,
        labels: "assets/labels.txt", // replace with your labels file path
      );
      print("Model loaded: $res");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _runInference(String imagePath) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: imagePath,
      );
      setState(() {
        _prediction = output?.first['label'] ?? 'No prediction';
      });
    } catch (e) {
      print("Error running inference: $e");
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Model Prediction"),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _prediction.isEmpty
                      ? Text("No prediction yet")
                      : Text("Prediction: $_prediction"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // This should be replaced with code to pick an image
                      // For example, using image_picker package
                      String imagePath = "path_to_your_image.jpg";
                      await _runInference(imagePath);
                    },
                    child: Text("Run Prediction"),
                  ),
                ],
              ),
      ),
    );
  }
}
