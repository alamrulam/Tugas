class Post {
  Post({
    required this.userId,
    required this.title,
    required this.body,

  });

   final int userId;
   final String title;
   final String body;

   factory Post.fromjson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'], 
      title: json['title'],
      body: json['body'],
      );
   }
}