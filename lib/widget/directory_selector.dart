import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/model/directory.dart';
import 'package:legalis/theme.dart';

class DirectorySelector extends StatelessWidget {
  final List<Directory> directories;
  final Directory? selected;
  final Function? onDirectorySelected;

  const DirectorySelector(
      {Key? key,
      required this.directories,
      this.selected,
      this.onDirectorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Container(
      decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(8),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
            hasIcon: false,
            useInkWell: true,
            alignment: Alignment.center,
            iconPadding: EdgeInsets.all(0),
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Center(
            child: Column(
          children: const [
            Text("DIRECTORIOS",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white70,
            )
          ],
        )),
        collapsed: const SizedBox(),
        expanded: GridView.builder(
            padding: const EdgeInsets.only(top: 16),
            physics: const ScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: directories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1, mainAxisExtent: 85),
            itemBuilder: (context, index) {
              final item = directories[index];
              final isSelected = item.id == selected?.id;
              return GestureDetector(
                onTap: () {
                  onDirectorySelected?.call(item);
                  ExpandableController.of(context)?.toggle();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      item.icon != null
                          ? SvgPicture.string(
                              item.icon!,
                              width: 24,
                              height: 24,
                              color:
                                  isSelected ? AppTheme.accent : Colors.white70,
                            )
                          : Icon(
                              Icons.info_rounded,
                              size: 24,
                              color:
                                  isSelected ? AppTheme.accent : Colors.white70,
                            ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        item.name!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:
                                isSelected ? AppTheme.accent : Colors.white70),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    ));
  }
}
