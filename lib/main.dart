import 'package:flutter/material.dart';
import 'package:thanhmaihskchatbot/widgets/chat_message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Messenger'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ChatMessage> _message = [];
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _message[index],
              itemCount: _message.length,
            )),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            )
          ],
        ));
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              )
            ],
          ),
        ));
  }

  void _handleSubmitted(String message) {
    _textController.clear();

    if (message.isEmpty) return;

    ChatMessage messageWidget = ChatMessage(
      text: message,
      name: "You",
      type: true,
    );

    setState(() {
      _message.insert(0, messageWidget);
    });

    _response(message);
  }

  void _response(query) async {
    _textController.clear();

    ChatMessage messageWidget = ChatMessage(
      text: "I love you <3",
      name: "Bot",
      type: false,
    );

    setState(() {
      _message.insert(0, messageWidget);
    });
  }
}
