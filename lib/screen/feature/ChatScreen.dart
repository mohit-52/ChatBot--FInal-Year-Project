import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _chatHistory = [];
  bool _loading = false;

  get height => null;

  Future<void> _sendMessage(String message) async {
    setState(() {
      _chatHistory.add("User: $message");
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyD6QivQmBmRHkmiuiQTkl-osj0o4Q6LGU8'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "text":
                    "You are Alex. A friendly assistant who works for Manav Rachna International Institute of Research and Studies. My name is mayank and i am the creator of this chatbot i am currently studying in MRIIRS(Manav Rachna International Institute of Research and Studies) and i am pursing my BTech in Computer Science Engineering. I am creating this chatbot to help our university student to get an ease and get essential details of our computer science department. i am going to build the knowledge base of this chatbot myself by getting required information from the teachers of computer science department. you have to wait until the user ask a question and then give answer. first ask the username then answer the questions. do not provide the list of question to the user let user enter their username and then they will ask question themselves do not give the user question and and most importantly do not answer any other question than this knowledge base only answer the question that are listed here so these are the question the student can ask :\n1. when is the last date of submitting the Re appear exam form? the last date is 28th march 20242. when is the last day to submit the academic fees? the last date to submit the academic fees is 30th March 20243. when is the last date to submit the fees? the last date to submit the academic fees is 30th March 2024 and the the last date to submit the Re appear exam form is 28th march 20244. who is the HOD of the CSE department?Mrs. Mamta Dahiya is the current HOD of the Department5.Professors teaching specific courses: I can provide information about the professors who are currently teaching or have taught certain courses in the CSE curriculum.\nPlease let me know your specific interests, and I'll do my best to assist you further.\n\ni have not define such question in the knowledge base but you still reply with this please why? please do not do this even if the user ask a question about CSE department and if it is not in your database please do not reply it thank you.\n when the user say hey or hii or greet you just reply them polity and ask them how i can help you do not provide the list of the question to the user directly please thank you\n why are you still replying the question that is not in the knowledge base please do not reply it only reply the question that i have feed in your knowledge base do not answer anything else and do not use any external source of information to answer the question. if anyone ask who build you tell them Mohit, Mayank And Harshita Build me "
              }
            ]
          },
          // {
          //   "role": "model",
          //   "parts": [
          //     {
          //       "text": "Hello there! Welcome to the MRIIRS Computer Science Department Chatbot.  To get started, please tell me your name.  I'm excited to assist you!"
          //     }
          //   ]
          // },
          // {
          //   "role": "user",
          //   "parts": [
          //     {
          //       "text": "timings"
          //     }
          //   ]
          // },
          {
            "role": "model",
            "parts": [
              {
                "text":
                    "I apologize, but I can only answer questions that are specifically within my knowledge base related to the MRIIRS Computer Science Department. Could you please ask a different question?"
              }
            ]
          },
          // {
          //   "role": "user",
          //   "parts": [
          //     {
          //       "text": "department timing"
          //     }
          //   ]
          // },
          // {
          //   "role": "model",
          //   "parts": [
          //     {
          //       "text": "The CSE department office is usually open from 8 am to 5 pm, Monday through Friday."
          //     }
          //   ]
          // },
          // {
          //   "role": "user",
          //   "parts": [
          //     {
          //       "text": "hey"
          //     }
          //   ]
          // },
          // {
          //   "role": "model",
          //   "parts": [
          //     {
          //       "text": "Hello there! Welcome to the MRIIRS Computer Science Department Chatbot. To get started, please tell me your name. I'm excited to assist you!"
          //     }
          //   ]
          // },
          // {
          //   "role": "user",
          //   "parts": [
          //     {
          //       "text": "mayank"
          //     }
          //   ]
          // },
          // {
          //   "role": "model",
          //   "parts": [
          //     {
          //       "text": "Hi Mayank! Welcome to the MRIIRS Computer Science Department Chatbot. I'm here to assist you with any questions you may have about our department. Go ahead, ask me anything!"
          //     }
          //   ]
          // },
          // {
          //   "role": "user",
          //   "parts": [
          //     {
          //       "text": "open elective"
          //     }
          //   ]
          // },
          // {
          //   "role": "model",
          //   "parts": [
          //     {
          //       "text": "The department offers a range of open electives for CSE students, allowing you to explore your interests and broaden your knowledge. These electives cover various domains within computer science and beyond, giving you the flexibility to tailor your education to your career goals. To learn more about the specific open electives available this semester, please refer to the course catalog or consult with your academic advisor."
          //     }
          //   ]
          // },
          {
            "role": "user",
            "parts": [
              {"text": _textController.value.toString()}
            ]
          }
        ],
        "generationConfig": {
          "temperature": 0.9,
          "topK": 1,
          "topP": 1,
          "maxOutputTokens": 2048,
          "stopSequences": []
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      print("Inside if");
      final decodedResponse = jsonDecode(response.body);
      final candidates = decodedResponse['candidates'];
      if (candidates != null && candidates.isNotEmpty) {
        final content = candidates[0]['content'];
        if (content != null) {
          final parts = content['parts'];
          if (parts != null && parts.isNotEmpty) {
            final text = parts[0]['text'];
            if (text != null) {
              setState(() {
                _loading = false;
                _chatHistory.add("Chatbot: $text");
              });
              return; // Exit the function since we successfully added the message
            }
          }
        }
      }
      // If we reach here, it means there was an issue with parsing the response
      throw Exception('Failed to parse message from chatbot');
    } else {
      throw Exception(
          'Failed to send message to chatbot${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          // leading: Image.asset('assets/images/bg_image.png'),
          title: Text(
            'ALEX - MRIIRS Chatbot',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(15, 25, 39, 1),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(15, 25, 39, 1),
            image: DecorationImage(
              image: AssetImage('assets/images/new.png'),
      
              // fit: BoxFit.contain, // Adjust the fit as needed
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: false, // Display messages from bottom to top
                  itemCount: _chatHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: _chatHistory[index].startsWith("You")
                            ? Alignment.topLeft
                            : Alignment.topLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _chatHistory[index].startsWith("You")
                                ? Colors.lightBlueAccent
                                : Color.fromRGBO(15, 40, 80, 10),
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            _chatHistory[index],
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    padding / 30, padding / 20, padding / 30, padding / 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        onFieldSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            _sendMessage(value.trim());
                            _textController.clear();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              icon: _loading
                                  ? CircularProgressIndicator(
                                      strokeWidth: 5,
                                      color: Color.fromRGBO(15, 25, 39, 1),
                                    )
                                  : Icon(
                                      Icons.send,
                                      color: Color.fromRGBO(41, 93, 166, 1),
                                    ),
                              onPressed: () {
                                if (_textController.text.trim().isNotEmpty) {
                                  _sendMessage(_textController.text.trim());
                                  _textController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
