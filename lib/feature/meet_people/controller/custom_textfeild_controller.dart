import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';

import '../../../core/helper/shared_prefarences_helper.dart';

class CustomTextFieldSearchController extends GetxController {
  TextEditingController search = TextEditingController();
  final allprofileController = Get.put(AllProfileController());
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxBool isAccount = true.obs;
  RxList<String> cities = RxList([
    // USA
    "New York", "Los Angeles", "Chicago", "Houston", "Miami",
    "San Francisco", "Las Vegas", "Seattle", "Boston", "Washington D.C.",

    // UK
    "London", "Manchester", "Birmingham", "Liverpool", "Edinburgh",
    "Glasgow", "Bristol", "Leeds", "Sheffield", "Newcastle",

    // France
    "Paris", "Marseille", "Lyon", "Toulouse", "Nice",
    "Nantes", "Strasbourg", "Montpellier", "Bordeaux", "Lille",

    // Germany
    "Berlin", "Munich", "Hamburg", "Frankfurt", "Cologne",
    "Stuttgart", "Düsseldorf", "Dresden", "Leipzig", "Nuremberg",

    // Canada
    "Toronto", "Vancouver", "Montreal", "Calgary", "Ottawa",
    "Edmonton", "Winnipeg", "Quebec City", "Hamilton", "Halifax",

    // Australia
    "Sydney", "Melbourne", "Brisbane", "Perth", "Adelaide",
    "Gold Coast", "Canberra", "Newcastle", "Hobart", "Darwin",

    // Brazil
    "São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza",
    "Belo Horizonte", "Manaus", "Curitiba", "Recife", "Porto Alegre",

    // India
    "Delhi", "Mumbai", "Bangalore", "Kolkata", "Chennai",
    "Hyderabad", "Pune", "Ahmedabad", "Jaipur", "Surat",

    // China
    "Shanghai", "Beijing", "Guangzhou", "Shenzhen", "Chengdu",
    "Chongqing", "Wuhan", "Tianjin", "Hangzhou", "Nanjing",

    // Japan
    "Tokyo", "Osaka", "Yokohama", "Nagoya", "Sapporo",
    "Kobe", "Fukuoka", "Kyoto", "Hiroshima", "Sendai",

    // Russia
    "Moscow", "Saint Petersburg", "Novosibirsk", "Yekaterinburg", "Kazan",
    "Nizhny Novgorod", "Chelyabinsk", "Samara", "Omsk", "Rostov-on-Don",

    // South Korea
    "Seoul", "Busan", "Incheon", "Daegu", "Daejeon",
    "Gwangju", "Suwon", "Ulsan", "Changwon", "Goyang",

    // Mexico
    "Mexico City", "Guadalajara", "Monterrey", "Puebla", "Tijuana",
    "León", "Cancún", "Mérida", "Toluca", "Chihuahua",

    'Bogotá', 'Medellín', 'Cali', 'Barranquilla', 'Cartagena',
    'Cúcuta', 'Bucaramanga', 'Pereira', 'Santa Marta', 'Ibagué',
    'Manizales', 'Villavicencio', 'Soledad', 'Valledupar', 'Armenia',
    'Tunja', 'Popayán', 'Sincelejo', 'Montería', 'Neiva',
    'Riohacha', 'Quibdó', 'Palmira', 'Florencia', 'Yopal',
    'Pasto', 'Tumaco', 'San Andrés', 'Barrancabermeja', 'San Gil',
    'Chía', 'Risaralda', 'Santa Fé de Antioquia', 'Sogamoso',
    'Bello', 'La Dorada', 'El Banco', 'Líbano', 'Tuluá',
    'Ábrego',
    'Puerto Asís',
    'Turbo',
    'Santarosano',
    'Guajira'

        // South Africa
        "Johannesburg",
    "Cape Town",
    "Durban",
    "Pretoria",
    "Port Elizabeth",
    "Bloemfontein", "East London", "Pietermaritzburg", "Polokwane", "Kimberley",

    // Argentina
    "Buenos Aires", "Córdoba", "Rosario", "Mendoza", "La Plata",
    "Mar del Plata", "Salta", "Santa Fe", "San Juan", "Tucumán",

    // Italy
    "Rome", "Milan", "Naples", "Turin", "Palermo",
    "Genoa", "Bologna", "Florence", "Venice", "Verona",

    // Spain
    "Madrid", "Barcelona", "Valencia", "Seville", "Zaragoza",
    "Málaga", "Murcia", "Bilbao", "Granada", "Alicante",

    // Turkey
    "Istanbul", "Ankara", "Izmir", "Bursa", "Antalya",
    "Konya", "Gaziantep", "Adana", "Mersin", "Kayseri",

    // Egypt
    "Cairo", "Alexandria", "Giza", "Sharm El Sheikh", "Luxor",
    "Aswan", "Port Said", "Suez", "Mansoura", "Tanta",

    // Netherlands
    "Amsterdam", "Rotterdam", "The Hague", "Utrecht", "Eindhoven",
    "Tilburg", "Groningen", "Breda", "Nijmegen", "Enschede",

    // Sweden
    "Stockholm", "Gothenburg", "Malmö", "Uppsala", "Västerås",
    "Örebro", "Linköping", "Helsingborg", "Jönköping", "Norrköping",

    "Warsaw", "Kraków", "Łódź", "Wrocław", "Poznań",
    "Gdańsk", "Szczecin", "Bydgoszcz", "Lublin", "Katowice",

    "Kuala Lumpur", "Singapore", "Helsinki", "Oslo", "Copenhagen",
    "Brussels", "Vienna", "Dublin", "Lisbon", "Athens",
    "Santiago", "Lima", "San Jose", "Montevideo", "Quito",
    "Riga", "Vilnius", "Tallinn", "Reykjavik", "Bratislava",
    "Tehran", "Dhaka", "Baku", "Manama", "Doha",
    "Muscat", "Yerevan", "Tashkent", "Ashgabat", "Kuwait City",
    "Beirut", "Damascus", "Amman", "Nairobi", "Accra",
    "Algiers", "Casablanca", "Tunis", "Khartoum", "Dakar",
    "Harare", "Windhoek", "Lusaka", "Maputo", "Kampala",
    "Lome", "Antananarivo", "Nouakchott", "Gaborone", "Lilongwe"
  ]);

  saveValue() async {
    await preferencesHelper.init();
    preferencesHelper.setBool("FirstTime", isAccount.value);
  }

  @override
  void onInit() {
    super.onInit();
    saveValue();
  }

  RxList<String> filteredSuggestions = RxList([]);

  void filterSuggestions(String query) {
    if (query.isEmpty) {
      filteredSuggestions.value = [];
    } else {
      filteredSuggestions.value = cities
          .where((cityCountry) =>
              cityCountry.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateTextController(
      TextEditingController? controller, String value) async {
    controller?.text = value;
    allprofileController.searchQuery = search.text;
    debugPrint(
        'TextController:===========>>> ${allprofileController.searchQuery}');
  }

  @override
  void onClose() {
    super.onClose();

    search.dispose();
  }
}
