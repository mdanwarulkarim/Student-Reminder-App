import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/model/user_model.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/button_widget.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';
import 'package:student_reminder/widget/text_field_widget.dart';

class TodoPage extends StatefulWidget {
  final Function? onDone;
  const TodoPage({Key? key, @required this.onDone}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();
  DateTime? _date;
  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(child: Column(children: [
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text('Todo Planner', style: poppinsBold.copyWith(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          centerTitle: true, elevation: 0,
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            const SizedBox(height: 30),

            Text('Title', style: poppinsRegular.copyWith(fontSize: 24)),
            const SizedBox(height: 10),
            TextFieldWidget(
              hintText: 'Title',
              controller: _titleController,
              focusNode: _titleFocus,
              nextFocus: _detailsFocus,
            ),
            const SizedBox(height: 20),

            Row(children: [
              Expanded(child: InkWell(
                onTap: () async {
                  DateTime? _pickedTime = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if(_pickedTime != null) {
                    setState(() {
                      _date = _pickedTime;
                    });
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    const Icon(Icons.calendar_today_outlined, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      _date == null ? 'Pick Date' : DateFormat('dd-MM-yyyy').format(_date!),
                      style: poppinsRegular.copyWith(fontSize: 16),
                    ),
                  ]),
                ),
              )),
              const SizedBox(width: 20),
              Expanded(child: InkWell(
                onTap: () async {
                  TimeOfDay? _pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(_pickedTime != null) {
                    setState(() {
                      _time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _pickedTime.hour, _pickedTime.minute);
                    });
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    const Icon(Icons.calendar_today_outlined, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      _time == null ? 'Pick Time' : DateFormat('hh:mm a').format(_time!),
                      style: poppinsRegular.copyWith(fontSize: 16),
                    ),
                  ]),
                ),
              )),
            ]),
            const SizedBox(height: 20),

            Text('Details', style: poppinsRegular.copyWith(fontSize: 24)),
            const SizedBox(height: 10),

            TextFieldWidget(
              hintText: 'Details',
              controller: _detailsController,
              focusNode: _detailsFocus,
              inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
              maxLines: 5,
            ),
            const SizedBox(height: 30),

            GetBuilder<AuthController>(builder: (authController) {
              return !authController.isLoading ? ButtonWidget(
                buttonText: 'Save',
                onPressed: () async {
                  String _title = _titleController.text.trim();
                  String _details = _detailsController.text.trim();
                  if(_title.isEmpty) {
                    showCustomSnackBar('Enter title');
                  }else if(_date == null) {
                    showCustomSnackBar('Pick a date');
                  }else if(_time == null) {
                    showCustomSnackBar('Pick a time');
                  }else if(_details.isEmpty) {
                    showCustomSnackBar('Enter details');
                  }else {
                    _date = DateTime(_date!.year, _date!.month, _date!.day, _time!.hour, _time!.minute, _time!.second);
                    bool _isSuccess = await authController.addTodo(TodoModel(title: _title, details: _details, date: _date, isChecked: false));
                    if(_isSuccess) {
                      widget.onDone!();
                    }
                  }
                },
              ) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor));
            }),

          ]),
        )),
      ])),
    );
  }
}
