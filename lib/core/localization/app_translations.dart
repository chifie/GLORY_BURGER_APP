/// Translation keys for the Glory Burger app.
/// Supports English (default) and Tanzanian Swahili.
class AppTranslations {
  AppTranslations._();

  /// Returns the translated string based on the language code.
  static String translate(String key, String language) {
    final translations = language == 'sw' ? _swahili : _english;
    return translations[key] ?? key;
  }

  /// English translations (default)
  static const Map<String, String> _english = {
    // ── App ──────────────────────────────────────────────────────
    'app.name': 'Glory Burger',
    'app.tagline': 'Taste the Glory!',

    // ── Navigation & Drawer ──────────────────────────────────────
    'nav.home': 'Home',
    'nav.my_cart': 'My Cart',
    'nav.order_history': 'Order History',
    'nav.my_profile': 'My Profile',
    'nav.rate_app': 'Rate the App',
    'nav.about': 'About Glory Burger',
    'nav.logout': 'Logout',

    // ── Drawer Sections ──────────────────────────────────────────
    'section.payment': 'PAYMENT',
    'section.more': 'MORE',
    'section.appearance': 'APPEARANCE',
    'section.settings': 'SETTINGS',

    // ── Payment Methods ──────────────────────────────────────────
    'payment.methods': 'Payment Methods',
    'payment.select': 'Select Payment Method',
    'payment.choose': 'Choose your preferred way to pay',
    'payment.credit_card': 'Credit/Debit Card',
    'payment.credit_card_sub': 'Visa, Mastercard & more',
    'payment.mpesa': 'M-Pesa',
    'payment.mpesa_sub': 'Pay via M-Pesa mobile money',
    'payment.halopesa': 'HaloPesa',
    'payment.halopesa_sub': 'Pay via HaloPesa mobile wallet',
    'payment.mix_by_yas': 'Mix by Yas',
    'payment.mix_by_yas_sub': 'Pay via Mix by Yas',
    'payment.airtel_money': 'Airtel Money',
    'payment.airtel_money_sub': 'Pay via Airtel Money',
    'payment.cash_on_delivery': 'Cash on Delivery',
    'payment.cash_on_delivery_sub': 'Pay when you receive your order',

    // ── Language ─────────────────────────────────────────────────
    'language.title': 'Language',
    'language.english': 'English',
    'language.swahili': 'Kiswahili',
    'language.select': 'Select Language',
    'language.choose': 'Choose your preferred language',
    'language.current': 'Current Language',

    // ── Location ─────────────────────────────────────────────────
    'location.title': 'Location',
    'location.select': 'Select Location',
    'location.choose': 'Choose your delivery location',
    'location.current': 'Current Location',
    'location.dar_es_salaam': 'Dar es Salaam',
    'location.dodoma': 'Dodoma',
    'location.mwanza': 'Mwanza',
    'location.arusha': 'Arusha',
    'location.mbeya': 'Mbeya',
    'location.zanzibar': 'Zanzibar',
    'location.tanga': 'Tanga',
    'location.morogoro': 'Morogoro',
    'location.kilimanjaro': 'Kilimanjaro',
    'location.tabora': 'Tabora',
    'location.iringa': 'Iringa',

    // ── Theme ────────────────────────────────────────────────────
    'theme.light_mode': 'Light Mode',
    'theme.dark_mode': 'Dark Mode',
    'theme.switch_light': 'Switch to light theme',
    'theme.switch_dark': 'Switch to dark theme',

    // ── Profile ──────────────────────────────────────────────────
    'profile.title': 'My Profile',
    'profile.personal_info': 'Personal Information',
    'profile.edit': 'Edit',
    'profile.save': 'Save',
    'profile.cancel': 'Cancel',
    'profile.full_name': 'Full Name',
    'profile.email': 'Email Address',
    'profile.phone': 'Phone Number',
    'profile.delivery_address': 'Delivery Address',
    'profile.updated': 'Profile updated successfully',
    'profile.logout_title': 'Log Out',
    'profile.logout_confirm': 'Are you sure you want to log out of Glory Burger?',
    'profile.logged_out': 'Logged out successfully',

    // ── App Info ─────────────────────────────────────────────────
    'info.app_version': 'App Version',
    'info.rate_us': 'Rate Us',
    'info.privacy': 'Privacy Policy',
    'info.terms': 'Terms of Service',

    // ── Cart ─────────────────────────────────────────────────────
    'cart.empty': 'Your cart is empty',
    'cart.total': 'Total',
    'cart.checkout': 'Proceed to Checkout',
    'cart.continue_shopping': 'Continue Shopping',

    // ── Orders ──────────────────────────────────────────────────
    'orders.title': 'My Orders',
    'orders.empty': 'No orders yet',
    'orders.pending': 'Pending',
    'orders.preparing': 'Preparing',
    'orders.on_delivery': 'On Delivery',
    'orders.delivered': 'Delivered',
    'orders.track': 'Track Order',

    // ── Home Screen ─────────────────────────────────────────────
    'home.welcome': 'Welcome back!',
    'home.search_hint': 'Search for burgers, meals...',
    'home.popular': 'Popular Burgers',
    'home.categories': 'Categories',
    'home.special_offer': 'Special Offer',
    'home.view_all': 'View All',
    'home.add_to_cart': 'Add to Cart',

    // ── Food Details ────────────────────────────────────────────
    'details.description': 'Description',
    'details.quantity': 'Quantity',
    'details.total_price': 'Total Price',
    'details.add_to_cart': 'Add to Cart',
    'details.view_cart': 'VIEW CART',
    'details.added_to_cart': '× added to cart',

    // ── Checkout ────────────────────────────────────────────────
    'checkout.title': 'Checkout',
    'checkout.order_summary': 'Order Summary',
    'checkout.subtotal': 'Subtotal',
    'checkout.delivery_fee': 'Delivery Fee',
    'checkout.free_delivery': 'Free Delivery',
    'checkout.total': 'Total',
    'checkout.place_order': 'Place Order',
    'checkout.order_success': 'Order placed successfully!',

    // ── Drawer Account ──────────────────────────────────────────
    'drawer.enthusiast': 'Glory Burger Enthusiast',
    'drawer.customer_email': 'customer@gloryburger.com',

    // ── General ─────────────────────────────────────────────────
    'general.yes': 'Yes',
    'general.no': 'No',
  };

