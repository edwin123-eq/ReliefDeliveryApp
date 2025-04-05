class LoginResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshExpiresIn;
  final String userName;
  final String refreshToken;
  final String? userType;
  final int userId;
  final String? clientId;
  final int currencyId;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.userName,
    required this.refreshToken,
    this.userType,
    required this.userId,
    this.clientId,
    required this.currencyId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      refreshExpiresIn: json['refresh_expires_in'],
      userName: json['user_name'],
      refreshToken: json['refresh_token'],
      userType: json['userType'],
      userId: json['user_id'],
      clientId: json['clientid'],
      currencyId: json['currencyId'],
    );
  }
}