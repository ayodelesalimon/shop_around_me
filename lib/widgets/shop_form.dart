// import 'package:flutter/material.dart';

// class TodoFormWidget extends StatefulWidget {
//   final String title;
//   final String description;
//   final ValueChanged<String> onChangedPrice;
//   final ValueChanged<String> onChangedTitle;
//   final ValueChanged<String> onChangedDescription;
//   final VoidCallback onSavedTodo;

//   const TodoFormWidget({
//     Key key,
//     this.title = '',
//     this.description = '',
//     @required this.onChangedTitle,
//     @required this.onChangedDescription,
//     @required this.onSavedTodo,
   
//      this.onChangedPrice,
//   }) : super(key: key);

//   @override
//   _TodoFormWidgetState createState() => _TodoFormWidgetState();
// }

// class _TodoFormWidgetState extends State<TodoFormWidget> {
//   int pricee;
//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             buildTitle(),
//             SizedBox(height: 8),
//             buildDescription(),
//             SizedBox(height: 16),
//             buildButton(),
//           ],
//         ),
//       );

//   Widget buildTitle() => TextFormField(
//         maxLines: 1,
//         initialValue: widget.title,
//         onChanged: widget.onChangedTitle,
//         validator: (title) {
//           if (title.isEmpty) {
//             return 'The title cannot be empty';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           border: UnderlineInputBorder(),
//           labelText: 'Title',
//         ),
//       );

//   Widget buildDescription() => TextFormField(
//         maxLines: 3,
//         initialValue: widget.description,
//         onChanged: widget.onChangedDescription,
//         decoration: InputDecoration(
//           border: UnderlineInputBorder(),
//           labelText: 'Description',
//         ),
//       );

//   Widget buildButton() => SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.black),
//           ),
//           onPressed: widget.onSavedTodo,
//           child: Text('Save'),
//         ),
//       );

//   String numberValid(String value) {
//     if (value == null) {
//       return null;
//     }
//     final n = int.tryParse(value);
//     if (n == null) {
//       return ' "$value" is not valid number';
//     }
//     return null;
//   }
// }
