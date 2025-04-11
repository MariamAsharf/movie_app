import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';

class WatchlistContent extends StatelessWidget {
  const WatchlistContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return BlocConsumer<MoviesCubit, MoviesStates>(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //   },
    //   builder: (context, state) {
    //     final cubit = BlocProvider.of(context);
    //     return GridView.builder(
    //       scrollDirection: Axis.vertical,
    //       itemCount: 70,
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         mainAxisSpacing: 8,
    //         crossAxisSpacing: 16,
    //         childAspectRatio: 0.7,
    //       ),
    //       itemBuilder: (context, index) {
    //         //final movie = cubit.filteredMovies[index];
    //         return GestureDetector(
    //           onTap: () {
    //             // Navigator.pushNamed(
    //             //   context,
    //             //   MovieDetailsScreen.routeName,
    //             //   arguments: movie.id,
    //             // );
    //           },
    //           child: Stack(
    //             alignment: Alignment.topLeft,
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(16),
    //                 child: Image.network(
    //                   "..",
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 8,
    //                 left: 10,
    //                 child: Container(
    //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //                   decoration: BoxDecoration(
    //                     color: Colors.black.withOpacity(0.6),
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "movie.voteAverage",
    //                         style: Theme.of(context).textTheme.titleSmall,
    //                       ),
    //                       SizedBox(width: 4),
    //                       Icon(Icons.star,
    //                           color: Theme.of(context).primaryColor, size: 15),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
