import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'main.dart';

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({super.key});

  @override
  State<CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  Widget buttons(BuildContext context, List<dynamic> values) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: values.length,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          child: SizedBox(
            width: 200,
            child: RadioListTile(
              title: Text(values[index].cat_name),
              value: values[index].cat_id,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
                //print('${values[index].cat_name} value $value');
              },
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: buttons(context, category),
    );
  }
}