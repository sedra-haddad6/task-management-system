import '../routes/routes.dart';

enum Roles {
  admin,
  member,
  unregisteredUser
  // guest
  ;

  // Roles.registeredUser.value
  String get value => switch (this) {
    admin => "admin",
    member => "member",
    unregisteredUser => "unregistered_user",
    // guest => "guest",
  };

 
  static Roles fromString(String? s) => switch (s) {
    'admin' => admin,
    'member' => member,
    null || 'unregistered_user' => unregisteredUser,
    _ =>throw 'undefined role',
    // 'guest' => guest,
    // _ => throw 'undefined role',
  };

//TODO بس نضيف صفحات لازم نغيرهم 
  
  Pages get landingPage => switch (this) {
    admin => Pages.login,     // 👈 TODO: لازم تضيفها بالـ Pages enum
    member => Pages.login,
    unregisteredUser => Pages.login,
    
    // guest => Pages.login,
  };

  
}