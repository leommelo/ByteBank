import 'package:bytebank_full/database/app_database.dart';
import 'package:bytebank_full/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)';
  static const String _tableName = 'contacts';
  
Future<int> save (Contact contact) async{
  final Database db = await getDataBase();
  final Map<String, dynamic> contactMap = {}; 
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert(_tableName, contactMap);
}

Future<List<Contact>> findAll() async{
  final Database db = await getDataBase();
  final List<Map<String, dynamic>> result = await db.query(_tableName);
  final List<Contact> contacts = [];
  for(Map<String, dynamic>row in result){
    final Contact contact = Contact(row['id'], row['name'], row['account_number']);
    contacts.add(contact);
  }
  return contacts;
}

Future<int> delete (int id) async{
  final Database db = await getDataBase();
  return db.delete('contacts', where: 'id = ?',whereArgs: [id]);
}
}