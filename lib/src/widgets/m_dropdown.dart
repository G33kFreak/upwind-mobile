import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';

typedef ItemSelected<T> = void Function(T);
typedef ItemBuilder<T> = Widget Function(T);

class MDropdown<T> extends StatefulWidget {
  final List<T> items;
  final ItemSelected<T> onItemSelected;
  final ItemBuilder<T> itemBuilder;

  const MDropdown({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<MDropdown> createState() => _MDropdownState<T>();
}

class _MDropdownState<T> extends State<MDropdown<T>> {
  late T _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.items.first;
    super.initState();
  }

  void _onItemSelected(T? newItem) {
    if (newItem != null && newItem != _selectedItem) {
      setState(() {
        _selectedItem = newItem;
      });
      widget.onItemSelected(newItem);
    }
  }

  DropdownMenuItem<T> _getDropdownMenuItem(T item) => DropdownMenuItem(
        value: item,
        child: widget.itemBuilder(item),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textGrey.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          )
        ],
      ),
      child: DropdownButton<T>(
        value: _selectedItem,
        isExpanded: true,
        items: widget.items.map(_getDropdownMenuItem).toList(),
        onChanged: _onItemSelected,
      ),
    );
  }
}
