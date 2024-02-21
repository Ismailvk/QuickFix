import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // User table
  static const dbName = 'users.db';
  static const dbVersion = 1;
  static const userTable = 'userTable';
  static const usercoloumId = 'id';
  static const coloumName = 'name';
  static const coloumEmail = 'email';
  static const coloumPassword = 'password';
  static const coloumIsloggin = 'islogin';
  static const coloumStockamount = 'stockAmount';
  static const coloumImage = 'userImage';

  //Details table
  static const detailsTable = 'detailsTable';
  static const detailscoloumId = 'id';
  static const coloumuserId = 'userId';
  static const coloumDeviceName = 'deviceName';
  static const coloumModelName = 'modelName';
  static const coloumServiceRequired = 'serviceRequired';
  static const coloumDeviceCondition = 'deviceCondition';
  static const coloumCustomerName = 'customerName';
  static const coloumPhoneNumber = 'phoneNumber';
  static const coloumSequrityCode = 'sequrityCode';
  static const coloumAmount = 'amount';
  static const coloumDeliveryDate = 'deliveryDate';
  static const coloumDeviceImage = 'deviceImage';
  static const coloumStatus = 'deviceStatus';
  static const coloumSpareAmount = 'spareAmount';
  static const coloumServiceAmount = 'serviceAmount';
  static const coloumComment = 'comment';
  static const coloumDate = 'date';
  static const coloumRevenue = 'revenue';
  static const coloumProfit = 'profit';
  static const coloumChoiceChips = 'choiceChips';

  static final DatabaseHelper instance = DatabaseHelper();
  static Database? _database;
  late bool isAvailable;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $userTable(
       $usercoloumId INTEGER PRIMARY KEY,
       $coloumName TEXT NOT NULL,
       $coloumEmail TEXT NOT NULL,
       $coloumPassword TEXT NOT NULL,
       $coloumIsloggin INTEGER,
       $coloumImage TEXT,
       $coloumStockamount INTEGER
  
    )
    ''');
    await db.execute('''
      CREATE TABLE $detailsTable(
        $detailscoloumId INTEGER PRIMARY KEY,
        $coloumDeviceName TEXT NOT NULL,
        $coloumModelName TEXT NOT NULL,
        $coloumServiceRequired TEXT NOT NULL,
        $coloumDeviceCondition TEXT NOT NULL,
        $coloumCustomerName TEXT NOT NULL,
        $coloumPhoneNumber TEXT NOT NULL,
        $coloumSequrityCode TEXT NOT NULL,
        $coloumAmount TEXT NOT NULL,
        $coloumDeliveryDate TEXT NOT NULL,
        $coloumDeviceImage TEXT NOT NULL,
        $coloumStatus TEXT,
        $coloumuserId INTEGER,
        $coloumSpareAmount INTEGER,
        $coloumServiceAmount INTEGER,
        $coloumComment TEXT,
        $coloumDate TEXT,
        $coloumRevenue INTEGER,
        $coloumProfit INTEGER,
        $coloumChoiceChips TEXT
    )
    ''');
  }

  //user table ===================================  \\

  insertUserRecord(Map<String, dynamic> row) async {
    print(row);
    Database? db = await instance.database;
    return await db!.insert(userTable, row);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database? db = await instance.database;
    return await db!.query(userTable);
  }

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> users = await db!.query(
      userTable,
      where: '$coloumEmail = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (users.isNotEmpty) {
      return users.first;
    } else {
      return {};
    }
  }

  logoutupdation(int id) async {
    Database? db = await DatabaseHelper.instance.database;
    db!.update(userTable, {'$usercoloumId': 0}, where: 'id=?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> getuserlogged() async {
    Database? db = await instance.database;
    final userlist =
        await db!.query(userTable, where: '$coloumIsloggin=1', limit: 1);
    if (userlist.length == 0) {
      return null;
    }
    final loggeduser = userlist.first;
    return loggeduser;
  }

  Future userupdate(
      {required data,
      required String columnFiled,
      required int updatevalue}) async {
    Database? db = await instance.database;
    await db!.update(userTable, {coloumIsloggin: updatevalue},
        where: '$columnFiled=?', whereArgs: [data]);
  }

  // when user update his stock amount
  Future<void> stockupdate(
      {required int id, required int controllerValue}) async {
    Database? db = await instance.database;
    await db!.update(userTable, {coloumStockamount: controllerValue},
        where: '$usercoloumId=?', whereArgs: [id]);
  }

  // when add spare amount then decrease stock amount
  decreseStockAmount({required int id, required int updatedStockamount}) async {
    await _database!.update(userTable, {coloumStockamount: updatedStockamount},
        where: '$usercoloumId=?', whereArgs: [id]);
  }

  Future<int> getStockAmount(int userId) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(userTable,
        columns: [coloumStockamount],
        where: '$usercoloumId = ?',
        whereArgs: [userId]);
    if (result.isNotEmpty) {
      final stockmap = result[0][coloumStockamount];
      int stock = stockmap ?? 0;
      return stock;
    } else {
      return 0; // Return 0 if the stock amount is not found
    }
  }

  Future<bool> isuserlogin() async {
    Database? db = await instance.database;
    final userlist = await db!.query(userTable, where: '$coloumIsloggin=1');
    return userlist.isNotEmpty;
  }

  isemailAvailableValidating(String emailid) async {
    Database? db = await instance.database;
    final emailList = await db!
        .query(userTable, where: '$coloumEmail=?', whereArgs: [emailid]);
    isAvailable = emailList.isNotEmpty;
  }

  isemailavailable() {
    return isAvailable;
  }

  // users own database
  Future<Map<String, dynamic>> eachUserDatabase() async {
    Database? db = await instance.database;
    final userowndatabse =
        await db!.query(userTable, where: '$coloumIsloggin=1');
    return userowndatabse.first;
  }

  static Future<Map<String, dynamic>> getUserData() async {
    // Fetch and return initial user data from the database
    final List<Map<String, dynamic>> results = await _database!.query('users');
    if (results.isNotEmpty) {
      return results.first;
    }
    return {}; // Return an empty map if no user data found
  }

  //update user details (email,username,image)

  updateUserdetails(Map<String, dynamic> userData, int userId) async {
    final db = await instance.database;
    db!.update(
        userTable,
        {
          'name': userData[DatabaseHelper.coloumName],
          'email': userData[DatabaseHelper.coloumEmail],
          'userImage': userData[DatabaseHelper.coloumImage]
        },
        where: '$usercoloumId=?',
        whereArgs: [userId]);
  }

  //====================== details table ========================\\
  //                                                              \\
  //                                                               \\
  //////////---------------------------------------------\\\\\\\\\\\\\

  insertDetailsRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(detailsTable, row);
  }

  Future<List<Map<String, dynamic>>> getAllDetails() async {
    Database? db = await instance.database;
    return await db!.query(detailsTable);
  }

  // to get the value of add screen
  Future<List<Map<String, dynamic>>> getinputdetails(int userId) async {
    Database? db = await instance.database;
    final userdetails = await db!
        .query(detailsTable, where: '$coloumuserId=?', whereArgs: [userId]);
    return userdetails;
  }

  // update status in database
  Future<void> updateSelectedValue(int userId, String status) async {
    Database? db = await instance.database;
    await db!.update(
      detailsTable,
      {coloumStatus: status},
      where: '$detailscoloumId=?',
      whereArgs: [userId],
    );
  }

  //get status details
  Future<List<Map<String, dynamic>>> getinputStatusDetaills(
      int customerId) async {
    Database? db = await instance.database;
    final status = db!.query(detailsTable,
        where: '$detailscoloumId = ?', whereArgs: [customerId]);
    return status;
  }

  // sort according by status details
  Future<List<Map<String, dynamic>>> sortbyStatus(
      int userid, String statusDetails) async {
    Database? db = await instance.database;
    final listbySorting = await db!.query(detailsTable,
        where: '$coloumuserId=? AND $coloumStatus=?',
        whereArgs: [userid, statusDetails]);
    return listbySorting;
  }

  // Get status based on user ID
  Future<String?> getStatus(userId) async {
    Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
      detailsTable,
      columns: [coloumStatus],
      where: '$coloumuserId=?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return maps.first[coloumStatus] as String;
    }

    return null;
  }

  // get device image
  Future<List<File>?> getDeviceImages(userId) async {
    final db = await database;
    final List<Map<String, dynamic>> images = await db!.query(
      detailsTable,
      columns: [coloumDeviceImage],
      where: '$coloumuserId=?',
      whereArgs: [userId],
    );
    if (images.isNotEmpty) {
      final imagelist = images.map((img) => File(img['deviceImage'])).toList();
      return imagelist;
    }
    return null;
  }

  // update spare amount in details page
  Future<void> updateSpareAmount(int userId, int spareAmount) async {
    final db = await instance.database;
    await db!.update(detailsTable, {coloumSpareAmount: spareAmount},
        where: '$detailscoloumId=?', whereArgs: [userId]);
  }

  // update service amount in details page
  Future<void> updateServiceAmount(int userId, int serviceAmount) async {
    final db = await instance.database;
    await db!.update(detailsTable, {coloumServiceAmount: serviceAmount},
        where: '$detailscoloumId=?', whereArgs: [userId]);
  }

  // update comment in details page
  Future<void> updateComment(int userId, String comment) async {
    final db = await instance.database;
    await db!.update(detailsTable, {coloumComment: comment},
        where: '$detailscoloumId=?', whereArgs: [userId]);
  }

  //get revenue and profit
  Future<Map<String, dynamic>> getUserRevenueAndProfit(int userId) async {
    final db = await database;

    final result = await db!.query(
      detailsTable,
      columns: [coloumRevenue, coloumProfit],
      where: '$detailscoloumId=?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result[0];
    }

    return {};
  }

  // update revenue amount
  Future<void> updateRevenueamount(
      int custommerId, int updatedRevenueamount) async {
    final db = await instance.database;
    await db!.update(detailsTable, {coloumRevenue: updatedRevenueamount},
        where: '$detailscoloumId=?', whereArgs: [custommerId]);
  }

  // update profit amount
  Future<void> updateprofit(int userId, int updatedprofit) async {
    final db = await instance.database;
    await db!.update(detailsTable, {coloumProfit: updatedprofit},
        where: '$detailscoloumId=?', whereArgs: [userId]);
  }

  // This month revenue and profit
  Future<Map<String, int>> getRevenueAndProfit(
      {required userId, required currentDate, required startDate}) async {
    Database? db = await instance.database;
    final revenueAndProfit = await db!.query(detailsTable,
        where: '$coloumuserId = ? AND $coloumDate >= ? AND $coloumDate <= ?',
        whereArgs: [userId, startDate, currentDate]);
    final List<int> profit = revenueAndProfit
        .map((details) =>
            (details['profit'] as int?) ?? 0) // Use null-aware operator
        .toList();
    final List<int> revenue = revenueAndProfit
        .map((details) =>
            (details['revenue'] as int?) ?? 0) // Use null-aware operator
        .toList();

    int totalProfitAmount = 0;
    for (int i = 0; i < profit.length; i++) {
      totalProfitAmount += profit[i];
    }
    int totalRevenueAmount = 0;
    for (int i = 0; i < revenue.length; i++) {
      totalRevenueAmount += revenue[i];
    }
    Map<String, int> map = {
      'profitAmount': totalProfitAmount,
      'revenueAmount': totalRevenueAmount,
    };

    return map;
  }

  //custom revenue
  Future<Map<String, int>> getCustomRevenueAndProfit(
      {required userId, required currentDate, required startDate}) async {
    Database? db = await instance.database;
    final revenueAndProfit = await db!.query(detailsTable,
        where: '$coloumuserId = ? AND $coloumDate >= ? AND $coloumDate <= ?',
        whereArgs: [userId, currentDate, startDate]);
    final List<int> profit =
        revenueAndProfit.map((details) => details['profit'] as int).toList();
    final List<int> revenue =
        revenueAndProfit.map((details) => details['revenue'] as int).toList();

    int totalProfitAmount = 0;
    for (int i = 0; i < profit.length; i++) {
      totalProfitAmount += profit[i];
    }
    int totalRevenueAmount = 0;
    for (int i = 0; i < revenue.length; i++) {
      totalRevenueAmount += revenue[i];
    }
    Map<String, int> map = {
      'profitAmount': totalProfitAmount,
      'revenueAmount': totalRevenueAmount,
    };

    return map;
  }

  // today profit and revenue
  Future<Map<String, int>> getRevenueAndProfitForToday(
      int userId, DateTime currentDate) async {
    final date = DateFormat('yyyy/MM/dd').format(currentDate);
    Database? db = await instance.database;
    final revenueAndProfit = await db!.query(detailsTable,
        where: '$coloumuserId = ? AND $coloumDate >= ?',
        whereArgs: [userId, date]);

    final List<int> profit = revenueAndProfit
        .map((details) =>
            (details['profit'] as int?) ?? 0) // Use null-aware operator
        .toList();
    final List<int> revenue = revenueAndProfit
        .map((details) =>
            (details['revenue'] as int?) ?? 0) // Use null-aware operator
        .toList();

    int totalProfitAmount = 0;
    for (int i = 0; i < profit.length; i++) {
      totalProfitAmount += profit[i];
    }
    int totalRevenueAmount = 0;
    for (int i = 0; i < revenue.length; i++) {
      totalRevenueAmount += revenue[i];
    }

    Map<String, int> map = {
      'profitAmount': totalProfitAmount,
      'revenueAmount': totalRevenueAmount,
    };

    return map;
  }

  Future<void> UpdateChoiceChipsValues(
      {required int id, required selectedCounts}) async {
    Database? db = await instance.database;
    await db!.update(detailsTable, {coloumChoiceChips: selectedCounts},
        where: '$detailscoloumId = ?', whereArgs: [id]);
  }

  Future<String?> getColumnChoiceChipsValue(int id) async {
    Database? db = await instance.database;

    List<Map<String, dynamic>> result = await db!.query(
      detailsTable,
      columns: [coloumChoiceChips],
      where: '$detailscoloumId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      String? choiceChipsValue = result[0][coloumChoiceChips];
      return choiceChipsValue;
    } else {
      return null; // Row not found
    }
  }

  Future<int> getSpareAmount(int userId) async {
    Database? db = await instance.database;
    final result = await db?.query(
      detailsTable,
      columns: [coloumSpareAmount],
      where: '$detailscoloumId = ?',
      whereArgs: [userId],
    );
    if (result != null && result[0][coloumSpareAmount] != null) {
      return result[0][coloumSpareAmount] as int;
    } else {
      return 0;
    }
  }

  Future<int> getServiceAmount(int userId) async {
    Database? db = await instance.database;
    final result = await db?.query(
      detailsTable,
      columns: [coloumServiceAmount],
      where: '$detailscoloumId = ?',
      whereArgs: [userId],
    );
    if (result != null && result[0][coloumServiceAmount] != null) {
      return result[0][coloumServiceAmount] as int;
    } else {
      return 0;
    }
  }
}
