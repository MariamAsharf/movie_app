import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';

class BottomSheetAvatar extends StatefulWidget {
  const BottomSheetAvatar({super.key});

  @override
  State<BottomSheetAvatar> createState() => _BottomSheetAvatarState();
}

class _BottomSheetAvatarState extends State<BottomSheetAvatar> {
  int? loadingAvatarId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MoviesCubit>(context);
    int selectedAvatarId = cubit.selectedAvaterId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        height: 389,
        child: GridView.builder(
          itemCount: 40,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  loadingAvatarId = index + 1;
                });

                await cubit.updateAvatarId(index + 1);

                if (mounted) {
                  setState(() {
                    loadingAvatarId = null;
                  });
                  await cubit.getUserData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Avatar updated successfully!"),
                      duration: Duration(seconds: 2),
                    ),

                  );
                  Navigator.pop(context,true);
                }
              },
              child: BlocBuilder<MoviesCubit, MoviesStates>(
                builder: (context, state) {
                  bool isSelected = selectedAvatarId == index + 1;
                  bool isLoading = loadingAvatarId == index + 1;

                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AvatarPlus(
                            "${index + 1}",
                            height: 100,
                            width: 94,
                          ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
