import 'package:flutter/material.dart';

class GenerateToken extends StatefulWidget {
  const GenerateToken({Key? key}) : super(key: key);

  @override
  State<GenerateToken> createState() => _GenerateTokenState();
}

class _GenerateTokenState extends State<GenerateToken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Token"),
      ),
    );
  }
}
