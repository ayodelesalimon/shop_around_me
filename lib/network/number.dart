class NetworkDetails {
  final String networkName;
  final String number;

  NetworkDetails(this.number, this.networkName);

  List ayo = ["Airtel", 1, 2, 3, 4, 5, 6, 8];

  static List<NetworkDetails> people() {
    return <NetworkDetails>[
      NetworkDetails('0701', "Airtel Nigeria"),
      NetworkDetails('07020', 'Smile'),
      NetworkDetails('07025', 'MTN Nigeria - formerly Visafone'),
      NetworkDetails('07026', 'MTN Nigeria - formerly Visafone'),
      NetworkDetails('07027', 'Multi-Links'),
      NetworkDetails('07028', 'Starcomms'),
      NetworkDetails('07029', 'Starcomms'),
      NetworkDetails('0703', 'MTN Nigeria'),
      NetworkDetails('0704', 'MTN Nigeria - formerly Visafone'),
      NetworkDetails('0705', 'Globacom'),
      NetworkDetails('0706', 'MTN Nigeria'),
      NetworkDetails('0707', 'ZoomMobile - formerly Reltel'),
    ];
  }
}
