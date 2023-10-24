import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(top: 120.0, bottom: 76),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/chatbg.png'), fit: BoxFit.cover)),
            child: FadedScaleAnimation(
              MessageStream(),
              durationInMilliseconds: 400,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 16),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(
                        width: 75,
                      ),
                      Text(
                        'George Anderson',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xffECF4F7),
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 12),
                  child: Text(
                    locale.deliveryPartner!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 11, color: Color(0xff999999)),
                  ),
                ),
              ],
            ),
          ),
          Positioned.directional(
              textDirection: Directionality.of(context),
              start: 50,
              top: 52,
              child: FadedScaleAnimation(
                Image.asset(
                  'assets/deliveryman.png',
                  height: 60,
                  width: 60,
                ),
                durationInMilliseconds: 400,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextFormField(
              decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  hintText: locale.writeYourMsg,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 13.5, color: Color(0xffa2a2a2)),
                  suffixIcon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MessageBubble> messageBubbles = [
      MessageBubble(
        sender: 'user',
        text: AppLocalizations.of(context)!.msg1,
        time: '11:58 am',
        isDelivered: false,
        isMe: true,
      ),
      MessageBubble(
        sender: 'delivery_partner',
        text: AppLocalizations.of(context)!.msg2,
        time: '11:59 am',
        isDelivered: false,
        isMe: false,
      ),
    ];
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      children: messageBubbles,
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool? isMe;
  final String? text;
  final String? sender;
  final String? time;
  final bool? isDelivered;

  MessageBubble(
      {this.sender, this.text, this.time, this.isMe, this.isDelivered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: isMe!
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text!,
                    textAlign: !isMe! ? TextAlign.left : TextAlign.right,
                    style: isMe!
                        ? Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 13.5,
                            color: Theme.of(context).scaffoldBackgroundColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.5),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        time!,
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              isMe! ? Color(0xff99b8f7ee) : Color(0xff474d4d4d),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      isMe!
                          ? Icon(
                              Icons.check_circle,
                              color:
                                  isDelivered! ? Colors.blue : Colors.grey[300],
                              size: 12.0,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