  /// Swahili translations
  static const Map<String, String> _swahili = {
    // ── App ──────────────────────────────────────────────────────
    'app.name': 'Glory Burger',
    'app.tagline': 'Onja Utukufu!',

    // ── Navigation & Drawer ──────────────────────────────────────
    'nav.home': 'Nyumbani',
    'nav.my_cart': 'Rukoba Langu',
    'nav.order_history': 'Historia ya Maagizo',
    'nav.my_profile': 'Wasifu Wangu',
    'nav.rate_app': 'Kadiria Programu',
    'nav.about': 'Kuhusu Glory Burger',
    'nav.logout': 'Toka',

    // ── Drawer Sections ──────────────────────────────────────────
    'section.payment': 'MALIPO',
    'section.more': 'ZAIDI',
    'section.appearance': 'MUONEKANO',
    'section.settings': 'MIPANGILIO',

    // ── Payment Methods ──────────────────────────────────────────
    'payment.methods': 'Njia za Malipo',
    'payment.select': 'Chagua Njia ya Malipo',
    'payment.choose': 'Chagua njia unayopendelea kulipa',
    'payment.credit_card': 'Kadi ya Mkopo/Debiti',
    'payment.credit_card_sub': 'Visa, Mastercard na nyingine',
    'payment.mpesa': 'M-Pesa',
    'payment.mpesa_sub': 'Lipa kwa M-Pesa',
    'payment.halopesa': 'HaloPesa',
    'payment.halopesa_sub': 'Lipa kwa HaloPesa',
    'payment.mix_by_yas': 'Mix by Yas',
    'payment.mix_by_yas_sub': 'Lipa kwa Mix by Yas',
    'payment.airtel_money': 'Airtel Money',
    'payment.airtel_money_sub': 'Lipa kwa Airtel Money',
    'payment.cash_on_delivery': 'Lipa Ukifika',
    'payment.cash_on_delivery_sub': 'Lipa unapopokea order yako',

    // ── Language ─────────────────────────────────────────────────
    'language.title': 'Lugha',
    'language.english': 'Kiingereza',
    'language.swahili': 'Kiswahili',
    'language.select': 'Chagua Lugha',
    'language.choose': 'Chagua lugha unayopendelea',
    'language.current': 'Lugha ya Sasa',

    // ── Location ─────────────────────────────────────────────────
    'location.title': 'Mahali',
    'location.select': 'Chagua Mahali',
    'location.choose': 'Chagua mahali pa kufikishia',
    'location.current': 'Mahali pa Sasa',
    'location.dar_es_salaam': 'Dar es Salaam',
    'location.dodoma': 'Dodoma',
    'location.mwanza': 'Mwanza',
    'location.arusha': 'Arusha',
    'location.mbeya': 'Mbeya',
    'location.zanzibar': 'Zanzibar',
    'location.tanga': 'Tanga',
    'location.morogoro': 'Morogoro',
    'location.kilimanjaro': 'Kilimanjaro',
    'location.tabora': 'Tabora',
    'location.iringa': 'Iringa',

    // ── Theme ────────────────────────────────────────────────────
    'theme.light_mode': 'Mwanga',
    'theme.dark_mode': 'Giza',
    'theme.switch_light': 'Badilisha hadi mwanga',
    'theme.switch_dark': 'Badilisha hadi giza',

    // ── Profile ──────────────────────────────────────────────────
    'profile.title': 'Wasifu Wangu',
    'profile.personal_info': 'Maelezo ya Kibinafsi',
    'profile.edit': 'Hariri',
    'profile.save': 'Hifadhi',
    'profile.cancel': 'Ghairi',
    'profile.full_name': 'Jina Kamili',
    'profile.email': 'Barua Pepe',
    'profile.phone': 'Nambari ya Simu',
    'profile.delivery_address': 'Anwani ya Kufikishia',
    'profile.updated': 'Wasifu umehifadhiwa kikamilifu',
    'profile.logout_title': 'Toka',
    'profile.logout_confirm': 'Una uhakika unataka kutoka kwenye Glory Burger?',
    'profile.logged_out': 'Umetoka kikamilifu',

    // ── App Info ─────────────────────────────────────────────────
    'info.app_version': 'Toleo la Programu',
    'info.rate_us': 'Tupatie Alama',
    'info.privacy': 'Sera ya Faragha',
    'info.terms': 'Masharti ya Huduma',

    // ── Cart ─────────────────────────────────────────────────────
    'cart.empty': 'Rukoba lako ni tupu',
    'cart.total': 'Jumla',
    'cart.checkout': 'Nenda kwa Malipo',
    'cart.continue_shopping': 'Endelea Kununua',

    // ── Orders ──────────────────────────────────────────────────
    'orders.title': 'Maagizo Yangu',
    'orders.empty': 'Hujawahi kuagiza bado',
    'orders.pending': 'Inasubiri',
    'orders.preparing': 'Inatayarishwa',
    'orders.on_delivery': 'Inafikishwa',
    'orders.delivered': 'Imefikishwa',
    'orders.track': 'Fuatilia Agizo',

    // ── Home Screen ─────────────────────────────────────────────
    'home.welcome': 'Karibu tena!',
    'home.search_hint': 'Tafuta burger, chakula...',
    'home.popular': 'Burger Maarufu',
    'home.categories': 'Aina za Vyakula',
    'home.special_offer': 'Ofa Maalum',
    'home.view_all': 'Angalia Zote',
    'home.add_to_cart': 'Ongeza Kwenye Rukoba',

    // ── Food Details ────────────────────────────────────────────
    'details.description': 'Maelezo',
    'details.quantity': 'Idadi',
    'details.total_price': 'Bei ya Jumla',
    'details.add_to_cart': 'Ongeza Kwenye Rukoba',
    'details.view_cart': 'ANGALIA RUKOBA',
    'details.added_to_cart': '× imeongezwa kwenye rukoba',

    // ── Checkout ────────────────────────────────────────────────
    'checkout.title': 'Malipo',
    'checkout.order_summary': 'Muhtasari wa Agizo',
    'checkout.subtotal': 'Jumla Ndogo',
    'checkout.delivery_fee': 'Ada ya Usafirishaji',
    'checkout.free_delivery': 'Usafirishaji Bure',
    'checkout.total': 'Jumla',
    'checkout.place_order': 'Weka Agizo',
    'checkout.order_success': 'Agizo limewekwa kikamilifu!',

    // ── Drawer Account ──────────────────────────────────────────
    'drawer.enthusiast': 'Mpenzi wa Glory Burger',
    'drawer.customer_email': 'customer@gloryburger.com',

    // ── General ─────────────────────────────────────────────────
    'general.yes': 'Ndiyo',
    'general.no': 'Hapana',
  };
}

/// Helper extension to easily get translated strings in widgets.
extension StringTranslate on String {
  String tr(String language) => AppTranslations.translate(this, language);
}