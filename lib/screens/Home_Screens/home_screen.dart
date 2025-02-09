import 'package:flutter/material.dart';
//import 'package:movie_app/movie_detail_screen.dart';
import '../../api_manager.dart';
//import 'api_manager.dart';
//import 'model/source_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/model/source_response.dart'; // تأكد من استيراد الكلاس
//import 'model/source_response.dart';
import 'movie_details/movie_details.dart';



class HomeScreen extends StatelessWidget {
  static const String routeName="homescreen";
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        var data = snapshot.data?.results;

        if (data == null || data.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // الصورة الأولى في الأعلى
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/available.png",
                      width: 220,
                      height: 80,
                    ),
                  ),

                  // CarouselSlider للـ posters
                  Container(
                    height: 300,
                    child: CarouselSlider(
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
                        onPageChanged: (index, reason) {
                          // هنا يمكنك إضافة وظيفة callback إذا أردت.
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      items: data.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Stack(
                                children: [
                                  // صورة الـ poster
                                  item.posterPath != null
                                      ? GestureDetector(
                                    onTap: () {
                                      print("Navigating to MovieDetailScreen with movieId: ${item.id}");
                                      // عند الضغط على الصورة
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetailScreen(movieId: item.id!), // هنا يتم استخدام item.id
                                        ),
                                      );

                                    },
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${item.posterPath}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 450,
                                    ),
                                  )
                                      : Container(),

                                  // تقييم النجوم (rate) في الأعلى بدون خلفية صفراء
                                  Positioned(
                                    top: 8, // جعلناها في أعلى الصورة
                                    left: 10,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white, // تغيير اللون للأبيض
                                          size: 12, // تصغير الحجم
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          item.voteAverage?.toStringAsFixed(1) ?? '0.0',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10, // تصغير الحجم
                                          ),
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
                    ),
                  ),

                  // الصورة الثانية
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/watch.png",
                      width: 354,
                      height: 146,
                    ),
                  ),

                  // قسم العناوين
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Action",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "see more",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFF6BD00),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // قائمة ثانية للأفلام
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return Container(
                          width: 150,
                          color: Colors.transparent,
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Column(
                                children: [
                                  // عرض صورة الـ poster
                                  item.posterPath != null
                                      ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${item.posterPath}',
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(),

                                  // يمكنك إضافة عنوان الفيلم أو تفاصيل أخرى هنا حسب الحاجة
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // شريط التنقل السفلي
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BottomNavigationBar(
                backgroundColor: Color(0xFF282A28),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFFF6BD00),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFFF6BD00),
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.location_city,
                      color: Color(0xFFF6BD00),
                    ),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.label,
                      color: Color(0xFFF6BD00),
                    ),
                    label: 'Library',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
