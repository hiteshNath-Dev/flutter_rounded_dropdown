import 'package:flutter/material.dart';

class RoundedDropDown extends StatefulWidget {
  final List<String> dropDownItems;
  final String initialDropDownValue;
  final Function(String) onValueChanged;
  final Color borderColor;
  final IconData openIcon;
  final IconData closeIcon;
  final Color checkIconColor;
  final IconData checkIcon;

  const RoundedDropDown({
    super.key,
    required this.dropDownItems,
    required this.initialDropDownValue,
    required this.onValueChanged,
    this.borderColor = Colors.grey,
    this.openIcon = Icons.keyboard_arrow_down_rounded,
    this.closeIcon = Icons.keyboard_arrow_up_rounded,
    this.checkIconColor = Colors.green,
    this.checkIcon = Icons.check,
  });

  @override
  State<RoundedDropDown> createState() => _RoundedDropDownState();
}

class _RoundedDropDownState extends State<RoundedDropDown>
    with WidgetsBindingObserver {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late String dropDownValue;
  bool isDropDownOpened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    dropDownValue = widget.initialDropDownValue;
  }

  @override
  void dispose() {
    _removeOverlayEntry();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.paused) {
      _removeOverlayEntry();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _removeOverlayEntry() {
    if (isDropDownOpened) {
      _overlayEntry?.remove();
      isDropDownOpened = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: widget.borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dropDownValue,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              isDropDownOpened ? Icon(widget.closeIcon) : Icon(widget.openIcon)
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (isDropDownOpened) {
      _overlayEntry?.remove();
      setState(() {
        isDropDownOpened = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() {
        isDropDownOpened = true;
      });
    }
  }

  OverlayEntry? _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (context) {
      return Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5.0),
            child: Material(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: widget.borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 4.0,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.dropDownItems.map((String item) {
                  return ListTile(
                    title: Text(item),
                    titleTextStyle: Theme.of(context).textTheme.headlineSmall,
                    trailing: item == dropDownValue
                        ? Icon(
                            widget.checkIcon,
                            color: widget.checkIconColor,
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        dropDownValue = item;
                        widget.onValueChanged(dropDownValue);
                        _toggleDropdown();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ));
    });
  }
}
