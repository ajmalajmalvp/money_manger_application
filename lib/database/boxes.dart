import 'package:flutter_money_mangement_application/Model/transaction.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Transaction> getTransactionsBox() =>
      Hive.box<Transaction>('transactions');
  static Box getStorageBox() => Hive.box('storage');
}
