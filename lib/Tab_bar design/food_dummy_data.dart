import 'package:hive_food_delivery/model/category_model.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';

final categories = [
  CategoryModel(
    name: 'Appetizers',
    image: 'assets/category/appetizers.png.jpeg',
    items: [
      FoodItemModel(
        id: 'app_1',
        name: 'Sweet Potato',
        image: 'assets/category/potato wedges.jpeg',
        description: 'Crispy sweet potato wedges served with a tangy dip.',
        price: 12.99,
      ),
      FoodItemModel(
        id: 'app_2',
        name: 'Curly Fries',
        image: 'assets/category/crispy onion rings.jpeg',
        description: 'Golden curly fries seasoned to perfection.',
        price: 10.99,
      ),
      FoodItemModel(
        id: 'app_3',
        name: 'Breaded Shrimp With Chips',
        image: 'assets/category/doner kebab box.jpeg',
        description: 'Crispy shrimp served with chips.',
        price: 15.99,
      ),
      FoodItemModel(
        id: 'app_4',
        name: 'Crispy Onion Rings',
        image: 'assets/category/crispy onion rings.jpeg',
        description: 'Perfectly fried onion rings.',
        price: 8.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Daily Favourites',
    image: 'assets/category/beef-lasanisa.png.jpeg',
    items: [],
  ),

  CategoryModel(
    name: 'Burgers',
    image: 'assets/category/burger.png.jpeg',
    items: [
      FoodItemModel(
        id: 'bur_1',
        name: 'British Burger',
        image: 'assets/category/british burger.jpeg',
        description: 'Classic British style burger.',
        price: 150.00,
      ),
      FoodItemModel(
        id: 'bur_2',
        name: 'Mushroom Burger',
        image: 'assets/category/main mushroom burger.jpeg',
        description: 'Juicy burger topped with mushrooms.',
        price: 120.00,
      ),
      FoodItemModel(
        id: 'bur_3',
        name: 'Classic Burger',
        image: 'assets/category/burger.png.jpeg',
        description: 'All time favourite burger.',
        price: 99.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Salad',
    image: 'assets/category/salad.png.jpeg',
    items: [
      FoodItemModel(
        id: 'sal_1',
        name: 'Caesar Salad',
        image: 'assets/category/salad.png.jpeg',
        description: 'Fresh Caesar salad with dressing.',
        price: 120.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Crab Special',
    image: 'assets/category/crab.png.jpeg',
    items: [
      FoodItemModel(
        id: 'crab_1',
        name: 'Crab Omelette',
        image: 'assets/category/crab omlette.jpeg',
        description: 'Fluffy omelette with fresh crab.',
        price: 150.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Wrap',
    image: 'assets/category/wrap.png.jpeg',
    items: [
      FoodItemModel(
        id: 'wrap_1',
        name: 'Chicken Wrap',
        image: 'assets/category/wrap main.jpeg',
        description: 'Grilled chicken wrap.',
        price: 99.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Gusto D Italia',
    image: 'assets/category/mojito.png.jpeg',
    items: [
      FoodItemModel(
        id: 'drink_1',
        name: 'Peach Mojito',
        image: 'assets/category/peach mojito.jpeg',
        description: 'Refreshing peach mojito.',
        price: 120.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Mojito Special',
    image: 'assets/category/tea.png.jpeg',
    items: [
      FoodItemModel(
        id: 'drink_2',
        name: 'Mojito Drink',
        image: 'assets/category/tea.png.jpeg',
        description: 'All varieties of mojito.',
        price: 100.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Ice Tea Special',
    image: 'assets/category/tea.png.jpeg',
    items: [
      FoodItemModel(
        id: 'drink_3',
        name: 'Iced Tea',
        image: 'assets/category/peach mojito.jpeg',
        description: 'Chilled iced tea.',
        price: 100.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Espresso Drinks',
    image: 'assets/category/espresso.png.jpeg',
    items: [
      FoodItemModel(
        id: 'coffee_1',
        name: 'Espresso',
        image: 'assets/category/espresso.png.jpeg',
        description: 'Strong espresso shot.',
        price: 100.00,
      ),
    ],
  ),

  CategoryModel(
    name: 'Signature Drinks',
    image: 'assets/category/espresso.png.jpeg',
    items: [
      FoodItemModel(
        id: 'drink_4',
        name: 'Cool Drinks',
        image: 'assets/category/WhatsApp Image 2026-01-12 at 3.53.22 PM.jpeg',
        description: 'Refreshing cool drinks.',
        price: 100.00,
      ),
    ],
  ),
];
