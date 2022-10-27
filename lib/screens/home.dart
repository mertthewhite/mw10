import 'package:flutter/material.dart';
import 'package:to_do_app/constanst/colors.dart';
import 'package:to_do_app/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body:Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              children: [
                 searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50, 
                          bottom: 20, 
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500
                          ),) 
                      ),
                      
                      for (ToDo todo in _foundToDo)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem:_deleteToDoItem,
                      ),

                    
                    ],
                  ),
                )
              ],
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20, 
                    right: 20, 
                    left: 20, 
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0, 
                      spreadRadius: 0.0,
                      ),], 
                     borderRadius:BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item', 
                      border: InputBorder.none
                     ),
                  ),
                )),
                Container(
                  margin:EdgeInsets.only(
                    bottom: 20, 
                    right: 20, 
                  ),
                  child: ElevatedButton( 
                    child:Text("+" , style: TextStyle(fontSize: 40),),
                    onPressed: (() {
                      _addToDoItem(_todoController.text);
                      
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue, 
                      minimumSize: Size(60,60), 
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      
    );
  }

  void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });

  }

  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      todoText :toDo
     ));
    });
    _todoController.clear();

  
  } 

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList ;
    }else{
      results = todoList.where((item) => item.todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase())
      ).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  } 

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        const Icon(Icons.menu,
        color: tdBlack,
        size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),              
            child: Image.asset('assets/images/333303.jpg'),
          ),
        )
      ]),
    );
  }
}




Widget searchBox() {
return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15) ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child:  TextField(
        onChanged: (value) => runFilter(value) ,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 25,
              maxWidth: 25,
            ),
            border:InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color:tdGrey),
        ),
      ),
    );
}

runFilter(String value) {
}


/*class searchBox extends StatelessWidget {
   searchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15) ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child:  TextField(
        onChanged: (value) => _runFilter(value) ,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 25,
              maxWidth: 25,
            ),
            border:InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color:tdGrey),
        ),
      ),
    );
  }
}
*/
