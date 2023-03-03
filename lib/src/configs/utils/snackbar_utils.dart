import 'package:flutter/material.dart';
import 'package:test_project/src/configs/utils/routes_utils.dart';

//dp({msg, arg}) => debugPrint("\n\x1B[32m $msg =$arg \n ");

pe({msg, arg}) => debugPrint(
      "\n\x1B[32m $msg =$arg \n ",
    );

dp({msg, arg}) {
  debugPrint("====   $msg                  $arg  ====");
}

showErrorSnackBarMessage(
    {required String content,
    Color backgroundcolor = Colors.red,
    Color contentColor = Colors.white}) {
  ScaffoldMessenger.of(RoutesUtils.cNavigatorState.currentState!.context)
      .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5))),
          backgroundColor: backgroundcolor,
          content: Text(
            content,
            style: TextStyle(
                color: contentColor, fontWeight: FontWeight.w600, fontSize: 13),
            overflow: TextOverflow.visible,
          )));
}

showSucessrSnackBarMessage(
    {required String content,
    Color backgroundcolor = Colors.green,
    Color contentColor = Colors.white}) {
  ScaffoldMessenger.of(RoutesUtils.cNavigatorState.currentState!.context)
      .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5))),
          backgroundColor: backgroundcolor,
          content: Text(
            content,
            style: TextStyle(
                color: contentColor, fontWeight: FontWeight.w600, fontSize: 13),
            overflow: TextOverflow.visible,
          )));
}

Future<void> showMyDialog(String title, String message) async {
  return showDialog<void>(
    context: RoutesUtils.cNavigatorState.currentState!.context,

    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          message,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Login'),
            onPressed: () {
              //toNext(context: context, widget: logIn());
              //  Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showImageOptionDialog(
  void Function()? onGalleryPressed,
  void Function()? onCameraPressed,
) async {
  return showDialog(
      context: RoutesUtils.cNavigatorState.currentState!.context,
      builder: ((context) => SimpleDialog(
            title: const Text("Select Image"),
            children: [
              Row(
                children: [
                  SimpleDialogOption(
                    onPressed: onGalleryPressed,
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                  SimpleDialogOption(
                      onPressed: onCameraPressed,
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Camera"),
                        ],
                      )),
                ],
              )
            ],
          )));
}
