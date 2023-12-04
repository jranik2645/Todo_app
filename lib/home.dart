import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/todo_provder.dart';
import 'package:todo_app/model/todo_model.dart';

class MyToDo extends StatefulWidget {
  const MyToDo({super.key});

  @override
  State<MyToDo> createState() => _MyToDoState();
}

class _MyToDoState extends State<MyToDo> {

   final _textController=TextEditingController();
   
    Future<void>_showDialog()async{
       return showDialog(
         context:context,builder:(context){
           return AlertDialog(
              title:Text('Add ToDo List') ,
             content: TextField(
                controller: _textController,
               decoration: InputDecoration(hintText: "Write to do item"),
             ),
              actions: [
                TextButton(onPressed: (){
                   Navigator.pop(context);
                }, child: Text('Cancel')),
                TextButton(onPressed: (){

                  if(_textController.text.isEmpty){
                    return;
                  }

                       context.read<TodoProvder>().addToDoList(new TODOModel(title: _textController.text, isCompleted: false));

                   _textController.clear();

                   Navigator.pop(context);
                },
                    child: Text('Sumbit')),
              ],
           );
       }
       );
    }
    
  @override
  Widget build(BuildContext context) {

     final provider =Provider.of<TodoProvder>(context);

    return Scaffold (
      appBar: AppBar(title: Text('My first ToDo App'),centerTitle: true,),
      body:SafeArea(
         child: Column(
           children: [
               Expanded(
                   child: Container(
                       width:double.infinity,
                      decoration: const BoxDecoration(

                          color: Colors.blue,
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(40),
                           bottomLeft: Radius.circular(40),
                          )),
                     child:const Center(
                       child: Text('TO DO LIST',
                       style: TextStyle(
                         fontSize: 34,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                       ),
                     )
                   )),
             Expanded(
               flex: 3,
                 child: ListView.builder(itemBuilder: (context, iteamindex){
                     return  ListTile(
                        onTap: (){
                          provider.todoStatusChange(provider.allTODOList[iteamindex]);
                        },
                       leading: MSHCheckbox(
                         size: 30,
                         value: provider.allTODOList[iteamindex].isCompleted,

                         colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                           checkedColor: Colors.red,
                         ),
                          style: MSHCheckboxStyle.stroke,
                         onChanged: (selected){
                        provider.todoStatusChange(provider.allTODOList[iteamindex]);
                         },
                       ),
                       title: Text(provider.allTODOList[iteamindex].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                        decoration: provider.allTODOList[iteamindex].isCompleted==true ?
                            TextDecoration.lineThrough:null
                       ),

                       ),
                         trailing: IconButton(icon:Icon( Icons.delete, color: Colors.red,), onPressed: () {
                             provider.removeToDoList(provider.allTODOList[iteamindex]);
                         },),
                     );
                 },
                    itemCount:provider.allTODOList.length,
                 )
             ),
           ],
         ),
      ),
         floatingActionButton: FloatingActionButton(onPressed: (){
           _showDialog();
         },
        child: const Icon(Icons.add, color: Colors.white,size: 40,),),
    );

  }
}