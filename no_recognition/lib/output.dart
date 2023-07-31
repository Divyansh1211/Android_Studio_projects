import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> sendImage() async {
  final url = Uri.parse('http://127.0.0.1:5000/predict');
  final imageFile = File('path/to/image.jpg');
  final bytes = await imageFile.readAsBytes();
  final encoded = base64Encode(bytes);

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'data': encoded}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final prediction = data['prediction'];
    print(prediction);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}