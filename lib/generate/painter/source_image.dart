import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class WidgetSizeRenderObject extends RenderProxyBox {
  final OnWidgetSizeChange onSizeChange;
  Size? currentSize;

  WidgetSizeRenderObject(this.onSizeChange);

  @override
  void performLayout() {
    super.performLayout();

    try {
      Size? newSize = child?.size;

      if (newSize != null && currentSize != newSize) {
        currentSize = newSize;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          onSizeChange(newSize);
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

class WidgetSizeOffsetWrapper extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onSizeChange;

  const WidgetSizeOffsetWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WidgetSizeRenderObject(onSizeChange);
  }
}

class WidgetSizeAndPositionExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetSizeAndPositionExampleState();
  }
}

class _WidgetSizeAndPositionExampleState
    extends State<WidgetSizeAndPositionExample> {
  double _size = 300;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Center(
            // left: 50,
            // top: 100,
            child: WidgetSizeOffsetWrapper(
              onSizeChange: (Size size) {
                print('Size: ${size.width}, ${size.height}');
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                width: _size,
                height: _size,
                color: Colors.teal,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _size = _size == 300 ? 100 : 300;
                });
              },
              child: const Text('Change size'),
            ),
          ),
        ],
      ),
    );
  }
}
