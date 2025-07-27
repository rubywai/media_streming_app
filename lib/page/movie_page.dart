import 'package:flutter/material.dart';
import 'package:media_streming_app/data/movie_response.dart';
import 'package:media_streming_app/movie_provider/movie_provider.dart';
import 'package:media_streming_app/page/movie_players/mobile_mp4_player.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie App (Mobile + Android TV)"),
      ),
      body: Center(
        child: Consumer<MovieProvider>(
          builder: (context, provider, child) {
            if (provider.isSuccess) {
              List<MovieResponse> movies = provider.movieList;
              return _movieList(movies);
            } else if (provider.isFailed) {
              return _faileWidget();
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _movieList(List<MovieResponse> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, position) {
        MovieResponse movie = movies[position];
        return InkWell(
          onTap: () {
            if (movie.type == 'mp4') {
              String? link = movie.videoLink;
              Map<String, String>? resolutions = movie.resolutions?.toJson();
              String? title = movie.name;
              if (link != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MobileMp4Player(
                        link: link,
                        resolutions: resolutions ?? {},
                        title: title ?? "Video",
                      );
                    },
                  ),
                );
              }
            }
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  if (movie.thumbnail != null)
                    Image.network(
                      height: 200,
                      width: double.infinity,
                      movie.thumbnail!,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    movie.name ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _faileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Failed to Load"),
        SizedBox(
          height: 8,
        ),
        OutlinedButton(
          onPressed: () {
            Provider.of<MovieProvider>(context, listen: false).getMovies();
          },
          child: Text("Try Again"),
        ),
      ],
    );
  }
}
