import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/modules/homepage/model/movie_details.models.dart';
import 'package:movies_clicks/utils/is_path_empty.dart';

class MoviePriductionList extends StatelessWidget {
  const MoviePriductionList({super.key, required this.productionCompanies});
  final List<ProductionCompanies> productionCompanies;
  @override
  Widget build(BuildContext context) {
    final imageUrlBaseMobile = dotenv.get('TMDB_IMAGE_BASE_URL');

    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: productionCompanies
            .map((companies) => Container(
                  decoration: BoxDecoration(
                      color: ColorConstants().darkBackgroundColor,
                      borderRadius: BorderRadius.circular(5)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                          height: 80,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AllImages().postorLogoError,
                              height: 60,
                            );
                          },
                          width: 130,
                          imageUrl: imageUrlBaseMobile +
                              isPathEmpty(companies.logoPath)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(companies.name)
                    ],
                  ),
                ))
            .toList());
  }
}
