import 'package:flutter/material.dart';

import 'board_item.dart';
import 'boardview.dart';

class BoardList extends StatefulWidget {
  final List<BoardItem>? items;
  final BoardViewState? boardView;
  final void Function(int? listIndex, int? oldListIndex)? onDropList;
  final void Function(int? listIndex)? onTapList;
  final void Function(int? listIndex)? onStartDragList;
  final BoxScrollView Function(NullableIndexedWidgetBuilder itemBuilder)?
      listBuilder;
  final bool draggable;
  final Function(Widget child) listContainer;
  final List<Widget> header;

  const BoardList({
    super.key,
    this.items,
    this.boardView,
    this.draggable = true,
    this.index,
    this.onDropList,
    this.onTapList,
    this.onStartDragList,
    this.listBuilder,
    required this.header,
    required this.listContainer,
  });

  final int? index;

  @override
  State<StatefulWidget> createState() {
    return BoardListState();
  }
}

class BoardListState extends State<BoardList>
    with AutomaticKeepAliveClientMixin {
  List<BoardItemState> itemStates = [];
  ScrollController boardListController = ScrollController();

  void onDropList(int? listIndex) {
    if (widget.onDropList != null) {
      widget.onDropList!(listIndex, widget.boardView!.startListIndex);
    }
    widget.boardView!.draggedListIndex = null;
    if (widget.boardView!.mounted) {
      widget.boardView!.setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;

  Widget _itemBuilder(ctx, index) {
    if (widget.items![index].boardList == null ||
        widget.items![index].index != index ||
        widget.items![index].boardList!.widget.index != widget.index ||
        widget.items![index].boardList != this) {
      widget.items![index] = BoardItem(
        boardList: this,
        item: widget.items![index].item,
        draggable: widget.items![index].draggable,
        index: index,
        onDropItem: widget.items![index].onDropItem,
        onTapItem: widget.items![index].onTapItem,
        onDragItem: widget.items![index].onDragItem,
        onStartDragItem: widget.items![index].onStartDragItem,
      );
    }
    if (widget.boardView!.draggedItemIndex == index &&
        widget.boardView!.draggedListIndex == widget.index) {
      return Opacity(
        opacity: 0.0,
        child: widget.items![index],
      );
    } else {
      return widget.items![index];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget listWidgets;

    if (widget.listBuilder != null) {
      listWidgets = widget.listBuilder!(_itemBuilder);
    } else {
      listWidgets = ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: boardListController,
        itemCount: widget.items!.length,
        itemBuilder: _itemBuilder,
      );
    }

    if (widget.boardView!.listStates.length > widget.index!) {
      widget.boardView!.listStates.removeAt(widget.index!);
    }
    widget.boardView!.listStates.insert(widget.index!, this);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.header,
        Expanded(
          child: widget.listContainer(listWidgets),
        ),
      ],
    );
  }
}
