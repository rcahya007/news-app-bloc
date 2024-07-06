// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/constants/styles.dart';
import 'package:news_app/data/models/response/news_response_model.dart';
import 'package:news_app/presentation/home/bloc/get_news_detail/get_news_detail_bloc.dart';

class CardNews extends StatelessWidget {
  final Article article;
  const CardNews({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    print('Ini card ${article.source!.name!}');

    return GestureDetector(
      onTap: () {
        context
            .read<GetNewsDetailBloc>()
            .add(GetNewsDetailEvent.getNewsDetail(article));
      },
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: blackColor,
              blurRadius: 0,
              spreadRadius: 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: '${article.publishedAt}',
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  image: DecorationImage(
                    image: Image.network(article.urlToImage ??
                            'https://placehold.co/800?text=No+Image&font=montserrat')
                        .image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: subHeading.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      height: 1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    article.description ?? 'No Description',
                    style: subHeading.copyWith(
                      height: 1,
                      fontSize: 12,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
