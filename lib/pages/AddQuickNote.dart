import 'dart:async';

import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';
import 'package:todo_app/models/Priority.dart';
import 'package:todo_app/widgets/SelectPriorityButton.dart';
import 'package:todo_app/widgets/SmallButton.dart';
import 'package:todo_app/widgets/SuggestionTile.dart';

class AddQuickNote extends StatefulWidget {
  @override
  _AddQuickNoteState createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  String _quickNoteTitle;
  StreamController<String> _suggestionsTextController = new StreamController<String>();
  Priority _quickNotePriority;
  List<int> _priorityValues = [1,2,3];
  int _selectedPriorityValue;

  TextEditingController _textController =  new TextEditingController();

  Iterable<String> _suggestions = [...adjectives.take(10), ...nouns.take(5)];

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    FocusNode _textInputFocusNode = new FocusNode();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 20.0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:
                        Icon(Icons.clear, size: 26.0, color: Color(0xff616B77)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        focusNode: _textInputFocusNode,
                        controller: _textController,
                        style: TextStyle(
                            fontSize: 27.0,
                            fontFamily: "Poppins",
                            color: Theme.of(context).accentColor),
                        decoration: InputDecoration(
                            hintText: "Write your quick note",
                            border:
                                UnderlineInputBorder(borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(width:20.0),
                    SmallButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: (){},
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                      "Suggestions",
                      style: TextStyle(
                          fontSize: 20.0, color: Theme.of(context).accentColor),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Container(                  
                  child: Wrap( 
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: _suggestions.map(
                      (word){
                        return SuggestionTile(
                          title: word.toString(),
                          
                          onTap: (){
                            setState(() {
                              _textController.text = _textController.text + word.toString();
                              
                            });
                            
                          },
                        );
                      }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                      "Priority",
                      style: TextStyle(
                          fontSize: 20.0, color: Theme.of(context).accentColor),
                    )
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _priorityValues.map(
                    (priority){
                      return SelectPriorityButton(
                        priority: Priority.fromPriorityValue(priority),
                        onPressed: (){
                          setState(() {
                            _quickNotePriority = Priority.fromPriorityValue(priority);
                            _selectedPriorityValue = priority;
                          });
                        },
                        isSelected: _selectedPriorityValue == priority
                      );
                    }
                  ).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
