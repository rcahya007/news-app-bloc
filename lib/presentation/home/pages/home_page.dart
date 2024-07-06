import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/presentation/home/bloc/get_news_detail/get_news_detail_bloc.dart';
import 'package:news_app/presentation/home/widgets/card_news.dart';
import 'package:news_app/core/constants/styles.dart';
import 'package:news_app/presentation/home/bloc/get_news/get_news_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GetNewsBloc>().add(const GetNewsEvent.getNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Article article = Article(
    //   source: Source(
    //     id: 'associated-press',
    //     name: 'Associated Press',
    //   ),
    //   author: 'JILL LAWLESS',
    //   title:
    //       'UK general election 2024: Labour hopeful, Conservatives morose as polls open - The Associated Press',
    //   description:
    //       'British voters are picking a new government in a parliamentary election Thursday that is widely expected to bring the opposition Labour Party to power. Against a backdrop of economic malaise, mounting distrust of government institutions and a fraying social f…',
    //   url:
    //       'https://apnews.com/article/uk-election-labour-conservatives-polling-day-3c89a7974f05748943adfbebf03d3db6',
    //   urlToImage:
    //       'https://dims.apnews.com/dims4/default/90b963d/2147483647/strip/true/crop/3173x1785+0+166/resize/1440x810!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F9c%2Ff0%2Fcebe670fee7a402333acf7fb720f%2Fc357309bce904202910b2af855dac9c4',
    //   publishedAt: DateTime.parse('2024-07-04T07:29:00Z'),
    //   content:
    //       'LONDON (AP) British voters are picking a new government Thursday in a parliamentary election that is widely expected to bring the Labour Party to power against a gloomy backdrop of economic malaise, … [+3827 chars]',
    // );

    return Scaffold(
      body: SafeArea(
        child: BlocListener<GetNewsDetailBloc, GetNewsDetailState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (article) => context.goNamed('DetailNews'),
            );
          },
          child: BlocBuilder<GetNewsBloc, GetNewsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: Text(
                      'Something went wrong',
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (message) => Center(
                  child: Text(
                    message,
                  ),
                ),
                loaded: (news) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 28,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'News Page',
                        style: heading,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: CardNews(
                              article: news.articles![index],
                            ),
                          );
                        },
                        itemCount: news.articles!.length,
                      ),
                      // CardNews(article: article)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
