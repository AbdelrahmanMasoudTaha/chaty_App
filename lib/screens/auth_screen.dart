import 'dart:io';
import 'package:chaty/widgets/user_img.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _islogin = true;
  String _enterdEmail = '';
  String _enterdUsername = '';
  String _enterdPasswoud = '';
  File? _selectedImageFile;
  bool _isUploading = false;

  void _supmit() async {
    bool vaild = _formKey.currentState!.validate();
    if (!vaild || (!_islogin && _selectedImageFile == null)) {
      return;
    }
    try {
      setState(() {
        _isUploading = true;
      });
      if (_islogin) {
        final UserCredential userCredential =
            await _firebase.signInWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPasswoud,
        );
      } else {
        final UserCredential userCredential =
            await _firebase.createUserWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPasswoud,
        );
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(_selectedImageFile!);
        final imgUrl = await storageRef.getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enterdUsername,
          'email': _enterdEmail,
          'img_url': imgUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication faild.'),
        ),
      );
      setState(() {
        _isUploading = false;
      });
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                width: 200,
                child: Image.asset('assets/img/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!_islogin)
                            UserImg(
                              onPickeImage: (pickedImg) {
                                _selectedImageFile = pickedImg;
                              },
                            ),
                          if (!_islogin)
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().length < 4) {
                                  return 'Please enter at least 4 character';
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  _enterdUsername = newValue!,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Username',
                                ),
                              ),
                            ),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email adderss';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enterdEmail = newValue!,
                            decoration: const InputDecoration(
                              label: Text(
                                'Email',
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password can\'t be less than 6 character';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enterdPasswoud = newValue!,
                            decoration: const InputDecoration(
                              label: Text(
                                'Password',
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_isUploading) const CircularProgressIndicator(),
                          if (!_isUploading)
                            ElevatedButton(
                              onPressed: _supmit,
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Text(_islogin ? 'Login' : 'Sign Up'),
                            ),
                          if (!_isUploading)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _islogin = !_islogin;
                                });
                              },
                              child: Text(_islogin
                                  ? 'Create an account'
                                  : 'I allredy have an account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
