import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';

showWarningBottomSheet(context, heading) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                heading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: CustomMeasurements.popupOptionHeight,
                      color: Colors.red,
                      padding: const EdgeInsets.all(8),
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
                      height: CustomMeasurements.popupOptionHeight,
                      color: Colors.green,
                      padding: const EdgeInsets.all(8),
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