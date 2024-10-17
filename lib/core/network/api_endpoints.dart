class ApiEndpoints {
  // Authentication Endpoints
  static const String login = "/auth/login";
  static const String loginGoogle = "/authentication/google-login-passenger";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";

  // User Endpoints
  static const String getUserProfile = "/user/profile";
  static const String updateUserProfile = "/user/update";

  // Product Endpoints
  static const String getProducts = "/products";
  static const String getProductDetails = "/products/details";
  static const String createProduct = "/products/create";
  static const String updateProduct = "/products/update";
  static const String deleteProduct = "/products/delete";

  // Order Endpoints
  static const String getOrders = "/orders";
  static const String getOrderDetails = "/orders/details";
  static const String createOrder = "/orders/create";
  static const String updateOrder = "/orders/update";
  static const String deleteOrder = "/orders/delete";
}
