// List<Page<dynamic>> onGenerateAppViewPages(
//   AppStatus state,
//   List<Page<dynamic>> pages,
// ) {
//   switch (state) {
//     case AppStatus.authenticated:
//       return [HomePage.page()];
//     case AppStatus.unauthenticated:
//       return [LoginPage.page()];
//   }
// }

abstract class UserRoutes {
  static const home = '/';
  static const login = '/login';
  static const signUp = '/sign-up';
}

abstract class AdminRoutes {
  static const admin = '/admin';
  static const rawMaterials = '/admin/raw-materials';
  static const orders = '/admin/orders';
  static const customers = '/admin/customers';
  static const production = '/admin/production';
  static const rugs = '/admin/rugs';
}
