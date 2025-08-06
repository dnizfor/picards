import 'package:flutter/material.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/widgets/feed_screen_drawer.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);
    print(feedProvider.flashcardList);
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
      drawer: FeedScreenDrawer(),
      body: Container(),
    );
  }
}
