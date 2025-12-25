class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

final List<Country> countries = [
  Country(name: "United States", code: "US", dialCode: "+1", flag: "🇺🇸"),
  Country(name: "Canada", code: "CA", dialCode: "+1", flag: "🇨🇦"),
  Country(name: "United Kingdom", code: "GB", dialCode: "+44", flag: "🇬🇧"),
  Country(name: "Australia", code: "AU", dialCode: "+61", flag: "🇦🇺"),
  Country(name: "New Zealand", code: "NZ", dialCode: "+64", flag: "🇳🇿"),
  Country(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
  Country(name: 'Saudi Arabia', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
  Country(name: 'UAE', code: 'AE', dialCode: '+971', flag: '🇦🇪'),
  Country(name: 'USA', code: 'US', dialCode: '+1', flag: '🇺🇸'),
  Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  Country(name: 'Pakistan', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
  Country(name: 'Bangladesh', code: 'BD', dialCode: '+880', flag: '🇧🇩'),
  Country(name: 'Nepal', code: 'NP', dialCode: '+977', flag: '🇳🇵'),
  Country(name: 'Sri Lanka', code: 'LK', dialCode: '+94', flag: '🇱🇰'),
  Country(name: 'Malaysia', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
  Country(name: 'Philippines', code: 'PH', dialCode: '+63', flag: '🇵🇭'),
  Country(name: 'Vietnam', code: 'VN', dialCode: '+84', flag: '🇻🇳'),
  Country(name: 'Thailand', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
  Country(name: 'Indonesia', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
];
