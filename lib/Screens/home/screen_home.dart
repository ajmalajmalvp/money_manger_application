import 'package:flutter/material.dart';
import 'package:flutter_money_mangement_application/Model/transaction.dart';
import 'package:flutter_money_mangement_application/Screens/transaction/add_transaction.dart';
import 'package:flutter_money_mangement_application/Screens/transaction/screen_transaction.dart';
import 'package:flutter_money_mangement_application/Widgets/filter_bar.dart';
import 'package:flutter_money_mangement_application/Widgets/menu_widget.dart';
import 'package:flutter_money_mangement_application/Widgets/search_transaction.dart';
import 'package:flutter_money_mangement_application/Widgets/tile_transactiio.dart';
import 'package:flutter_money_mangement_application/constents/app_theme.dart';
import 'package:flutter_money_mangement_application/controller/category_controller.dart';

import 'package:flutter_money_mangement_application/controller/monthly_chart_controler.dart';
import 'package:flutter_money_mangement_application/controller/transactio_controller.dart';
import 'package:flutter_money_mangement_application/controller/yearly_chart_controller.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../widgets/empty_view.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final transactionController = Get.put(TransactionController());
  final cateoryController = Get.put(CategoryController());
  final chartController = Get.put(MonthlyChartContollrt());
  final ychartController = Get.put(YearlyChartContoller());
  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  final textColor = const Color(0xff324149);
  @override
  void initState() {
    super.initState();
    // _mainController.mainFunction();
  }

  @override
  void dispose() {
    transactionController.clearFilter();
    super.dispose();
  }

  @override
  Widget build(BuildContext mContext) {
    return // _mainController.getValuebool== true ? lockScreen()!:
        Scaffold(
          
      key: _scaffoldKey,
      appBar: AppBar(

        backgroundColor: AppTheme.appbarColor,
        leading: const MenuWidget(),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: TransactionSearchDelegate());
            },
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.mainColors,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddTransaction();
              },
            ),
          );
        },
        tooltip: 'New Transaction',
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<TransactionController>(builder: (controller) {
        calculateBalances(controller.filterdList);
        return ListView(children: [
          const FilterBarv(),
          const SizedBox(height: 25),
          _buildBalanceWidget(textColor),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TransactionsScreen()));
                  },
                  child: const Text(
                    'See all',
                    style: AppTheme.blackColorTextStyle,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: controller.filterdList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: const EmptyView(
                        icon: Icons.receipt_long,
                        label: 'No Transactions Found'),
                  )
                : SlidableAutoCloseBehavior(
                    closeWhenOpened: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filterdList.length < 5
                            ? controller.filterdList.length
                            : 5,
                        itemBuilder: (context, index) {
                          Transaction currItem = controller.filterdList[index];
                          return TransactionTile(
                              transaction: currItem,
                              transactionController: transactionController);
                        }),
                  ),
          ),
        ]);
      }),
    );
  }

  Container _buildBalanceWidget(Color textColor) {
    return Container(
      width: double.infinity,
      height: 165,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: AppTheme.blueColors,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color.fromARGB(65, 0, 0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                        color: AppTheme.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\u{20B9} $totalBalance',
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.1,
                          0.8,
                          0.95
                        ],
                        colors: [
                          Color(0x0027FF2E),
                          Color(0x3227FF2E),
                          Color(0x8827FF2E)
                        ]),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.arrow_upward,
                            color: AppTheme.blackColor,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Income',
                            style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\u{20B9} $totalIncome',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.1,
                          .8,
                          .95
                        ],
                        colors: [
                          Color(0x00FF6969),
                          Color(0x32FF6969),
                          Color(0x88FF6969)
                        ]),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.arrow_downward,
                            color: AppTheme.blackColor,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Expense',
                            style: TextStyle(
                              color: AppTheme.blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\u{20B9} $totalExpense',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  calculateBalances(List<Transaction> tarnsactions) {
    totalBalance = 0;
    totalExpense = 0;
    totalIncome = 0;
    for (Transaction transaction in tarnsactions) {
      if (transaction.type == TransactionType.income) {
        totalBalance += transaction.amount;
        totalIncome += transaction.amount;
      } else {
        totalBalance -= transaction.amount;
        totalExpense += transaction.amount;
      }
    }
  }
}
