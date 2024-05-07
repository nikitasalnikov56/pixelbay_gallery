import 'package:flutter/material.dart';
import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter_application_1/domain/api/pixabay_service.dart';
import 'package:flutter_application_1/domain/getit/app_getit.dart';
import 'package:flutter_application_1/domain/model/photos.dart';
import 'package:flutter_application_1/domain/searching_model/searching_model.dart';
import 'package:flutter_application_1/ui/row_items.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pixabay'),
        ),
        body: ChangeNotifierProvider(
            create: (context) =>
                SearchingModel(AppGetIt.getIt<PixabayService>()),
            child: const AppBody()),
      ),
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 150).floor();
    final pixabayService = AppGetIt.getIt<PixabayService>();

    final searchModel = context.watch<SearchingModel>();
    return FutureBuilder<Photos>(
      future: pixabayService.searchPhotos(searchModel.searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final photos = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: searchModel.searchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    searchModel.onSearch();
                  },
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (context, i) {
                    final photo = photos.hits![i];
                    return SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: ImageCachedFullscreen(
                              imageWidth: double.infinity,
                              hideBackButtonDetails: true,
                              hideAppBarDetails: true,
                              imageFit: BoxFit.cover,
                              imageUrl: '${photo.webformatURL}',
                              withHeroAnimation: true,
                              placeholder: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholderDetails: const SizedBox(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RowItems(
                                icon: Icons.favorite_border,
                                text: '${photo.likes}',
                                color: Colors.red,
                              ),
                              RowItems(
                                icon: Icons.visibility,
                                text: '${photo.views}',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: photos.hits?.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void _performSearch(String query) {
  //   Debouncer().debounce(
  //       duration: const Duration(milliseconds: 300),
  //       onDebounce: () {
  //         pixabayService.searchPhotos(query);
  //       });
  // }
}
