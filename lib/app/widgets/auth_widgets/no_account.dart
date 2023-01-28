import 'package:flutter/material.dart';

import '../../app.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Flexible(
          child: Text(
              'Please Create Account To Order products, share your product reviews, and save your favourite products to wishlist'),
        ),
        ElevatedButton(
            onPressed: () {
              context.authenticationRepository.logInWithGoogle();
            },
            child: const Text('Sign In With Google')),
        ElevatedButton(
            onPressed: () {
              context.authenticationRepository.logInWithEmailAndPassword(
                  email: "devomarkhaled615@gmail.com", password: "kk888888");
            },
            child: const Text('Sign In With Apple')),
      ],
    );
  }
}
