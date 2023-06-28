import 'package:flash_chat/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';

showWarningBottomSheet(context, heading) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: ScreenSize.screenHeight * 0.2,
          color: AppColors.sendChatColor,
          padding: const EdgeInsets.all(PaddingConstants.padding1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                heading,
                style: Theme.of(context).textTheme.h2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: AppColors.red,
                      padding: const EdgeInsets.all(PaddingConstants.padding1),
                      child: const Center(
                        child: Text(
                          'Yes',
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: AppColors.green,
                      padding: const EdgeInsets.all(PaddingConstants.padding1),
                      child: const Center(
                        child: Text(
                          'No',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
