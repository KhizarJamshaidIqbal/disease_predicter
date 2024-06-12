import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PredictDiseaseScreen()),
                    );
                  },
                  child: const Text(
                    'Predict disease diabetes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TestRecommendScreen()),
                    );
                  },
                  child: const Text(
                    'Test recommend',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MedicineRecommendScreen()),
                    );
                  },
                  child: const Text(
                    'Medicine recommend',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PrecautionsRecommendScreen()),
                    );
                  },
                  child: const Text(
                    'Precautions recommend',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PredictDiseaseScreen extends StatelessWidget {
  const PredictDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Predict disease diabetes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            "Predicting diabetes involves utilizing various machine learning techniques to analyze data and identify patterns associated with the disease. Key risk factors include age, BMI, blood pressure, and family history. Machine learning models, such as logistic regression, decision trees, and neural networks, can process large datasets to find correlations between these factors and diabetes onset. By training these models on historical data, they can predict the likelihood of diabetes in new patients with considerable accuracy. Early prediction allows for timely intervention, lifestyle adjustments, and medical treatments that can significantly reduce the risk of complications associated with diabetes."),
      ),
    );
  }
}

class TestRecommendScreen extends StatelessWidget {
  const TestRecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Test recommend',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading:IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            "Predicting diabetes involves using various diagnostic tests to evaluate an individual's risk factors and current health status. Common tests include the fasting plasma glucose test, the A1C test, and the oral glucose tolerance test. These tests measure blood sugar levels and provide critical information about how the body processes glucose. Regular screening is recommended for individuals with risk factors such as obesity, a sedentary lifestyle, a family history of diabetes, high blood pressure, and abnormal cholesterol levels. Early detection through these tests can lead to timely intervention and management, reducing the risk of complications associated with diabetes."),
      ),
    );
  }
}

class MedicineRecommendScreen extends StatelessWidget {
  const MedicineRecommendScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          'Medicine recommend',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            SizedBox(height: 10),
            Text(
              'Predicting and Managing Diabetes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Preventing diabetes, particularly type 2, involves making healthy lifestyle choices. Here are some key precautions and recommendations:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '1. Maintain a Healthy Diet: Focus on a balanced diet rich in fruits, vegetables, whole grains, and lean proteins. Limit intake of refined sugars and carbohydrates, and avoid sugary beverages.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Regular Exercise: Engage in at least 30 minutes of moderate physical activity most days of the week. Activities like walking, cycling, swimming, or any form of aerobic exercise can help manage weight and improve insulin sensitivity.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. Maintain a Healthy Weight: Achieving and maintaining a healthy weight can prevent the onset of diabetes. If overweight, even a modest reduction in weight can significantly lower the risk.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '4. Regular Medical Checkups: Regular screenings can help in early detection and management of prediabetes or diabetes. Blood sugar levels, cholesterol, and blood pressure should be monitored regularly.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '5. Avoid Smoking and Limit Alcohol: Smoking increases the risk of diabetes and cardiovascular diseases. Limit alcohol intake to moderate levels, as excessive consumption can contribute to weight gain and affect blood sugar levels.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '6. Manage Stress: Chronic stress can affect blood sugar levels. Practice stress-reducing techniques such as yoga, meditation, or deep breathing exercises.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'By following these precautions, individuals can significantly reduce their risk of developing diabetes and maintain overall health.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class PrecautionsRecommendScreen extends StatelessWidget {
  const PrecautionsRecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          'Precautions recommend',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Text(
              'Preventing Diabetes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Preventing diabetes, particularly type 2, involves making healthy lifestyle choices. Here are some key precautions and recommendations:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '1. Maintain a Healthy Diet: Focus on a balanced diet rich in fruits, vegetables, whole grains, and lean proteins. Limit intake of refined sugars and carbohydrates, and avoid sugary beverages.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Regular Exercise: Engage in at least 30 minutes of moderate physical activity most days of the week. Activities like walking, cycling, swimming, or any form of aerobic exercise can help manage weight and improve insulin sensitivity.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. Maintain a Healthy Weight: Achieving and maintaining a healthy weight can prevent the onset of diabetes. If overweight, even a modest reduction in weight can significantly lower the risk.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '4. Regular Medical Checkups: Regular screenings can help in early detection and management of prediabetes or diabetes. Blood sugar levels, cholesterol, and blood pressure should be monitored regularly.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '5. Avoid Smoking and Limit Alcohol: Smoking increases the risk of diabetes and cardiovascular diseases. Limit alcohol intake to moderate levels, as excessive consumption can contribute to weight gain and affect blood sugar levels.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '6. Manage Stress: Chronic stress can affect blood sugar levels. Practice stress-reducing techniques such as yoga, meditation, or deep breathing exercises.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'By following these precautions, individuals can significantly reduce their risk of developing diabetes and maintain overall health.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
