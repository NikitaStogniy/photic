import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['ru', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ruText = '',
    String? enText = '',
  }) =>
      [ruText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '47rlkssg': {
      'ru': 'Сгенерировать',
      'en': 'Generate',
    },
    'uc5l7qmd': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // authPage
  {
    'epeju9qp': {
      'ru': 'Регистрация',
      'en': 'Registration',
    },
    'eritvh83': {
      'ru': 'Email',
      'en': 'Email',
    },
    'lp5wyzqf': {
      'ru': 'Пароль',
      'en': 'Password',
    },
    'jvud3hhp': {
      'ru': 'Подтвердить пароль',
      'en': 'Confirm password',
    },
    'wh6sqeaj': {
      'ru': 'Регистрация',
      'en': 'Registration',
    },
    '7077b2sp': {
      'ru': 'Войти через Google',
      'en': 'Login with Google',
    },
    'o0sbi066': {
      'ru': 'Войти через Google',
      'en': 'Login with Google',
    },
    'xyfzbft5': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // onboardPage
  {
    'vkr9t177': {
      'ru': 'Работает на AI',
      'en': 'Powered by AI',
    },
    'iqouhax1': {
      'ru': 'Аватар',
      'en': 'Avatar',
    },
    'zn1h9a01': {
      'ru': 'Создайте аватар из пожеланий и вашей фотографии',
      'en': 'Create an avatar from wishes and your photo',
    },
    'x9dmhv3s': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    'k07bx203': {
      'ru': 'Работает на AI',
      'en': 'Powered by AI',
    },
    'u46zwvzl': {
      'ru': 'Генерация изображения',
      'en': 'Image generation',
    },
    'q029ncgd': {
      'ru':
          'Искусственный интеллект самостоятельно создаст любое изображение по вашему запросу',
      'en':
          'Artificial intelligence will independently create any image at your request',
    },
    '9wdxsuxa': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    '21hgoj4n': {
      'ru': 'Функции приложенения',
      'en': 'Application Features',
    },
    'exriaxet': {
      'ru': 'Home',
      'en': 'Home',
    },
  },
  // Subscribtion
  {
    'cp31lqg3': {
      'ru': 'Выберите план',
      'en': 'Choose a plan',
    },
    '6uk0hfc0': {
      'ru': 'Откройте все потенциальные возможности нашего приложения',
      'en': 'Discover all the potential of our application',
    },
    'xgus7t1y': {
      'ru':
          'Наслаждайтесь неограниченным количеством аватаров и картинок без ограничений',
      'en': 'Enjoy unlimited avatars and pictures without limits',
    },
    '81qstviv': {
      'ru': ' / мес',
      'en': '/ month',
    },
    'i485bov3': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    'kdzb2pty': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // subscription_done
  {
    'jx2d6h7s': {
      'ru': 'Спасибо за подписку',
      'en': 'Thanks for subscribing',
    },
    'gelju6d8': {
      'ru': 'Ваш план ',
      'en': 'Avatar',
    },
    '5wxbl67r': {
      'ru':
          'Теперь у вас есть доступ ко всем функциям приложения:\nвсе стили аватара\nтекстовая генерация изображений\n',
      'en':
          'Now you have access to all the functions of our application:\nall avatar styles\ntext image generation\ninPainting mode',
    },
    'd2smy3c5': {
      'ru': 'Начать',
      'en': 'Begin',
    },
    'bpep7kpz': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // Generate_image_page
  {
    'v8or36yn': {
      'ru': 'Что ожидать?',
      'en': 'What to expect?',
    },
    'crj1yc3f': {
      'ru':
          'Искусственный интеллект может создавать артефакты, неточности и дефекты в конечных изображениях, к сожалению, это вне нашего контроля. Пожалуйста, примите эти риски, прежде чем продолжить.',
      'en':
          'Artificial intelligence can create artifacts, inaccuracies and defects in the final images, unfortunately, this is out of our control. Please accept these risks before proceeding.',
    },
    'iwey65dh': {
      'ru': 'Хорошие примеры',
      'en': 'good examples',
    },
    '5n0e7ucz': {
      'ru': 'Примеры с артефактами',
      'en': 'Examples with artifacts',
    },
    'd7dx3apu': {
      'ru': 'Я достиг совершеннолетия',
      'en': 'I am of legal age (18/21+)',
    },
    '99ksnuzx': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    'xmrfv29z': {
      'ru': 'Запрос',
      'en': 'Request',
    },
    'srvjhuxf': {
      'ru': 'Опишите идею...',
      'en': 'Describe your idea...',
    },
    'wqoqg3pe': {
      'ru': 'Выберите стиль',
      'en': 'Choose a style',
    },
    '7yps6n70': {
      'ru': 'Реалистичный',
      'en': 'Realistic',
    },
    '68a2v3aa': {
      'ru': 'Дикий запад',
      'en': 'Wild West',
    },
    '1patzi7o': {
      'ru': 'Комиксы',
      'en': 'Comics',
    },
    '83soxvwp': {
      'ru': 'Киберпанк',
      'en': 'Cyberpunk',
    },
    '1cfvf2yb': {
      'ru': 'Аниме',
      'en': 'Anime',
    },
    'a9gw5b6v': {
      'ru': 'Реалистичный',
      'en': 'Realistic',
    },
    '8o8xmfjm': {
      'ru': 'Рисунок',
      'en': 'Drawing',
    },
    '2hue9b30': {
      'ru': 'Пожалуйста выберите...',
      'en': 'Please select...',
    },
    't08dhxfh': {
      'ru': 'Поиск...',
      'en': 'Search for an item...',
    },
    'aaz13r79': {
      'ru': 'Выбрать цвет',
      'en': 'Choose colors',
    },
    'mg6r7tz1': {
      'ru': 'Красный',
      'en': 'Red',
    },
    'f9roofbb': {
      'ru': 'Оранжевый',
      'en': 'Orange',
    },
    's97udmut': {
      'ru': 'Желтый',
      'en': 'Yellow',
    },
    '9mbnaqce': {
      'ru': 'Пожалуйста выберите...',
      'en': 'Please select...',
    },
    'l4weehjr': {
      'ru': 'Поиск...',
      'en': 'Search for an item...',
    },
    'kguzflaz': {
      'ru': 'Выбор художника',
      'en': 'Choose an artist',
    },
    'lakrod0s': {
      'ru': 'Banksy',
      'en': 'Banksy',
    },
    'jus688zv': {
      'ru': 'Van Gogh',
      'en': 'Van Gogh',
    },
    'e9j0c7o3': {
      'ru': 'Gustav Klimt',
      'en': 'Gustav Klimt',
    },
    'uus6s71c': {
      'ru': 'Please select...',
      'en': 'Please select...',
    },
    'jb63rpkb': {
      'ru': 'Поиск...',
      'en': 'Search for an item...',
    },
    'ycbwugcw': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    'qsh3u3tp': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // generate_holder
  {
    '95m9xmi4': {
      'ru': 'Генерация изображения',
      'en': 'Image generation',
    },
    'k5rx738m': {
      'ru': ' секунд осталось',
      'en': 'seconds left',
    },
    '8d9spm4k': {
      'ru': 'Отправить уведомление',
      'en': 'Send Notification',
    },
    '5uvmqa26': {
      'ru': 'Скрыть',
      'en': 'Hide',
    },
    'f2y18zai': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // Generate_avatar_page
  {
    'j90bjzyn': {
      'ru': 'Что ожидать?',
      'en': 'What to expect?',
    },
    'nzzosdjh': {
      'ru':
          'Искусственный интеллект может создавать артефакты, неточности и дефекты на конечных изображениях, к сожалению, это находится вне нашего контроля. Пожалуйста, примите эти риски, прежде чем продолжить.',
      'en':
          'Artificial intelligence can create artifacts, inaccuracies and defects in the final images, unfortunately, this is out of our control. Please accept these risks before proceeding.',
    },
    'x40hl25c': {
      'ru': 'Хорошие примеры',
      'en': 'good examples',
    },
    'a566a8fr': {
      'ru': 'Примеры с артифактами',
      'en': 'Examples with artifacts',
    },
    'ii0rezwv': {
      'ru': 'Я совершеннолетний (18/21+)',
      'en': 'I am of legal age (18/21+)',
    },
    'o5en4lh8': {
      'ru': 'Продолжить',
      'en': 'Continue',
    },
    'ra2saarl': {
      'ru': 'Выберите пол',
      'en': 'Enter your gender',
    },
    'agj09f31': {
      'ru': 'Мужчина',
      'en': 'Man',
    },
    'jmh928i6': {
      'ru': 'Женщина',
      'en': 'Woman',
    },
    'a8l01j9s': {
      'ru': 'Выберите стиль',
      'en': 'choose a style',
    },
    'kkdbepdp': {
      'ru': 'Загрузите фото',
      'en': 'Upload a photo',
    },
    'b7pamrxh': {
      'ru': '✅ Подходящие фото',
      'en': '✅ Suitable photos',
    },
    'clpdt0se': {
      'ru':
          'Сделайте селфи или выберите фотографию из галереи. Фотография должна быть только крупным планом вас, только лицом и немного шеи. Без шляп и иностранных предметов на фоне.',
      'en':
          'Take a selfie or select a photo from the gallery. The photo should be only close-up of you, only the face and a little of the neck. Without hats and foreign things in the frame.',
    },
    '1ls0h5du': {
      'ru': '❌ Неподходящие фото',
      'en': '❌ Bad photos',
    },
    'bjc5rtpk': {
      'ru':
          'В полный рост, дети, что-то закрывает лицо, есть другие люди или животные, нюдсы.',
      'en':
          'In full growth, children, something covers the face, there are other people or animals, nudes.',
    },
    'u3trp0rl': {
      'ru':
          'Наши серверы будут немедленно удалять фотографии после создания аватаров.',
      'en':
          'Our servers will delete photos immediately after Avatars are created.',
    },
    '4anb70b0': {
      'ru': 'Загрузить',
      'en': 'Upload',
    },
    'u55fwwgw': {
      'ru':
          'Убедитесь, что ваше фото соответствует нашим рекомендациям, чтобы результат был ожидаемым.',
      'en':
          'Make sure your photo matches our guidelines so that the result is as expected.',
    },
    'v4sio1zs': {
      'ru': 'Сгенерировать Аватар',
      'en': 'Generate avatar',
    },
    'kvtqgzsd': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // addStyle
  {
    'b7md7w5u': {
      'ru': 'Имя',
      'en': 'Name',
    },
    'dwsivql1': {
      'ru': 'Мужчина',
      'en': 'Man',
    },
    '3idmd5fn': {
      'ru': 'Женщина',
      'en': 'Woman',
    },
    '4sew2es5': {
      'ru': 'Пожалуйста, выберите...',
      'en': 'Please select...',
    },
    'ky6qvjh2': {
      'ru': 'Поиск...',
      'en': 'Search for an item...',
    },
    'yd798w51': {
      'ru': 'Загрузить пример',
      'en': 'Upload preview',
    },
    '3dxlewo4': {
      'ru': 'Сохранить',
      'en': 'Save',
    },
    'lttwe1db': {
      'ru': 'Добавить стиль',
      'en': 'Add Style',
    },
    'goq2b1re': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // packPage
  {
    'uezap7fc': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // settingsPage
  {
    '0hf140sp': {
      'ru': 'Аккаунт и подписка',
      'en': 'Account and subscription',
    },
    'up2m5q91': {
      'ru': 'Аккаунт',
      'en': 'account',
    },
    '0uyluxyn': {
      'ru': 'План',
      'en': 'Plan',
    },
    'ps77c6t2': {
      'ru': 'Аккаунт и подписка',
      'en': 'Account and subscription',
    },
    'xrun0cmm': {
      'ru': 'Политика конфиденцальности',
      'en': 'privacy policy',
    },
    'e32nk8m7': {
      'ru': 'Правила использования',
      'en': 'Terms of use',
    },
    'snlwea90': {
      'ru': 'Настройки',
      'en': 'Settings',
    },
    '2e24vneu': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // accountPage
  {
    'cz81kkxh': {
      'ru': 'Выйти',
      'en': 'sign out',
    },
    'vh54jrih': {
      'ru': 'Аккаунт',
      'en': 'account',
    },
    'kgtzsw0b': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // Landing
  {
    'zubnbjw5': {
      'ru': 'Photic',
      'en': 'Photic',
    },
    'nq0w4ruu': {
      'ru':
          'Создайте стильные аватарки для соцсетей с помощью AI: следуйте трендам с Photic Generator!',
      'en':
          'Create Stylish Social Media Avatars with AI: Follow the Trends with Photic Generator!',
    },
    'a6ky7d1z': {
      'ru': 'Начать генерировать!',
      'en': 'Start generating!',
    },
    'rjh3nycx': {
      'ru': 'Быстро',
      'en': 'Fast',
    },
    'ayl60jho': {
      'ru':
          'Использование AI-инструмента для генерации аватарок на основе трендовых тем позволяет быстро создавать уникальные и привлекательные изображения для социальных сетей. ',
      'en':
          'Using an AI tool to generate avatars based on trending topics allows you to quickly create unique and attractive images for social networks.',
    },
    'gkvf4gd1': {
      'ru': 'Безопасно',
      'en': 'Safely',
    },
    'v8vf5ojk': {
      'ru':
          'Мы не храним ваши личные изображения и не показываем их людям во время генерации аватарок',
      'en':
          'We do not store your personal images and do not show them to people during the generation of avatars',
    },
    'rsufh0xo': {
      'ru': 'Удобно',
      'en': 'Comfortable',
    },
    'xyo9kw0h': {
      'ru':
          'AI-инструмент предлагает широкий выбор стилей, цветовых схем и элементов дизайна, которые могут быть настроены в соответствии с предпочтениями и требованиями пользователя',
      'en':
          'The AI ​​tool offers a wide range of styles, color schemes and design elements that can be customized to suit the user\'s preferences and requirements.',
    },
    'fk7cbgwa': {
      'ru': 'Примеры генерации',
      'en': 'Generation examples',
    },
    '616argxy': {
      'ru': 'Связаться с нами',
      'en': 'Connect with us',
    },
    '7s5t6zs0': {
      'ru': 'Ваше имя',
      'en': 'your name',
    },
    'p6d4sxvc': {
      'ru': 'Email',
      'en': 'Email',
    },
    'bl31ww1y': {
      'ru': 'Отправить',
      'en': 'Send',
    },
    '5souh25j': {
      'ru': 'Photic',
      'en': 'Photic',
    },
    'rtv9v1pa': {
      'ru': 'Домой',
      'en': 'Home',
    },
  },
  // painter
  {
    'pa5olk83': {
      'ru': 'Describe your idea...',
      'en': '',
    },
    '9azkh0ap': {
      'ru': 'Edit',
      'en': 'Edit',
    },
    'qreav30u': {
      'ru': 'Загрузить',
      'en': 'Upload',
    },
    'qiox6dmz': {
      'ru': 'Inpaint',
      'en': '',
    },
    's3b2oe03': {
      'ru': 'Home',
      'en': '',
    },
  },
  // generate_bottomsheet
  {
    'ry5jepoj': {
      'ru': 'Хочу сгенерировать',
      'en': 'What to generate',
    },
    'whzksceh': {
      'ru': 'Аватары',
      'en': 'Avatars',
    },
    'iaxq7ef8': {
      'ru': 'Изображения',
      'en': 'Images',
    },
    'igizfnkl': {
      'ru': 'Редактировать',
      'en': 'Edit',
    },
  },
  // subscription
  {
    '4o5fohbm': {
      'ru': 'Текущий план',
      'en': 'Сurrent plan',
    },
    'p2x22sxt': {
      'ru': 'Генерации',
      'en': 'Generations',
    },
    'p4c3o3n1': {
      'ru': '0',
      'en': '0',
    },
    'faf9v4do': {
      'ru': 'Обновить',
      'en': 'Upgrade',
    },
  },
  // Miscellaneous
  {
    'kntflqlo': {
      'ru': '',
      'en': '',
    },
    '18tjhqk8': {
      'ru': '',
      'en': '',
    },
    'h986p8jj': {
      'ru': '',
      'en': '',
    },
    'pw44r22r': {
      'ru': '',
      'en': '',
    },
    'jsn9uq2r': {
      'ru': '',
      'en': '',
    },
    'jufxxitb': {
      'ru': '',
      'en': '',
    },
    'jm8rw8w0': {
      'ru': '',
      'en': '',
    },
    'tkqkz4vc': {
      'ru': '',
      'en': '',
    },
    'zkoejsl3': {
      'ru': '',
      'en': '',
    },
    'k5xdobrt': {
      'ru': '',
      'en': '',
    },
    'qcvnic9e': {
      'ru': '',
      'en': '',
    },
    'q5vaiqgm': {
      'ru': '',
      'en': '',
    },
    'bz4sa03d': {
      'ru': '',
      'en': '',
    },
    'a4xxf6lk': {
      'ru': '',
      'en': '',
    },
    '98k1u3hn': {
      'ru': '',
      'en': '',
    },
    'k3vwbcal': {
      'ru': '',
      'en': '',
    },
    '5bip7qlh': {
      'ru': '',
      'en': '',
    },
    '0itb25up': {
      'ru': '',
      'en': '',
    },
    'kahlucgp': {
      'ru': '',
      'en': '',
    },
    'sicnb7wu': {
      'ru': '',
      'en': '',
    },
    'ptji830w': {
      'ru': '',
      'en': '',
    },
    'i7bhygew': {
      'ru': '',
      'en': '',
    },
    'eqju8lqg': {
      'ru': '',
      'en': '',
    },
    'lsl8l181': {
      'ru': '',
      'en': '',
    },
    '1ozxu6rj': {
      'ru': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
