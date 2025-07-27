import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webcastle_mt/provider/perfume_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<PerfumeProvider>(context, listen: false).getPerfumeModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome, ",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                      ),
                      Text(
                        " James!",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      decoration: InputDecoration(
                        hint: Text(
                          "Search..",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black26,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            strokeAlign: .2,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0.0),
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Scan Here",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              Icon(Icons.read_more, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [],
      ),
      body: ListView.builder(
        itemCount:
            Provider.of<PerfumeProvider>(
              context,
              listen: true,
            ).perfumeModel?.data.homeFields.length ??
            0,
        itemBuilder: (context, index) {
          Map<String, dynamic> item =
              Provider.of<PerfumeProvider>(
                context,
                listen: false,
              ).perfumeModel?.data.homeFields[index] ??
              {};
          switch (item['type']) {
            case 'category':
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Our Categories",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 40,
                      children:
                          item['categories']
                              ?.map<Widget>(
                                (e) => Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: e['image'] ?? '',
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      e['name'] ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(fontSize: 10),
                                    ),
                                  ],
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
                ],
              );
            case 'brands':
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Shop by Brands",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          item['brands']
                              ?.map<Widget>(
                                (e) => Card(
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: CachedNetworkImage(
                                      imageUrl: e['image'] ?? '',
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.2,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
                ],
              );
            case 'carousel':
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: CarouselView(
                  itemSnapping: true,
                  backgroundColor: Colors.white,
                  scrollDirection: Axis.horizontal,
                  itemExtent: MediaQuery.of(context).size.width,
                  children:
                      item['carousel_items']
                          ?.map<Widget>(
                            (e) => CachedNetworkImage(
                              imageUrl: e['image'] ?? '',
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              );
            case 'banner':
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: item['banner']['image'] ?? '',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            case 'future-order':
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: item['image'] ?? '',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            case 'rfq':
              return Card(
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: item['image'] ?? '',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            case 'banner-grid':
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children:
                    item['banners']
                        ?.map<Widget>(
                          (e) => Card(
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: e['image'] ?? '',
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              );

            case 'collection':
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['name'] ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.5,
                    children:
                        item['products']
                            ?.map<Widget>(
                              (e) => Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.1,
                                            child: CachedNetworkImage(
                                              imageUrl: e['image'] ?? '',
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
                                              child: Text(
                                                e['name'] ?? '',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                3.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    e['currency'] ?? '',
                                                    style: GoogleFonts.poppins(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black45,
                                                    ),
                                                  ),

                                                  Text(
                                                    e['actual_price'] ?? '',
                                                    style: GoogleFonts.poppins(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                3.0,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    e['currency'] ?? '',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),

                                                  Text(
                                                    e['price'] ?? '',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    " per Dozen",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  padding:
                                                      WidgetStatePropertyAll(
                                                        EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                        ),
                                                      ),
                                                  elevation:
                                                      WidgetStatePropertyAll(
                                                        .4,
                                                      ),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                        Colors.white,
                                                      ),
                                                ),
                                                child: Text(
                                                  "RFQ",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  padding:
                                                      WidgetStatePropertyAll(
                                                        EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                        ),
                                                      ),
                                                  elevation:
                                                      WidgetStatePropertyAll(
                                                        0.0,
                                                      ),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                        Colors.red,
                                                      ),
                                                ),
                                                child: Text(
                                                  "Add to Cart",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            color: Colors.black12,
                                          ),
                                          height: 20,
                                          margin: EdgeInsets.only(top: 8),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          child: Text(
                                            e['offer'] ?? '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite_outline_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
