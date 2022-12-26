// import 'package:flutter/material.dart';
//
// class AuthForm extends StatefulWidget {
//   AuthForm(this.submitFN, this.isLoading);
//
//   final bool isLoading;
//
//   final void Function(
//       String email,
//       String password,
//       String userName,
//       bool isLogin,
//       BuildContext ctx,) submitFN;
//
//
//
//
//
//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }
//
// class _AuthFormState extends State<AuthForm> {
//   final _formKey = GlobalKey<FormState>();
//   var _isLogin = true;
//   var _userEmail = '';
//   var _userName = '';
//   var _userPassword = '';
//
//   void _trySubmit() {
//     final isValid = _formKey.currentState?.validate();
//     FocusScope.of(context).unfocus();
//
//     if (isValid!) {
//       _formKey.currentState?.validate();
//       widget.submitFN(
//         _userEmail.trim(),
//         _userName.trim(),
//         _userPassword.trim(),
//         _isLogin,
//         context,
//       );
//       // print(_userEmail);
//       // print(_userName);
//       // print(_userPassword);
//
//       // Use those values to send our auth request ...
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextFormField(
//                     key: ValueKey('email'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter email";
//                       } else if (!value.contains("@")) {
//                         return "Please enter valid email";
//                       }
//                       return null;
//                     },
//                     //   //if (value.isEmpty || !value?.contains('@')) {
//                     //     return 'Please enter a valid email address.';
//                     //   }
//                     //   return null;
//                     // },
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(labelText: 'Email address'),
//                     onSaved: (value) {
//                       _userEmail = value!;
//                     },
//                   ),
//                   TextFormField(
//                     key: ValueKey('userName'),
//                     validator: (value) {
//                       if (value.isEmpty || !value.length < 4) {
//                         return 'Please enter at least 4 characters';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(labelText: 'Username'),
//                     onSaved: (value) {
//                       _userName = value!;
//                     },
//                   ),
//                   if (!_isLogin)
//                     TextFormField(
//                       key: ValueKey('Password'),
//                       validator: (value) {
//                         if (value.isEmpty || !value.length < 8) {
//                           return 'Password must be at least 8 characters long... ';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                       onSaved: (value) {
//                         _userPassword = value!;
//                       },
//                     ),
//                   SizedBox(height: 12,),
//                   if (widget.isLoading) CircularProgressIndicator(),
//                   if (!widget.isLoading)
//                   ElevatedButton(
//                     onPressed: _trySubmit,
//                     child: Text(_isLogin ? 'Login' : 'Signup'),
//                   ),
//                   if (!widget.isLoading)
//                   FloatingActionButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLogin = !_isLogin;
//                       });
//                     },
//                     child: Text(_isLogin
//                         ? 'Create new account'
//                         : 'I already have an account'),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
//import 'package:flutter_chat/widgets/pickers/user_image_picker.dart';
import '../screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthForm extends StatefulWidget {
AuthForm(
this.submitFn,
this.isLoading,
);
final bool isLoading;
final void Function(
String email,
String userName,
File? image,
String password,
bool isLogin,
BuildContext ctx,
) submitFn;

@override
State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
final _formKey = GlobalKey<FormState>();
var _isLogin = true;
var _userEmail = '';
var _userPassword = '';
var _userName = '';
File? _userImageFile;

void _pickedImage(File image) {
_userImageFile = image;
}

TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();


void _trySubmit() {
bool isValid = _formKey.currentState!.validate();


FocusScope.of(context).unfocus();

if (_userImageFile == null && !_isLogin) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Please pick an image'),
backgroundColor: Theme.of(context).errorColor,
),
);
return;
}

if (isValid) {
//_formKey.currentState!.save();
//print(emailController.text);
//print(nameController.text);
//print(passwordController.text);

widget.submitFn(
/*_userEmail,
        _userName,
        _userPassword,
        _userImageFile,
        _isLogin,
        context,*/

emailController.text,
nameController.text,
_userImageFile,
passwordController.text,
_isLogin,
context,
);
}
}

@override
Widget build(BuildContext context) {
return Center(
child: Card(
margin: EdgeInsets.all(20),
child: SingleChildScrollView(
child: Padding(
padding: EdgeInsets.all(16),
child: Form(
key: _formKey,
child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
if (!_isLogin)
//UserImagePicker(),
TextFormField(
key: ValueKey('email'),
validator: (value) {
if (value!.isEmpty || !value.contains('@')) {
return 'Please enter a valid email address';
}
return null;
},
keyboardType: TextInputType.emailAddress,
decoration: InputDecoration(labelText: 'Email address'),
controller: emailController,
),
if (!_isLogin)
TextFormField(
key: ValueKey('username'),
validator: (value) {
if (value!.isEmpty || value.length < 4) {
return 'Username should contain at least 4 characters';
}
return null;
},
decoration: InputDecoration(labelText: 'UserName'),
controller: nameController,
),
TextFormField(
key: ValueKey('password'),
validator: (value) {
if (value!.isEmpty || value.length < 7) {
return 'Password must be at least 7 characters long';
}
return null;
},
decoration: InputDecoration(labelText: 'Password'),
obscureText: true,
controller: passwordController,
),
SizedBox(height: 12),
if

(widget.isLoading) CircularProgressIndicator(),
if (!widget.isLoading)
ElevatedButton(
onPressed: () {
_trySubmit();
},
child: Text(_isLogin ? 'LogIn' : 'Signup'),
),
if (!widget.isLoading)
TextButton(
onPressed: () {
setState(() {
_isLogin = !_isLogin;
});
},
child: Text(_isLogin
? 'Create new account'
    : 'I already have an account'),
),
],
),
),
),
),
),
);
}
}
