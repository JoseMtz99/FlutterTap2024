import 'package:flutter/material.dart';
import 'package:tap2024/models/popular_model.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;


  @override
  Widget build(BuildContext context) {
    final popularModel = ModalRoute.of(context)!.settings.arguments as PopularModel;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(popularModel.originalTitle),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            }, 
            icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}