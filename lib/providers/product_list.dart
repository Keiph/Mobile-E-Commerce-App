import 'package:boogle_mobile/models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  /// Creates a list of [Product] with 10 hardcoded object as [myProductList]
  static List<Product> myProductList = [
    //Object 1
    Product(
      productName: 'Bondi X',
      productImg:
          'https://www.hoka.com/dw/image/v2/BDJD_PRD/on/demandware.static/-/Sites-HOKA-US-master/default/dwf47c4637/images/transparent/1113512-BWHT_1.jpg?sw=483&sh=447&sm=fit&sfrm=png&bgcolor=f7f7f9',
      productDetails:
          //String literals written in an effective dart way, preferring adjacent string concatenation
          'A maximally-cushioned road shoe designed to go the distance, the Bondi X is spring-loaded with a propulsive carbon fiber plate. The original Bondi cushioning and lines are here, providing the soft, balanced ride for which the franchise is known. The Bondi X fine-tunes the geometry with an extended rocker for greater acceleration, while the carbon fiber plate is designed to provide an efficient transition and smooth toe-off.'
          '\n• Mesh upper with 3D hotmelt yarns'
          '\n• Carbon fiber plate'
          '\n• Compression-molded foam'
          '\n• Early stage Meta-Rocker'
          '\n• Light zonal rubber',
      productCategory: 'Shoes',
      productColors: Colors.black,
      productPrice: 215.00,
      productSizes: '11.5 US ',
      productRating: 3.8,
      productCount: 1,
    ),

    //Object 2
    Product(
      productName: 'MEN Oxford Slim Fit Long Sleeve Shirt',
      productImg:
          'https://image.uniqlo.com/UQ/ST3/sg/imagesgoods/452299/item/sggoods_01_452299.jpg?width=1600&impolicy=quality_75',
      productDetails: '- Fabric made from triple-twisted combed yarn.'
          '\n- Finely woven premium fabric with a crisp, supple texture.'
          '\n- Relaxed, regular fit based on a classic Oxford shirt design.'
          '\n- The collar, sleeves, hem line, cuff width, placket width, yoke height, and stitching are all carefully designed to complement the relaxed cut.'
          '\n- Traditional gusseted hems and hanger loop detail.'
          '\n- The sewing process from the sides to the sleeves features flat felled seams and lockstitch machine stitching, as used for high-end shirt tailoring.'
          '\n- Subtly glossy premium resin buttons with a shape and thickness carefully designed to be comfortable to the fingertips and easy to fasten.'
          '\n- Suitable for casual or dressy styles.'
          '\n- This versatile shirt easily tucks in, sizes up for an oversized look, styles as a light outer layer with the buttons undone, or layers under a jacket or sweater.',
      productCategory: 'Clothes',
      productColors: Colors.white,
      productPrice: 39.90,
      productSizes: 'L',
      productRating: 4.8,
      productCount: 1,
    ),

    //Object 3
    Product(
      productName: "Lay's Classic Potato Chips",
      productImg:
          'https://cdn.shopify.com/s/files/1/0278/4778/6636/products/51ZuFfD6JWL_1024x1024.jpg?v=1594845036',
      productDetails:
          'Pack of 64, 1.5 ounce large single serving bags (total of 96 ounces) Made with 100 percent pure sunflower oil0 grams of trans fat',
      productCategory: 'Grocery',
      productColors: Colors.yellow,
      productPrice: 399.00,
      productSizes: '64 Packs of 1.5 Ounces',
      productRating: 1.5,
      productCount: 1,
    ),

    //Object 4
    Product(
      productName: 'Ragdoll Cat',
      productImg:
          'https://static.wixstatic.com/media/5bc363_45186a4c0db54aa6a89c348a88b775ec~mv2.jpg/v1/crop/x_0,y_290,w_1434,h_736/fill/w_1225,h_629,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/rag.jpg',
      productDetails:
          'The Ragdoll cat is the best cat companion for those living in apartments. Known for their docile and charming disposition, Ragdoll cats love cuddling and will greet their humans at the door when they return home. This breed is highly intelligent and can pick up new tricks like fetch, as well as learn positive behaviours such as utilising scratch posts. They also have sociable personalities and will swiftly adapt well to changes in their living environment. Ragdoll cats are the best companions for those looking for easy-going, versatile, and affectionate cats. ',
      productCategory: 'Miscellaneous',
      productColors: Colors.brown,
      productPrice: 652.99,
      productSizes: '10 pounds',
      productRating: 3.9,
      productCount: 1,
    ),

    //Object 5
    Product(
      productName: 'Nintendo Switch - Gray + Gray Joy-Con',
      productImg:
          'https://assets.nintendo.com/image/upload/ar_16:9,b_auto:border,c_lpad/b_white/bo_15px_solid_white/f_auto/q_auto/dpr_auto/c_scale,w_1000/ncom/en_US/products/hardware/nintendo-switch-gray/110477-nintendo-switch-gray-gray-package-front-1200x675',
      productDetails:
          'At home, Nintendo Switch™ rests in the Nintendo Switch Dock that connects the system to the TV and lets you play with family and friends in the comfort of your living room. By simply lifting Nintendo Switch from the dock, the system will instantly transition to portable mode, and the same great gaming experience that was being enjoyed at home now travels with you. The portability of Nintendo Switch is enhanced by its bright high-definition display. It brings the full home gaming system experience with you to the park, on an airplane, in a car, or to a friend’s apartment.This bundle includes the Nintendo Switch console and Nintendo Switch dock in black, and left and right Joy‑Con™ controllers in a contrasting gray. It also includes all the extras you need to get started.'
          '\nIncludes:'
          '\n• Nintendo Switch Console'
          '\n• Nintendo Switch Dock'
          '\n• Joy-Con (L) Gray'
          '\n• Joy-Con (R) Gray'
          '\n• Joy-Con Wrist Straps'
          '\n• Joy-Con Grip'
          '\n• High Speed HDMI Cable'
          '\n• Nintendo Switch AC Adapter',
      productCategory: 'Computer & Games',
      productColors: Colors.grey,
      productPrice: 299.00,
      productSizes: 'Battery Life 4.5 - 9 hours',
      productRating: 4.95,
      productCount: 1,
    ),

    //Object 6
    Product(
      productName: 'The Pokémon Legends: Arceus',
      productImg:
          'https://m.media-amazon.com/images/I/71HYKF4rO9L._AC_SY679_.jpg',
      productDetails:
          'Get ready for a new kind of grand, Pokémon adventure in Pokémon Legends: Arceus, a brand new game from Game Freak that blends action and exploration with the RPG roots of the Pokémon series. Explore natural expanses to catch Pokémon by learning their behavior, sneaking up, and throwing a well-aimed Poké Ball. You can also toss the Poké Ball containing your ally Pokémon near a wild Pokémon to seamlessly enter the battle. This new angle on Pokémon gameplay will deliver an immersive, personal experience brought to life by both Pokémon and humans.',
      productCategory: 'Computer & Games',
      productColors: Colors.grey,
      productPrice: 66.00,
      productSizes: '1x Pokémon™ Legends: Arceus',
      productRating: 5.0,
      productCount: 1,
    ),

    //Object 7
    Product(
      productName: 'Nizza Platform Shoes',
      productImg:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/15831bb185a64ba0b19bae84002f5f00_9366/Nizza_Platform_Shoes_White_GX4605_01_standard.jpg',
      productDetails: '• Lace closure'
          '\n• Textile upper'
          '\n• Textile lining'
          '\n• Rubber platform outsole'
          '\n• Yarn in upper contains at least 50% Parley Ocean Plastic and 50% recycled polyester'
          '\n• Color: Cream White / Almost Lime / Wonder White'
          '\n• Product code: GX4605',
      productCategory: 'Shoes',
      productColors: Colors.white,
      productPrice: 95.00,
      productSizes: 'UK 7.5',
      productRating: 3.2,
      productCount: 1,
    ),

    //Object 8
    Product(
      productName:
          'WOPET Automatic Pet Feeder Food Dispenser for Cats and Dogs–Features',
      productImg:
          'https://m.media-amazon.com/images/I/61CyDOmZkNS._AC_SX522_.jpg',
      productDetails:
          'FEED YOUR PET WHILE YOU’RE AWAY - Schedule up to 4 automated feedings per day using the built-in programmable timer. Program each meal time with a few button clicks on an easy to use LCD screen. Control food portions from 2 teaspoons to 4.5 cups per feeding. NEVER MISS A FEEDING. The WOpet feeder is wall powered and/or battery powered. In case of a power outage, the feeder will continue to function on 3 D-size batteries to assure your pet gets fed (batteries not included).CONTROL PORTION SIZE OF EACH FEEDING - Dispense anywhere from 2 teaspoons to 4.5 cups dry food per feeding to sustain any size animal. You can program a unique portion size for each automatic feeding, allowing you to ESTABLISH REGULAR EATING ROUTINES throughout the day without any stress.RECORD A CUSTOM MESSAGE FOR YOUR PET - Keep your pet excited about meal times! Press and hold the mic button for three seconds to begin recording a message to be played as each feeding dispenses. (e.g. Here, Fido! Come and eat, boy! Good doggy.)OPERATING TIPS - Suitable for dry food only, with the food pellet size ranging from 0.2-0.6 inches in diameter; up to 4 meals a day. The removable hygienic feeding tray is dishwasher safe and easy to clean. LARGE STORAGE COMPARTMENT - The main food storage compartment can hold up to 20 CUPS of food and is removable for easy cleaning and refilling.CUSTOMER SERVICE - Customizable Feeder Great for Dogs, Cats and Small Animals of Various Sizes.Provide a interesting living for your pet with our WOPET pet feeder!24-hour professional service center and 365 day technical support.',
      productCategory: 'Pet Supplies',
      productColors: Colors.white,
      productPrice: 181.05,
      productSizes: '6 pounds',
      productRating: 4.905,
      productCount: 1,
    ),

    //Object 9
    Product(
      productName: 'Vesper Cat Tree, High Base, Walnut, 52045',
      productImg:
          'https://m.media-amazon.com/images/I/71PXQRLWGCL._AC_SX522_.jpg',
      productDetails:
          '• Elegant yet practical line of cat furniture that satisfies the daily activity needs of fussy felines'
          '\n• Cat tower has a cube with multiple exits for your cat to relax (or play) in'
          '\n• Soft memory foam cat bed cushions'
          '\n• Has cat scratching posts for your kitty to scratch'
          '\n• Base: 22.1 x 22.1 inches; Height 47.9 inches',
      productCategory: 'Pet Supplies',
      productColors: Colors.brown,
      productPrice: 303.39,
      productSizes: '	18.37 Kilograms',
      productRating: 4.901,
      productCount: 1,
    ),

    //Object 10
    Product(
      productName: "Chu Qian Yi Ding Chicken Instant Noodle 5'SX82G",
      productImg:
          'https://images-na.ssl-images-amazon.com/images/I/91CGsHGFhWL.__AC_SY300_SX300_QL70_ML2_.jpg',
      productDetails:
          '• Ingredients Noodles Wheat flour (contains iron, zinc, vitamins [B2, B1, folic acid]) (78 percent), palm oil (antioxidants [307b, 320, 321]), salt, acidity regulators (450, 451, 501, 500), stabilisers (412, 414), colour (160a), emulsifier (1450).'
          '\n• Ingredients Seasoning Powder: Salt, flavour enhancers (621, 635), flavouring powder (imitation chicken powder, yeast extract, onion, potato, soya sauce powder [soya, wheat], creamer [glucose, palm fat, sodium caseinate], anticaking agent [551]), sugar, hydrolysed plant protein (soya, stabiliser [1400]), spices (garlic, pepper, ginger, turmeric), cabbage, spring onion.'
          '\n• Seasoning Oil Sesame oil, palm oil, spices (ginger, chilli, garlic, paprika oleoresin).'
          '\n• This product contains wheat, soya, milk, sesame.'
          '\n• allergen information: gluten'
          '\n• specialty: Halal',
      productCategory: 'Grocery',
      productColors: Colors.green,
      productPrice: 3.27,
      productSizes: '112 Grams',
      productRating: 2.1,
      productCount: 1,
    ),
  ];

  /// return the list of [Product] of [myProductList]
  List<Product> getAllProductList() {
    return myProductList;
  }

  /// return the list of [Product] of _temp list after sorting the list according to [Product.productRating]
  List<Product> getPopularProduct() {
    List<Product> _temp = List.from(myProductList);
    _temp.sort((a, b) => b.productRating.compareTo(a.productRating));

    return _temp;
  }

  List<Product> getSearch() {
    List<Product> _temp = List.from(myProductList);
    _temp.sort((a, b) => b.productCount.compareTo(a.productCount));
    return _temp;
  }

  /// add the a new Object to [myProductList]
  void addProduct(
    productName,
    productImg,
    productDetails,
    productColors,
    productCategory,
    productPrice,
    productSizes,
    productRating,
    productCount,
  ) {
    myProductList.insert(
      0,
      Product(
        productName: productName,
        productImg: productImg,
        productDetails: productDetails,
        productCategory: productCategory,
        productColors: productColors,
        productPrice: productPrice,
        productSizes: productSizes,
        productRating: productRating,
        productCount: productCount,
      ),
    );
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }

  /// remove an existing Object based on the params passed to the constructor
  void deleteProduct(selectedProduct) {
    // in this case we took selectedProduct as Product from Product Screen and remove the object as a whole
    myProductList.remove(selectedProduct);
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }
}
