import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unichat/userinfo.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatPopupOption extends StatefulWidget {
  const ChatPopupOption({super.key});

  @override
  State<ChatPopupOption> createState() => _ChatPopupOptionState();
}

class _ChatPopupOptionState extends State<ChatPopupOption> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      position: PopupMenuPosition.under,
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'New Chat',
            child: const ListTile(
              leading: Icon(CupertinoIcons.chat_bubble_2_fill,color: Colors.deepPurple,),
              title: Text(
                "New Chat",
                maxLines: 1,
              ),
            ),
            onTap: () {
              ZIMKit().showDefaultNewPeerChatDialog(context);
            },
          ),
          PopupMenuItem(
            value: 'New Group',
            child: const ListTile(
              leading: Icon(CupertinoIcons.person_2_fill,color: Colors.deepPurple,),
              title: Text(
                "New Group",
                maxLines: 1,
              ),
            ),
            onTap: () {
              ZIMKit().showDefaultNewGroupChatDialog(context);
            },
          ),
          PopupMenuItem(
            value: 'Join Group',
            child: const ListTile(
              leading: Icon(CupertinoIcons.person_3_fill,color: Colors.deepPurple,),
              title: Text(
                "Join Group",
                maxLines: 1,
              ),
            ),
            onTap: () {
              ZIMKit().showDefaultJoinGroupDialog(context);
            },
          ),
             PopupMenuItem(
            value: 'See Profile',
            child: const ListTile(
              leading: Icon(CupertinoIcons.person_fill,color: Colors.deepPurple,),
              title: Text(
                "See Profile",
                maxLines: 1,
              ),
            ),
            onTap: () {
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => UserInfoScreen()),
                );
            },
          ),
       
        ];
      },
    );
  }
}
