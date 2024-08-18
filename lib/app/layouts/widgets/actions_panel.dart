import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:ui_commons/ui_commons.dart';

class RightActionsPanel extends StatefulWidget {
  const RightActionsPanel({super.key});

  @override
  State<RightActionsPanel> createState() => _RightActionsPanelState();
}

class _RightActionsPanelState extends State<RightActionsPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust width as needed
      // Replace with your desired color
      //white border left
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: CustomColors.white.withOpacity(0.4),
            width: 0.3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            notificationsList(),
            const SizedBox(
              height: 10,
            ),
            activitiesList()
          ],
        ),
      ),
    );
  }

  Widget notificationTile(
      {required String title,
      required String message,
      String? time,
      required String type}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: customSvgIcon(
                path: getNotificationIcon(type),
                width: 30,
                height: 30,
                iconColor: Colors.black),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 5),
              Text(
                time ?? "Just now",
                style: TextStyle(
                    color: CustomColors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget activityTile(
      {required String img, required String message, required String time}) {
    return Row(
      children: [
        const SizedBox(
          width: 50,
          height: 50,
          child: BlingUserCircleAvatar(
            imagePath: "assets/icons/profile.jpg",
            isOnline: false,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                  color: CustomColors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        )
      ],
    );
  }

  Widget notificationsList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notifications',
          style: TextStyle(color: CustomColors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
        //list of notifications
        notificationTile(
            title: "New User",
            message: "New user has been registered",
            time: "2 hours ago",
            type: "user"),
        const SizedBox(height: 10),
        notificationTile(
            title: "Warning",
            message: "You have reached your limit",
            time: "2 hours ago",
            type: "user"),
        const SizedBox(height: 10),

        notificationTile(
            title: "Error",
            message: "An error has occured",
            time: "2 hours ago",
            type: "user"),
      ],
    );
  }

  Widget activitiesList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activities',
          style: TextStyle(color: CustomColors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
        //list of notifications
        activityTile(
            message: "New user has been registered",
            time: "2 hours ago",
            img: "assets/icons/profile.jpg"),
        const SizedBox(height: 10),
        activityTile(
            message: "You have reached your limit",
            img: "assets/icons/profile.jpg",
            time: "2 hours ago"),
        const SizedBox(height: 10),

        activityTile(
          message: "An error has occured",
          img: "assets/icons/profile.jpg",
          time: "2 hours ago",
        ),
      ],
    );
  }

  Widget activeClientsList() {
    return const SizedBox();
  }

  //get notification icon
  String getNotificationIcon(String type) {
    switch (type) {
      case "info":
        return "assets/icons/info.svg";
      case "warning":
        return "assets/icons/warning.svg";
      case "user":
        return "assets/icons/user-circle.svg";
      case "error":
        return "assets/icons/error.svg";
      default:
        return "assets/icons/info.svg";
    }
  }
}
