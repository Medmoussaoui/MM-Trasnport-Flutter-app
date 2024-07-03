import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/View/Screens/account_info_screen.dart';
import 'package:mmtransport/View/Screens/auto_transfer_data_screen.dart';
import 'package:mmtransport/View/Screens/create_service_screen.dart';
import 'package:mmtransport/View/Screens/create_table_screen.dart';
import 'package:mmtransport/View/Screens/edit_invoice_screen.dart';
import 'package:mmtransport/View/Screens/edit_service_screen.dart';
import 'package:mmtransport/View/Screens/find_invoice_screen.dart';
import 'package:mmtransport/View/Screens/folder_screen.dart';
import 'package:mmtransport/View/Screens/folder_transfer_screen.dart';
import 'package:mmtransport/View/Screens/home_screen.dart';
import 'package:mmtransport/View/Screens/invoice_screen.dart';
import 'package:mmtransport/View/Screens/invoice_search_screen.dart';
import 'package:mmtransport/View/Screens/invoice_store_screen.dart';
import 'package:mmtransport/View/Screens/login_screen.dart';
import 'package:mmtransport/View/Screens/rename_table_screen.dart';
import 'package:mmtransport/View/Screens/select_truck_screen.dart';
import 'package:mmtransport/View/Screens/service_more_info_screen.dart';
import 'package:mmtransport/View/Screens/success_add_service_screen.dart';
import 'package:mmtransport/View/Screens/success_edit_service_screen.dart';
import 'package:mmtransport/View/Screens/table_invoices_store_screen.dart';
import 'package:mmtransport/View/Screens/table_screen.dart';
import 'package:mmtransport/middlewares/initial_middleware.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppRoutes.login,
    transition: Transition.leftToRight,
    middlewares: [LoginMiddleware()],
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: AppRoutes.folders,
    transition: Transition.rightToLeft,
    page: () => const FoldersScreen(),
  ),
  GetPage(
    name: AppRoutes.createServiceScreen,
    page: () => const CreateServiceScreen(),
  ),
  GetPage(
    name: AppRoutes.selectTruckScreen,
    page: () => const SelectTruckScreen(),
  ),
  GetPage(
    name: AppRoutes.successAddServiceScreen,
    page: () => const SuccessAddServiceScreen(),
  ),
  GetPage(
    name: AppRoutes.editServiceScreen,
    page: () => const EditServiceScreen(),
  ),
  GetPage(
    name: AppRoutes.successEditServiceScreen,
    page: () => const SuccessEditServiceScreen(),
  ),
  GetPage(
    name: AppRoutes.tableScreen,
    transition: Transition.rightToLeft,
    page: () => const TableScreen(),
  ),
  GetPage(
    name: AppRoutes.createTableScreen,
    transition: Transition.rightToLeft,
    page: () => const CreateTableScreen(),
  ),
  GetPage(
    name: AppRoutes.renameTableScreen,
    transition: Transition.rightToLeft,
    page: () => const RenameTableScreen(),
  ),
  GetPage(
    name: AppRoutes.foldersTransferScreen,
    transition: Transition.rightToLeft,
    page: () => const FoldersTransferScreen(),
  ),
  GetPage(
    name: AppRoutes.serviceModeInfoScreen,
    transition: Transition.rightToLeft,
    page: () => const ServiceModeInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.invoiceStoreScreen,
    transition: Transition.rightToLeft,
    page: () => const InvoiceStoreScreen(),
  ),
  GetPage(
    name: AppRoutes.invoiceScreen,
    transition: Transition.fadeIn, // Transition.fadeIn,
    page: () => const InvoiceScreen(),
  ),
  GetPage(
    name: AppRoutes.tableInvoicesStoreScreen,
    transition: Transition.fadeIn,
    page: () => const TableInvoicesStoreScreen(),
  ),
  GetPage(
    name: AppRoutes.findInvoiceScreen,
    transition: Transition.fadeIn,
    page: () => const FindInvoiceScreen(),
  ),
  GetPage(
    name: AppRoutes.invoiceSearchScreen,
    transition: Transition.rightToLeft,
    page: () => const InvoiceSearchScreen(),
  ),
  GetPage(
    name: AppRoutes.invoiceEditScreen,
    transition: Transition.rightToLeft,
    page: () => const InvoiceEditScreen(),
  ),
  GetPage(
    name: AppRoutes.autoTransferDataScreen,
    transition: Transition.rightToLeft,
    page: () => const AutoTransferDataScreen(),
  ),
  GetPage(
    name: AppRoutes.accountInfoScreen,
    transition: Transition.rightToLeft,
    page: () => const AccountInfoScreen(),
  ),
];
