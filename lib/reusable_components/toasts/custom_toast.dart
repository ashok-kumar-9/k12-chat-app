import 'package:flash_chat/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?>? showCustomToast({message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: AppColors.white,
    textColor: AppColors.blue,
  );
  return null;
}
