import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomSearchBar({
    Key? key,
    @required this.onChanged,
    @required this.controller,
  }) : super(key: key);

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    setState(() {
      textController = widget.controller ?? TextEditingController(text: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              onChanged: (value) {
                widget.onChanged!(value);
              },
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                filled: true,
                hintText:
                    'Search for a doctor here',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 11),
                contentPadding: EdgeInsets.only(left: 16, right: 8),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
