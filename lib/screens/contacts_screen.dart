import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:iconsax/iconsax.dart';
import 'package:yojo_chats/utils/placeholder/post_search_delegate.dart';
import 'package:yojo_chats/widgets/buttons/cpopup_menu_button.dart';

import '../utils/placeholder/post.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Post> posts = <Post>[];

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  Future<void> _getPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final bodyJson = jsonDecode(response.body) as List;

      setState(() {
        posts = bodyJson
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(
          'YoJo\' Chats',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.normal),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: PostSearchDelegate(posts: posts),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              final popupMenu = CPopupMenuButton();
              popupMenu._showPopupMenu(context);
            },
          ),
        ],
      ),
      body:
      //const PostList(posts: posts),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView(),
          ),
        ],
      ),
    );
  }
