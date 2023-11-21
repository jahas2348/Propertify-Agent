// import 'package:flutter/material.dart';
// import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
// import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
// import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
// import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

// class ChatSingleScreen extends StatelessWidget {
//   ChatSingleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             customSpaces.verticalspace20,
//             Padding(
//               padding: customPaddings.horizontalpadding20,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CustomIconBox(
//                           boxheight: 40,
//                           boxwidth: 40,
//                           boxIcon: Icons.arrow_back,
//                           radius: 8,
//                           boxColor: Colors.grey.shade300,
//                           iconSize: 20),
//                       customSpaces.horizontalspace20,
//                       Text(
//                         "David James",
//                         style: AppFonts.SecondaryColorText20,
//                       ),
//                     ],
//                   ),
//                   CustomIconBox(
//                     iconFunction: () {

//                     },
//                           boxheight: 40,
//                           boxwidth: 40,
//                           boxIcon: Icons.more_vert_outlined,
//                           radius: 8,
//                           boxColor: Colors.transparent,
//                           iconSize: 20),

//                 ],
//               ),
//             ),
//             customSpaces.verticalspace20,
//             Padding(
//               padding: customPaddings.horizontalpadding20,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(),
//                   customSpaces.horizontalspace20,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Text(
//                             'This property is mostly wooded',
//                             style: AppFonts.SecondaryColorText14,
//                           ),
//                         ),
//                       ),
//                       customSpaces.verticalspace10,
//                       Text(
//                         '12:15 PM',
//                         style: AppFonts.greyText14,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             customSpaces.verticalspace20,
//             Padding(
//               padding: customPaddings.horizontalpadding20,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Text(
//                             'Located right in the heart of Upstate',
//                             style: AppFonts.SecondaryColorText14,
//                           ),
//                         ),
//                       ),
//                       customSpaces.verticalspace10,
//                       Text(
//                         '12:18 PM',
//                         style: AppFonts.greyText14,
//                       )
//                     ],
//                   ),
//                   customSpaces.horizontalspace20,
//                   CircleAvatar(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../models/request_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../resources/app_urls/app_urls.dart';
class ChatSingleScreen extends StatefulWidget {
  final Rx<RequestModel> request;
  
  ChatSingleScreen({Key? key, required this.request, })
      : super(key: key);

  @override
  _ChatSingleScreenState createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  TextEditingController messageController = TextEditingController();
  final RxList<String> messages = <String>[].obs;

  // Create a chat room and inform the server
  final roomName = 'unique_room_name'; // Generate a unique room name

  // Use the same room name as in NotificationSingleScreen
  late  IO.Socket socket;
  @override
  void initState() {
    super.initState();

   socket = IO.io(AppUrl.baseUrl,OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .setExtraHeaders({'foo': 'bar'}) // optional
      .build()
  );
socket.connect(); // Replace with your server URL
    
    print('Connection Established');
    
    // Identify the user or agent role
    final role = 'agent'; // Replace with 'user' for user app
    socket.emit('identify', role);
   
    // Create a chat room and inform the server
    final roomName = 'unique_room_name'; // Generate a unique room name
    socket.emit('createRoom', roomName);


    socket.on('message', (data) {
      // Add the new message to the list
      messages.add(data['message']);
    });
  }

  sendMessage(String message) async {
    // Send the message to the server
    socket.emit('message', {
      'roomName': roomName,
      'message': message,
    });
    socket.on('message', (data) {
      // Add the new message to the list
      messages.add(data['message']);
      print(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.request.value.user!.username}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Container(
                color: Colors.grey.shade200,
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Text(messages[index], style: TextStyle(
                      color: Colors.black,
                    ),);
                    
                  },
                ),
              );
            }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(labelText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  final message = messageController.text;
                  if (message.isNotEmpty) {
                    print(message);
                   
                    await sendMessage(message,);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}