import '../routes/routes.dart';

enum Roles {
  registeredUser,
  unregisteredUser
  // guest
  ;

  // Roles.registeredUser.value
  String get value => switch (this) {
    registeredUser => "registered_user",
    unregisteredUser => "unregistered_user",
    // guest => "guest",
  };

 
  static Roles fromString(String? s) => switch (s) {
    'registered_user' => registeredUser,
    null || 'unregistered_user' => unregisteredUser,
    _ =>throw 'undefined role',
    // 'guest' => guest,
    // _ => throw 'undefined role',
  };

//TODO when we do the home page ..
  // بدل Pages.login    مؤقتًا هلق
  
  Pages get landingPage => switch (this) {
    unregisteredUser => Pages.login,
    registeredUser => Pages.login,
    // guest => Pages.login,
  };

  
}