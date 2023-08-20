import 'dart:convert';

import 'package:http/http.dart' as http;
import 'secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content':
                    'Does this message want to you generate or create picture ,image, art or anything similar? message=$prompt . Simply answer with a yes or no.',
              },
            ],
          },
        ),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        content = content.toLowerCase();
        if (content == 'yes' || content == 'yes.') {
          final res = await dallEAPI(prompt);
          return res;
        } else {
          final res = await chatGPTAPI(prompt);
          return res;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": messages,
          },
        ),
      );
      if (res.statusCode == 200) {
        String Chatcontent =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        messages.add({
          'role': 'assistant',
          'content': Chatcontent,
        });
        return Chatcontent;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode(
          {
            "prompt": prompt,
            "n": 2,
          },
        ),
      );
      // print(res.body);
      if (res.statusCode == 200) {
        String imageURL = jsonDecode(res.body)['data'][0]['url'];
        messages.add({
          'role': 'assistant',
          'content': imageURL,
        });
        return imageURL;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
