import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/styles.dart';

import 'package:news_app/data/models/response/news_response_model.dart';

class DetailNewsPage extends StatefulWidget {
  final Article article;
  const DetailNewsPage({
    super.key,
    required this.article,
  });

  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Hero(
                      tag: '${widget.article.publishedAt!}',
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network(widget.article.urlToImage ??
                                    'https://placehold.co/800?text=No+Image&font=montserrat')
                                .image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
