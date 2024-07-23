import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:ui_commons/ui_commons.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String projectIcon;
  final String userIcon;
  final String date;
  final String status;
  final double progress;
  const ProjectCard(
      {super.key,
      required this.title,
      required this.projectIcon,
      required this.userIcon,
      required this.date,
      required this.progress,
      required this.status});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: const BoxDecoration(
          color: CustomColors.lightBackGround,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: CustomColors.white.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Due Date: ${widget.date}',
                          style: TextStyle(
                              color: CustomColors.white.withOpacity(0.4),
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: CustomColors.lightBackGround,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: customSvgIcon(
                      path: widget.projectIcon,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlingUserCircleAvatar(
                      imagePath: widget.userIcon, isOnline: true),
                  Row(
                    children: [
                      // Circle dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors
                              .orange, // you can change the color as needed
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                          width: 8), // Space between the dot and the text
                      // Status text
                      Text(
                        widget.status,
                        style: TextStyle(
                            color: CustomColors.orange.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      // width: 100.0,
                      lineHeight: 8.0,
                      percent: widget.progress,
                      progressColor: CustomColors.orange,
                      barRadius: const Radius.circular(10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '10/34 Total Tasks',
                            style: TextStyle(
                                color: CustomColors.white.withOpacity(0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            '${(widget.progress * 100).toInt()}%',
                            style: TextStyle(
                                color: CustomColors.white.withOpacity(0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
