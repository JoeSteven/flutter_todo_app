import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingView extends StatelessWidget {
  final bool show;

  LoadingView(this.show);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      show? EasyLoading.show() : EasyLoading.dismiss();
    });
    return Container(
      width: 0,
      height: 0,
    );
  }
}
