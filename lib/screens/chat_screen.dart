import 'package:flutter/material.dart';
import 'home_screen.dart'; // we need the Doctor class
 
// A tiny model for one chat message.
class ChatMessage {
  final String text;
  final bool isMe; // true = patient (user), false = doctor
 
  ChatMessage({required this.text, required this.isMe});
}
 
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
 
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
 
class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
 
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello! I am your consulting doctor today. '
          'How can I help you?',
      isMe: false,
    ),
  ];
 
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
 
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return; // ignore empty messages
 
    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });
    _messageController.clear();
    _scrollToBottom();
 
    // Simulate the doctor typing and replying after 1.5 seconds.
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Thank you for sharing that. Could you tell me '
                'how long you have been experiencing this?',
            isMe: false,
          ));
        });
        _scrollToBottom();
      }
    });
  }
 
  void _scrollToBottom() {
    // Wait one frame so the new message is laid out, then scroll.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    // ─────────────────────────────────────────────
    // RECEIVING THE ARGUMENT sent from HomeScreen.
    // We cast it back to a Doctor object.
    // ─────────────────────────────────────────────
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        // The back arrow appears automatically (we were pushed),
        // and tapping it calls Navigator.pop(context) for us.
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.teal),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    doctor.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: doctor.isOnline
                          ? Colors.greenAccent
                          : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ── MESSAGE LIST ──
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  // My messages on the right, doctor's on the left.
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: message.isMe ? Colors.teal : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(message.isMe ? 16 : 4),
                        bottomRight: Radius.circular(message.isMe ? 4 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
 
          // ── MESSAGE INPUT BAR ──
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Describe your symptoms...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF0F2F5),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: const Icon(Icons.send,
                          color: Colors.white, size: 20),
                      onPressed: _sendMessage,
                    ),
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
