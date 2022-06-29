import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// [CarouselAutoSlider] Widget mainly uses package from [CarouselSlider] to
/// perform the functionality of a Carousel. with the help of [CarouselController]
/// which does the animation control on the carousel and the user interaction

class CarouselAutoSlider extends StatefulWidget {
  const CarouselAutoSlider({Key? key}) : super(key: key);

  @override
  State<CarouselAutoSlider> createState() => _CarouselAutoSliderState();
}

class _CarouselAutoSliderState extends State<CarouselAutoSlider> {

  // the Future class allows the app to do stuff asynchronously potentially
  // multi-threading, a Future is completed in two ways either a value or an
  // error message
  Future openBrowserURL({
    required Uri url,
  }) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
    throw 'Could not launch $url';
  }

  // initialise current = 0, always show the first item in the list of carousel
  // whenever the page is route
  int _current = 0;

  //initialise carouselController to CarouselController factory method
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            // takes the full available space
            viewportFraction: 1,
            // when changes carousel option gives a Ease in animation effect
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            // onPageChanged checks whether a page is changed, onChange set
            // _current to index. The onPageChanged requires another arguments
            // "reason", "reason" arguments checks how the page was changed:
            // "timed" , "manually" or by "_carouselController"
            // in the case one of the arguments is not passed correctly the page
            // will not change its UI accordingly
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _carouselController,
          items: [
            //carousel item 1 (Benz Partnership)
            GestureDetector(
              onTap: () {
                const url =
                    'https://www.mercedes-benz.com.sg/?gclsrc=aw.ds&csref=mc-sem_cn-PSGC_OVS_SGP_RNG_CONS_AOP_NA_Brand-BrandOverall-Brand-Brand-CID-10005851648_ci-Google_si-g_pi-kwd-21946461_cri-434180763035_ai-mercedes+benz&kpid=go_cmp-10005851648_adg-99620184623_ad-434180763035_kwd-21946461_dev-c_ext-&gclid=CjwKCAjwquWVBhBrEiwAt1Kmwlc0-9GHwmdWM-aRIgCGiDHumnxAehTaH_B16x18CmQsCDvAf_Km_hoCrRAQAvD_BwE&gclsrc=aw.ds&group=all&subgroup=see-all&view=BODYTYPE';
                openBrowserURL(url: Uri.parse(url));
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: const DecorationImage(
                        image: AssetImage('images/BenzCarousel1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.black,
                      gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0),
                        ],
                        stops: const [0.0, 0.5],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'images/Mercedes_Benz-Logo-PNG6.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 10,
                    child: Text(
                      'Iconically Unique.',
                      style: GoogleFonts.ebGaramond(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Text(
                      'The new CLS.',
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 30,
                    child: Text(
                      'Learn More',
                      style: GoogleFonts.roboto(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 20,
                    right: 10,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            //Carousel item 2 Ralph Lauren
            GestureDetector(
              onTap: () {
                const url = 'https://www.ralphlauren.com/';
                openBrowserURL(url: Uri.parse(url));
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: const DecorationImage(
                        image: AssetImage('images/sheesh_bois.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.black,
                      gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0),
                        ],
                        stops: const [0.0, 0.5],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: Text(
                      'POLO',
                      style: GoogleFonts.playfairDisplaySc(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Text(
                      'RALPH LAUREN',
                      style: GoogleFonts.playfairDisplaySc(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      'Explore New Arrivals',
                      style: GoogleFonts.playfairDisplaySc(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 35,
                    indent: 20,
                    endIndent: 220,
                    thickness: 0.5,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Text(
                      'Explore Men\'s Polo',
                      style: GoogleFonts.playfairDisplaySc(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 35,
                    indent: 230,
                    endIndent: 20,
                    thickness: 0.5,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Carousel item 3
            GestureDetector(
              onTap: () {
                const url = 'https://www.mobil.com/en/sap/';
                openBrowserURL(url: Uri.parse(url));
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: const DecorationImage(
                        image: AssetImage('images/me-bean.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.black,
                      gradient: LinearGradient(
                        begin: FractionalOffset.centerRight,
                        end: FractionalOffset.centerLeft,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0),
                        ],
                        stops: const [
                          0.0,
                          0.5,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Text(
                      'Get more',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 35,
                    top: 45,
                    child: Text(
                      'for less',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 20,
                    child: Container(
                      width: 70,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: -20,
                    child: Image.asset(
                      'images/Mobile_SuperTM.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _carouselController.animateToPage(0),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == 0 ? 0.9 : 0.4),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _carouselController.animateToPage(1),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == 1 ? 0.9 : 0.4),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _carouselController.animateToPage(2),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == 2 ? 0.9 : 0.4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
