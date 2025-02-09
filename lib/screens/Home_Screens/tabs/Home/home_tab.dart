import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
import 'package:movie_app/authentication/auth_states.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/available.png",
                  width: 220,
                  height: 80,
                ),
              ),
              Container(
                height: 300,
                child: state is ApiLoadingStates
                    ? Center(child: CircularProgressIndicator())
                    : state is ApiSuccessStates
                    ? CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: state.data.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(movieId: item.id!),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500${item.posterPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 450,
                              ),
                              Positioned(
                                top: 8,
                                left: 10,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      item.voteAverage?.toStringAsFixed(1) ?? '0.0',
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
                    : Center(child: Text("Failed to load data")),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/watch.png",
                  width: 354,
                  height: 146,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Action",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Spacer(),
                    Text(
                      "see more",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: state is ApiSuccessStates
                    ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    var item = state.data[index];
                    return Container(
                      width: 150,
                      color: Colors.transparent,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${item.posterPath}',
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : Center(child: Text("No data available")),
              ),
            ],
          ),
        );
      },
    );
  }
}
