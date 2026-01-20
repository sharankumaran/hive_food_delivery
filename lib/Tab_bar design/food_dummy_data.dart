import 'package:hive_food_delivery/model/category_model.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';

final List<CategoryModel> categories = [
  /// ================= APPETIZERS =================
  CategoryModel(
    id: 'cat_appetizers',
    name: 'APPETIZERS',
    image: 'assets/category/appetizers.png.jpeg',
    order: 1,
    items: [
      FoodItemModel(
        id: 'app_01',
        name: '6 PCS Crispy Breaded Mozzarella Sticks',
        image: 'assets/category/potato wedges.jpeg',
        description: 'Crispy breaded mozzarella cheese sticks',
        price: 1.400,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'app_02',
        name: '6 PCS Boneless Chicken Wings',
        image: 'assets/category/british burger.jpeg',
        description: 'With sweet chilli dip',
        price: 1.800,
        isVeg: false,
      ),
    ],
  ),

  /// ================= DAILY FAVORITES =================
  CategoryModel(
    id: 'cat_daily_fav',
    name: 'DAILY FAVORITES',
    image: 'assets/category/crab omlette.jpeg',
    order: 2,
    items: [
      FoodItemModel(
        id: 'df_14',
        name: 'Cod Fillet Fish & Chips',
        image: 'assets/category/cheddad cheese.jpeg',
        description: 'British traditional battered fish',
        price: 4.800,
        isVeg: false,
        isBestseller: true,
      ),

      FoodItemModel(
        id: 'df_16',
        name: 'Hammour Fillet Fish & Chips',
        image: 'assets/category/burger.png.jpeg',
        description: 'Fresh local Hammour',
        price: 4.500,
        isVeg: false,
      ),
    ],
  ),

  /// ================= BURGERS =================
  CategoryModel(
    id: 'cat_burgers',
    name: "BURGER'S",
    image: 'assets/category/burger.png.jpeg',
    order: 3,
    items: [
      FoodItemModel(
        id: 'bur_21',
        name: 'British Classic Burger',
        image: 'assets/category/burger.jpeg',
        description: '150gm Beef, English Cheddar, Fries & Coleslaw',
        price: 2.500,
        isVeg: false,
        isBestseller: true,
      ),
      FoodItemModel(
        id: 'bur_22',
        name: 'Ruck and Maul',
        image: 'assets/category/burger.jpeg',
        description: 'Caramelized onion, jalapeno & melted Cheddar',
        price: 2.800,
        isVeg: false,
        spiceLevel: 2,
      ),
    ],
  ),

  /// ================= DONER SPECIAL =================
  CategoryModel(
    id: 'cat_doner',
    name: 'DONER SPECIAL',
    image: 'assets/category/peach mojito.jpeg',
    order: 4,
    items: [
      FoodItemModel(
        id: 'doner_35',
        name: 'Doner Burger',
        image: 'assets/category/peri peri chicken.jpeg',
        description: 'Doner, Lettuce, Pickle, Onion with Fries',
        price: 2.400,
        isVeg: false,
      ),
    ],
  ),

  /// ================= SALAD =================
  CategoryModel(
    id: 'cat_salad',
    name: 'SALAD',
    image: 'assets/category/thumbnail salad.jpeg',
    order: 5,
    items: [
      FoodItemModel(
        id: 'sal_44',
        name: 'Grilled Salmon & Avocado',
        image: 'assets/category/WhatsApp Image 2026-01-12 at 3.53.24 PM.jpeg',
        description: 'On bed of rocket leaves',
        price: 3.800,
        isVeg: false,
      ),
    ],
  ),

  /// ================= CRAB SPECIAL =================
  CategoryModel(
    id: 'cat_crab',
    name: 'CRAB SPECIAL',
    image: 'assets/category/crab.png.jpeg',
    order: 6,
    items: [
      FoodItemModel(
        id: 'crab_48',
        name: 'Savory Crab Claw Bite',
        image: 'assets/category/salad.png.jpeg',
        description: 'Crispy crab bites',
        price: 2.800,
        isVeg: false,
      ),
    ],
  ),

  /// ================= WRAP =================
  CategoryModel(
    id: 'cat_wrap',
    name: 'WRAP',
    image: 'assets/category/wrap main.jpeg',
    order: 7,
    items: [
      FoodItemModel(
        id: 'wrap_54',
        name: 'Falafel & Halloumi Wrap',
        image:
            'assets/food images/ada00ee6-6a81-4637-86dd-a8d0d7fbe9de-removebg-preview.png',
        description: 'Herby falafel & grilled halloumi',
        price: 2.500,
        isVeg: true,
      ),
    ],
  ),

  /// ================= KIDS MEAL =================
  CategoryModel(
    id: 'cat_kids',
    name: 'KIDS MEAL',
    image: 'assets/food images/bc9fd4bd-de9b-4555-976c-8360576c6708.jpg',
    order: 8,
    items: [
      FoodItemModel(
        id: 'kids_58',
        name: 'Fish Finger Rolls',
        image: 'assets/category/wrap.png.jpeg',
        description: 'Served w/ Fries & Juice',
        price: 1.600,
        isVeg: false,
      ),
      FoodItemModel(
        id: 'kids_59',
        name: 'Breaded Chicken Nuggets',
        image: 'assets/category/wrap main.jpeg',
        description: 'Served w/ Fries & Juice',
        price: 1.600,
        isVeg: false,
      ),
    ],
  ),

  /// ================= GUSTO D ITALIA =================
  CategoryModel(
    id: 'cat_pasta',
    name: "GUSTO D'ITALIA",
    image: 'assets/category/thumbnail mushroom.jpeg',
    order: 9,
    items: [
      FoodItemModel(
        id: 'pas_63',
        name: 'Fettuccine Alfredo',
        image: 'assets/category/thumbnail mojito.jpeg',
        description: 'With breaded chicken strips & Garlic Bread',
        price: 3.500,
        isVeg: false,
      ),
    ],
  ),

  /// ================= MOJITO SPECIAL =================
  CategoryModel(
    id: 'cat_mojito',
    name: 'MOJITO SPEACIAL',
    image: 'assets/category/main mushroom burger.jpeg',
    order: 10,
    items: [
      FoodItemModel(
        id: 'moj_68',
        name: 'Strawberry Mojito',
        image: 'assets/menu/mj68.jpeg',
        description: 'Fresh strawberry and mint',
        price: 1.300,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'moj_70',
        name: 'Classic Mojito',
        image: 'assets/category/salad main.jpeg',
        description: 'Refreshing lime and mint',
        price: 1.300,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'moj_73',
        name: 'Red Bull Mojito',
        image: 'assets/category/burger.jpeg',
        description: 'Energy boosted refresher',
        price: 1.800,
        isVeg: true,
      ),
    ],
  ),

  /// ================= ICE TEA SPECIAL =================
  CategoryModel(
    id: 'cat_icetea',
    name: 'ICE TEA SPECIAL',
    image: 'assets/category/main wrap.jpeg',
    order: 11,
    items: [
      FoodItemModel(
        id: 'it_75',
        name: 'Passion Fruit Iced Tea',
        image: 'assets/category/peri peri chicken.jpeg',
        description: 'Tropical iced tea',
        price: 1.300,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'it_77',
        name: 'Peach Iced Tea',
        image: 'assets/category/cheddad cheese.jpeg',
        description: 'Classic peach flavor',
        price: 1.300,
        isVeg: true,
      ),
    ],
  ),

  /// ================= SOFT DRINKS =================
  CategoryModel(
    id: 'cat_soft',
    name: 'SOFT DRIKS',
    image: 'assets/category/crab omlette.jpeg',
    order: 12,
    items: [
      FoodItemModel(
        id: 'sd_79',
        name: 'Coca Cola',
        image: 'assets/category/crispy onion rings.jpeg',
        description: '330ml Can',
        price: 0.500,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'sd_80',
        name: 'Arwa Water',
        image:
            'assets/food images/d84c34d5-b2c0-4b31-bf08-b3d734cba64e-removebg-preview.png',
        description: 'Mineral Water',
        price: 0.200,
        isVeg: true,
      ),
    ],
  ),

  /// ================= ESPRESSO-BASED DRINKS =================
  CategoryModel(
    id: 'cat_espresso',
    name: 'ESPRESSO-BASED DRINKS',
    image: 'assets/category/espresso.png.jpeg',
    order: 13,
    items: [
      FoodItemModel(
        id: 'cof_81',
        name: 'Espresso',
        image:
            'assets/food images/ada00ee6-6a81-4637-86dd-a8d0d7fbe9de-removebg-preview.png',
        description: 'Single Shot',
        price: 0.800,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'cof_84',
        name: 'Americano',
        image:
            'assets/food images/vecteezy_ai-generated-rice-with-chicken-and-vegetables-plate-of_35983431.png',
        description: 'Hot or Iced',
        price: 1.000,
        isVeg: true,
        variants: ['Hot', 'Iced'],
      ),
      FoodItemModel(
        id: 'cof_87',
        name: 'Cappuccino',
        image: 'assets/food images/pexels-shantanu-pal-938952-2679501.jpg',
        description: 'Espresso with foam',
        price: 1.600,
        isVeg: true,
      ),
    ],
  ),

  /// ================= SPECIALTY & SIGNATURE =================
  CategoryModel(
    id: 'cat_specialty',
    name: 'SPECIALTY & SIGNATURE DRINKS',
    image: 'assets/category/doner kebab box.jpeg',
    order: 14,
    items: [
      FoodItemModel(
        id: 'sig_98',
        name: 'Mocha Crumble',
        image: 'assets/food images/pexels-chanwalrus-958545.jpg',
        description: 'Chocolatey coffee blend',
        price: 2.000,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'sig_99',
        name: 'BH Signature Drink',
        image: 'assets/food images/header-image.png.jpeg',
        description: 'Hot or Iced',
        price: 2.000,
        isVeg: true,
        variants: ['Hot', 'Iced'],
      ),
    ],
  ),

  /// ================= FRAPPES & COLD BLENDS =================
  CategoryModel(
    id: 'cat_frappe',
    name: 'FRAPPES & COLD BLENDS',
    image: 'assets/category/all-food.png.jpeg',
    order: 15,
    items: [
      FoodItemModel(
        id: 'fr_102',
        name: 'Caramel Frappe',
        image: 'assets/category/appetizers.png.jpeg',
        description: 'Blended caramel coffee',
        price: 2.000,
        isVeg: true,
      ),
      FoodItemModel(
        id: 'fr_103',
        name: 'Matcha Frappe',
        image: 'assets/category/beef-lasanisa.png.jpeg',
        description: 'Blended green tea',
        price: 2.200,
        isVeg: true,
      ),
    ],
  ),
];
