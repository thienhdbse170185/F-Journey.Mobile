class VnpayResponse {
  final int amount;
  final String bankCode;
  final String bankTranNo;
  final String cardType;
  final String orderInfo;
  final String payDate;
  final String responseCode;
  final String tmnCode;
  final String transactionNo;
  final String transactionStatus;
  final String txnRef;
  final String secureHash;

  VnpayResponse({
    required this.amount,
    required this.bankCode,
    required this.bankTranNo,
    required this.cardType,
    required this.orderInfo,
    required this.payDate,
    required this.responseCode,
    required this.tmnCode,
    required this.transactionNo,
    required this.transactionStatus,
    required this.txnRef,
    required this.secureHash,
  });

  factory VnpayResponse.fromUrl(Uri uri) {
    try {
      final queryParams = uri.queryParameters;

      return VnpayResponse(
        amount: int.parse(queryParams['vnp_Amount']!),
        bankCode: queryParams['vnp_BankCode']!,
        bankTranNo: queryParams['vnp_BankTranNo']!,
        cardType: queryParams['vnp_CardType']!,
        orderInfo: queryParams['vnp_OrderInfo']!,
        payDate: queryParams['vnp_PayDate']!,
        responseCode: queryParams['vnp_ResponseCode']!,
        tmnCode: queryParams['vnp_TmnCode']!,
        transactionNo: queryParams['vnp_TransactionNo']!,
        transactionStatus: queryParams['vnp_TransactionStatus']!,
        txnRef: queryParams['vnp_TxnRef']!,
        secureHash: queryParams['vnp_SecureHash']!,
      );
    } catch (e) {
      rethrow;
    }
  }

  factory VnpayResponse.fromQuery(String queryString) {
    try {
      final queryParams = Uri.splitQueryString(queryString);

      return VnpayResponse(
        amount: int.parse(queryParams['vnp_Amount']!),
        bankCode: queryParams['vnp_BankCode']!,
        bankTranNo: queryParams['vnp_BankTranNo']!,
        cardType: queryParams['vnp_CardType']!,
        orderInfo: queryParams['vnp_OrderInfo']!,
        payDate: queryParams['vnp_PayDate']!,
        responseCode: queryParams['vnp_ResponseCode']!,
        tmnCode: queryParams['vnp_TmnCode']!,
        transactionNo: queryParams['vnp_TransactionNo']!,
        transactionStatus: queryParams['vnp_TransactionStatus']!,
        txnRef: queryParams['vnp_TxnRef']!,
        secureHash: queryParams['vnp_SecureHash']!,
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bankCode': bankCode,
      'bankTranNo': bankTranNo,
      'cardType': cardType,
      'orderInfo': orderInfo,
      'payDate': payDate,
      'responseCode': responseCode,
      'tmnCode': tmnCode,
      'transactionNo': transactionNo,
      'transactionStatus': transactionStatus,
      'txnRef': txnRef,
      'secureHash': secureHash,
    };
  }

  @override
  String toString() {
    return 'vnp_Amount=$amount&vnp_BankCode=$bankCode&vnp_BankTranNo=$bankTranNo&vnp_CardType=$cardType&vnp_OrderInfo=$orderInfo&vnp_PayDate=$payDate&vnp_ResponseCode=$responseCode&vnp_TmnCode=$tmnCode&vnp_TransactionNo=$transactionNo&vnp_TransactionStatus=$transactionStatus&vnp_TxnRef=$txnRef&vnp_SecureHash=$secureHash';
  }
}
