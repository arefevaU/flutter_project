import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'main.dart';

List product = products.where((prd) => prd.catId == 1).toList();

class CategoryButtons extends StatefulWidget {
  // const CategoryButtons({super.key});
  final VoidCallback function;
  CategoryButtons({Key? key, required this.function}) : super(key: key);

  @override
  State<CategoryButtons> createState() => CategoryButtonsState();
}

class CategoryButtonsState extends State<CategoryButtons> {
  void refresh() {
    //
  }
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
              title: Text(values[index].catName),
              value: values[index].catId,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                  filterProducts();
                });
                widget.function();
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
