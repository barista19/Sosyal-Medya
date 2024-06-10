part of 'post_cubit.dart';

class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
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

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'imageUrl': imageUrl,
      'location': location,
      'likes': likes,
    };
  }
}
