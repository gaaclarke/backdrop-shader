import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grayscale Shader'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.black,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // The background that will be filtered
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 175, 212, 176),
                        Color.fromARGB(255, 3, 28, 48),
                      ],
                    ),
                  ),
                ),
                // The content that will also be filtered
                const Center(
                  child: Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                // The clipped filter on top
                Center(
                  child: ClipRect(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: ShaderBuilder(
                        assetKey: 'shaders/grayscale.frag',
                        (context, shader, _) {
                          shader.setFloat(0, screenSize.width);
                          shader.setFloat(1, screenSize.height);
                          return BackdropFilter(
                            filter: ImageFilter.shader(shader),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}