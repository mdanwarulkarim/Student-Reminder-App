import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/model/user_model.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    List<TodoModel> _todoList = [];
    DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    for(TodoModel todo in Get.find<AuthController>().getUserData()!.todoList!) {
      if(_today.isAtSameMomentAs(DateTime(todo.date!.year, todo.date!.month, todo.date!.day))) {
        _todoList.add(todo);
      }
    }

    return Scaffold(
      body: BgWidget(child: Column(children: [

        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(
            Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          title: Text('Notifications', style: poppinsBold.copyWith(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          centerTitle: true, elevation: 0,
        ),

        Expanded(child: _todoList.isNotEmpty ? ListView.builder(
          itemCount: _todoList.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return Column(children: [

              ListTile(
                leading: Container(
                  height: 40, width: 40,
                  padding: const EdgeInsets.all(5), alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                  child: Image.asset(Images.welcome),
                ),
                title: Text(_todoList[index].title!, style: poppinsMedium.copyWith(fontSize: 12)),
                subtitle: Text(
                  DateFormat('dd MMM').format(_todoList[index].date!),
                  style: poppinsRegular.copyWith(fontSize: 10, color: Theme.of(context).textTheme.titleMedium!.color),
                ),
              ),

              Divider(color: Theme.of(context).textTheme.titleMedium!.color, height: 5),

            ]);
          },
        ) : const Center(child: Text('No task found today')))
      ])),
    );
  }
}
