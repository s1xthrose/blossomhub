import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalArticlePage extends StatelessWidget {
  const JournalArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(210, 59, 106, 1)),
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(44),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(24),
          right: ScreenUtil().setWidth(35),
          top: ScreenUtil().setHeight(16),
        ),
        child: ListView(
          children: [
            Container(
              child: Text(
                'The Big Bloom—How Flowering Plants Changed the World',
                style: GoogleFonts.nunito(
                  fontSize: ScreenUtil().setSp(24),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(35)),
              child: Text(
                '''In the summer of 1973 sunflowers appeared in my father's vegetable garden. They seemed to sprout overnight in a few rows he had lent that year to new neighbors from California. Only six years old at the time, I was at first put off by these garish plants. Such strange and vibrant flowers seemed out of place among the respectable beans, peppers, spinach, and other vegetables we had always grown. Gradually, however, the brilliance of the sunflowers won me over. Their fiery halos relieved the green monotone that by late summer ruled the garden. I marveled at birds that clung upside down to the shaggy, gold disks, wings fluttering, looting the seeds. Sunflowers defined flowers for me that summer and changed my view of the world. Flowers have a way of doing that. They began changing the way the world looked almost as soon as they appeared on Earth about 130 million years ago, during the Cretaceous period. That's relatively recent in geologic time: If all Earth's history were compressed into an hour, flowering plants would exist for only the last 90 seconds. But once they took firm root about 100 million years ago, they swiftly diversified in an explosion of varieties that established most of the flowering plant families of the modern world. Today flowering plant species outnumber by twenty to one those of ferns and cone-bearing trees, or conifers, which had thrived for 200 million years before the first bloom appeared. As a food source flowering plants provide us and the rest of the animal world with the nourishment that is fundamental to our existence. In the words of Walter Judd, a botanist at the University of Florida, "If it weren't for flowering plants, we humans wouldn't be here." From oaks and palms to wildflowers and water lilies, across the miles of cornfields and citrus orchards to my father's garden, flowering plants have come to rule the worlds of botany and agriculture. They also reign over an ethereal realm sought by artists, poets, and everyday people in search of inspiration, solace, or the simple pleasure of beholding a blossom. "Before flowering plants appeared," says Dale Russell, a paleontologist with North Carolina State University and the State Museum of Natural Sciences, "the world was like a Japanese garden: peaceful, somber, green; inhabited by fish, turtles, and dragonflies. After flowering plants, the world became like an English garden, full of bright color and variety, visited by butterflies and honeybees. Flowers of all shapes and colors bloomed among the greenery." That dramatic change represents one of the great moments in the history of life on the planet. What allowed flowering plants to dominate the world's flora so quickly? What was their great innovation? Botanists call flowering plants angiosperms, from the Greek words for "vessel" and "seed." Unlike conifers, which produce seeds in open cones, angiosperms enclose their seeds in fruit. Each fruit contains one or more carpels, hollow chambers that protect and nourish the seeds. Slice a tomato in half, for instance, and you'll find carpels. These structures are the defining trait of all angiosperms and one key to the success of this huge plant group, which numbers some 235,000 species. Just when and how did the first flowering plants emerge? Charles Darwin pondered that question, and paleobotanists are still searching for an answer. Throughout the 1990s discoveries of fossilized flowers in Asia, Australia, Europe, and North America offered important clues. At the same time the field of genetics brought a whole new set of tools to the search. As a result, modern paleobotany has undergone a boom not unlike the Cretaceous flower explosion itself. Now old-style fossil hunters with shovels and microscopes compare notes with molecular biologists using genetic sequencing to trace modern plant families backward to their origins. These two groups of researchers don't always arrive at the same birthplace, but both camps agree on why the quest is important.''',
                style: GoogleFonts.nunito(
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
