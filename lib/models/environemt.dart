import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env';
    }
    return '.env.production';
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? 'api url not found';
  }

  static String get cloudinaryName {
    return dotenv.env['CLOUDINARY_NAME'] ?? 'api url not found';
  }

  static String get googleMapApiKey {
    return dotenv.get('GOOGLE_MAP_API_KEY',
        fallback: 'google map api key not found');
  }

  static String get sid {
    return dotenv.get('KEY_SID', fallback: 'sid not found');
  }

  static String get keyAccessToken {
    return dotenv.get('KEY_ACCESS_TOKEN', fallback: 'token not found');
  }

  static String get keyRefreshToken {
    return dotenv.get('KEY_ACCESS_TOKEN', fallback: 'token not found');
  }

  static String get email {
    return dotenv.get('KEY_EMAIL', fallback: 'email not found');
  }

  static String get password {
    return dotenv.get('KEY_PASSWORD', fallback: 'passowrd not found');
  }

  static String get role {
    return dotenv.get('KEY_ROLE', fallback: 'role not found');
  }

  static String get roleValue {
    return dotenv.get('KEY_VALUE', fallback: 'role value not found');
  }

  static String get administrator {
    return dotenv.get('KEY_ADMINISTRATOR', fallback: 'administrator not found');
  }

  static String get operatingSystem {
    return dotenv.get('KEY_OPERATINGSYSTEM',
        fallback: 'operating system not found');
  }
}
