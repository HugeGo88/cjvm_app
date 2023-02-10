import 'package:flutter/material.dart';

import '../widgets/post_list.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PostList(
        category: 0,
      ),
    );
  }
}
