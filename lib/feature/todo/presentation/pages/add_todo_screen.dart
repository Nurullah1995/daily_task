import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:flutter_project/feature/todo/presentation/pages/task_details_screen.dart';
import 'package:flutter_project/feature/todo/presentation/pages/widget/bottom_sheet.dart';
import 'package:flutter_project/feature/todo/presentation/pages/widget/task_card.dart';
import 'package:flutter_project/utils/Colors.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _listOfTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            BlocBuilder<AddTodoBloc, AddTodoState>(
              builder: (context, state) {
                if (state.status == Status.success) {
                  return Row(
                    children: [
                      Text(
                        state.itemTitle,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '(${state.taskList.length})',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                }
                return TextField(
                  controller: _listOfTodoController,
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border
                    hintText: 'Untitled List (0)',
                  ),
                );
              },
            ),
            BlocBuilder<AddTodoBloc, AddTodoState>(
              builder: (context, state) {
                return Container(
                  child: ListView.builder(
                      itemCount: state.taskList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskCard(
                            task: state.taskList[index],
                            onClickTask: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                          item: state.taskList[index],
                                        )),
                              );
                            });
                      }),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Card(
          elevation: 1.0,
          child: BlocBuilder<AddTodoBloc, AddTodoState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                   if(_listOfTodoController.text.isEmpty || _listOfTodoController.text==''){
                     context
                         .read<AddTodoBloc>()
                         .add(AddNoteTitle(listOfItem: 'Untitled List'));
                     showModalBottomSheet(
                       context: context,
                       isScrollControlled: true,
                       shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.vertical(top: Radius.circular(20)),
                       ),
                       builder: (BuildContext context) {
                         return Padding(
                           padding: EdgeInsets.only(
                             bottom: MediaQuery.of(context).viewInsets.bottom,
                           ),
                           child: BottomSheetContent(),
                         );
                       },
                     );
                   }else{
                     context
                         .read<AddTodoBloc>()
                         .add(AddNoteTitle(listOfItem:_listOfTodoController.text.trim()));
                     showModalBottomSheet(
                       context: context,
                       isScrollControlled: true,
                       shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.vertical(top: Radius.circular(20)),
                       ),
                       builder: (BuildContext context) {
                         return Padding(
                           padding: EdgeInsets.only(
                             bottom: MediaQuery.of(context).viewInsets.bottom,
                           ),
                           child: BottomSheetContent(),
                         );
                       },
                     );
                   }


                },
                child: Container(
                  color: Colors.white,
                  height: 50,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Add a Task')
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
