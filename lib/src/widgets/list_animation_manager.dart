import 'package:flutter/material.dart';

class ListAnimationManager<T> extends StatefulWidget {
  final List<T> items;
  final Widget child;
  final GlobalKey<AnimatedListState> listKey;
  final Widget Function(
    BuildContext,
    Animation<double>,
    T item,
  ) listItemBuilder;

  const ListAnimationManager({
    Key? key,
    this.items = const [],
    required this.listKey,
    required this.listItemBuilder,
    required this.child,
  }) : super(key: key);

  @override
  State<ListAnimationManager> createState() => _ListAnimationManagerState<T>();
}

class _ListAnimationManagerState<T> extends State<ListAnimationManager<T>> {
  @override
  void initState() {
    super.initState();

    _findAndAnimateDifferences(widget.items);
  }

  @override
  void didUpdateWidget(covariant ListAnimationManager<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _findAndAnimateDifferences(widget.items, oldItems: oldWidget.items);
  }

  void _findAndAnimateDifferences(
    List<T> newItems, {
    List<T> oldItems = const [],
  }) {
    _findIndexDifferences(newItems, oldItems).forEach((index) {
      widget.listKey.currentState?.insertItem(index);
    });

    _findIndexDifferences(oldItems, newItems).forEach((index) {
      final item = oldItems[index];

      widget.listKey.currentState?.removeItem(
        index,
        (context, animation) => widget.listItemBuilder(
          context,
          animation,
          item,
        ),
      );
    });
  }

  List<int> _findIndexDifferences(
    List<T> a, [
    List<T> b = const [],
  ]) {
    final difference = a.toSet().difference(b.toSet());

    return difference.map<int>((item) => a.indexOf(item)).toList();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
