import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> loadPosts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/posts.json');
      if (file.existsSync()) {
        final content = await file.readAsString();
        final List<dynamic> jsonData = json.decode(content);
        final posts = jsonData.map((data) => Post.fromJson(data)).toList();
        emit(PostLoaded(posts));
      } else {
        emit(PostLoaded([]));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> addPost() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/posts.json');
      final post = Post(
        username: 'Me',
        imageUrl: pickedFile.path,
        location: 'İstanbul/Türkiye',
        likes: '0',
      );
      final currentState = state;
      if (currentState is PostLoaded) {
        final updatedPosts = List<Post>.from(currentState.posts)..insert(0, post);
        await file.writeAsString(json.encode(updatedPosts.map((p) => p.toJson()).toList()));
        emit(PostLoaded(updatedPosts));
      }
    }
  }
}
