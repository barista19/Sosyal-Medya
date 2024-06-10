import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../darkmode_provider.dart';
import '../language_provider.dart';
import 'package:sosyalmedya/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Post>> fetchPosts() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/posts.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.isEnglish ? 'Social Media' : 'Sosyal Medya'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Consumer2<DarkModeProvider, LanguageProvider>(
                    builder: (context, darkModeProvider, languageProvider, _) {
                      return Row(
                        children: [
                          Text(languageProvider.isEnglish ? 'Dark Mode:' : 'Karanlık Mod:'),
                          Spacer(),
                          Switch(
                            value: darkModeProvider.isDarkMode,
                            onChanged: (value) {
                              darkModeProvider.toggleDarkMode(value);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: Consumer<LanguageProvider>(
                    builder: (context, languageProvider, _) {
                      return Row(
                        children: [
                          Text(languageProvider.isEnglish ? 'English:' : 'İngilizce:'),
                          Spacer(),
                          Switch(
                            value: languageProvider.isEnglish,
                            onChanged: (value) {
                              languageProvider.toggleLanguage(value);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final posts = snapshot.data as List<Post>;
            return Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, _) {
                return ListView.builder(
                  itemCount: posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          languageProvider.isEnglish ? 'All Posts' : 'Tüm Paylaşımlar',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: darkModeProvider.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    } else {
                      final post = posts[index - 1];
                      return PostItem(
                        post: post,
                        isDarkMode: darkModeProvider.isDarkMode,
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Post {
  final String username;
  final String imageUrl;
  final String location;
  final String likes;

  Post({required this.username, required this.imageUrl, required this.location, required this.likes});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      likes: json['likes'],
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  final bool isDarkMode;

  const PostItem({Key? key, required this.post, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.imageUrl),
            ),
            title: Text(
              post.username,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            subtitle: Text(
              post.location,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          Image.network(post.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${post.likes} likes',
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
