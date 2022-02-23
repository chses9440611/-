class CreditCard {
  final String name;
  final String url;
  final String cardType;
  final List<String> partners;

  CreditCard(
      {required this.name,
      required this.url,
      required this.cardType,
      required this.partners});

  CreditCard.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name']! as String,
          url: json['url']! as String,
          cardType: json['cardType']! as String,
          partners: (json['partners'] as List)
              .map((partner) => partner as String)
              .toList(),
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'cardType': cardType,
        'partners': partners,
      };
}
