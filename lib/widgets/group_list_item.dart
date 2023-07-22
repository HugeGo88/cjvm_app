import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/pages/detail_elementes/html_content.dart';
import 'package:cjvm_app/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/color_utils.dart' as color_utils;
import '../utils/constants.dart';
import 'cached_image.dart';
import 'loading_fullscreen.dart';

class GroupListItem extends StatefulWidget {
  final NavigationItemEntitiy groupName;

  const GroupListItem(this.groupName, {super.key});

  @override
  State<GroupListItem> createState() => _GroupListItemState();
}

class _GroupListItemState extends State<GroupListItem> {
  String htmlContent = "";
  String? imageUrl = "";

  void getData() {
    //TODO create function to handle all the calls
    //TODO needs to be fixed
    String requestUrl = "${baseUrl}pages?slug=${widget.groupName.slug}";
    WpApi.getPageList(requestUrl: requestUrl).then(
      (pages) {
        setState(
          () {
            if (pages.isNotEmpty && widget.groupName.slug != "") {
              htmlContent = pages[0].content;
              imageUrl = pages[0].pictureUrl;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        htmlContent != "" || widget.groupName.childItems.isNotEmpty
            ? Navigator.push(
                context,
                platformPageRoute(
                    builder: (context) => widget.groupName.childItems.isNotEmpty
                        ? PlatformScaffold(
                            iosContentPadding: true,
                            appBar: PlatformAppBar(
                              title: Text(widget.groupName.title),
                            ),
                            body: Builder(
                              builder: (context) {
                                return GroupList(widget.groupName.childItems);
                              },
                            ),
                          )
                        : PlatformScaffold(
                            iosContentPadding: true,
                            appBar: PlatformAppBar(
                                title: Text(widget.groupName.title)),
                            body: htmlContent == ""
                                ? const LoadingFullscreen()
                                : HtmlContent(htmlContent),
                          ),
                    context: context),
              )
            : {};
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: edgePadding),
            child: htmlContent != "" || widget.groupName.childItems.isNotEmpty
                ? CachedImage(
                    url: imageUrl ?? "",
                    height: listHeight,
                    width: listWidth,
                    fit: BoxFit.cover)
                : SizedBox(
                    width: listWidth,
                    height: listHeight,
                    child: PlatformCircularProgressIndicator()),
          ),
          Expanded(
            child: SizedBox(
              height: listHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.groupName.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.apply(fontWeightDelta: 1),
                    ),
                  ),
                  htmlContent != "" || widget.groupName.childItems.isNotEmpty
                      ? Icon(
                          PlatformIcons(context).forward,
                          color: color_utils.commonThemeData.primaryColor,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
