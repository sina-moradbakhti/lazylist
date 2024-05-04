import 'package:flutter/material.dart';
import 'package:lazylist/package_content/lazy_load_controller.dart';

class LazyList<T> extends StatefulWidget {
  final LazyListController<T> controller;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool reverse;
  final Axis scrollDirection;
  final VoidCallback? onInit;
  final Function(int currentPage)? onLoadMore;
  final Widget? loadingWidget;
  final bool loadingEnabled;

  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const LazyList({
    super.key,
    this.onInit,
    this.onLoadMore,
    this.padding,
    this.physics,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.loadingWidget,
    this.loadingEnabled = true,
  });

  @override
  State<LazyList<T>> createState() => _LazyListState<T>();
}

class _LazyListState<T> extends State<LazyList<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    widget.onInit?.call();
    widget.controller.addListener(_update);
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    _scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _update() {
    setState(() {}); // Trigger rebuild when controller changes
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.onLoadMore?.call(widget.controller.currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.controller.items.length;
    final Widget Function(BuildContext, int)? separatorBuilder =
        widget.separatorBuilder;

    if (separatorBuilder != null) {
      return Stack(
        children: [
          Center(
            child: ListView.separated(
              key: widget.key,
              controller: _scrollController,
              itemCount: itemCount,
              itemBuilder: (context, index) => widget.itemBuilder(
                context,
                index,
                widget.controller.items[index],
              ),
              separatorBuilder: separatorBuilder,
              padding: widget.padding,
              physics: widget.physics,
              reverse: widget.reverse,
              scrollDirection: widget.scrollDirection,
            ),
          ),
          if (widget.loadingEnabled && widget.controller.loading)
            widget.loadingWidget ??
                const Center(child: CircularProgressIndicator()),
        ],
      );
    }

    return Stack(
      children: [
        Center(
          child: ListView.builder(
            key: widget.key,
            controller: _scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) => widget.itemBuilder(
              context,
              index,
              widget.controller.items[index],
            ),
            padding: widget.padding,
            physics: widget.physics,
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
          ),
        ),
        if (widget.loadingEnabled && widget.controller.loading)
          widget.loadingWidget ??
              const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
