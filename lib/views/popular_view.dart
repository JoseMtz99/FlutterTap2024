import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tap2024/models/popular_model.dart';

class PopularView extends StatelessWidget {
  PopularView({super.key,this.popularModel});

  PopularModel? popularModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              imageUrl: 'https://image.tmdb.org/t/p/w500/${popularModel!.backdropPath}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.network('https://www.nacionflix.com/__export/1608412979690/sites/debate/img/2020/12/19/el_top_10_de_pelxculas_mxs_populares_en_netflix_1.jpg_242310155.jpg'),
            ),
            Container(
              color: Colors.black54,
              height: 60,
              child: ListTile(
                leading:const Icon(Icons.movie),
                title: Text(popularModel!.title, style: const TextStyle(color: Colors.white),),
                subtitle: Text(popularModel!.releaseDate, style: const TextStyle(color: Colors.white),maxLines: 1,),
                trailing: IconButton(
                  icon:  Icon(Icons.chevron_right), 
                  color: Colors.white,
                  onPressed: () => Navigator.pushNamed(context, '/movieDetail', arguments: popularModel),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}