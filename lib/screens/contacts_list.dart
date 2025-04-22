
import 'package:bytebank_full/database/dao/contact_dao.dart';
import 'package:bytebank_full/models/Contact.dart';
import 'package:bytebank_full/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    var scaffold2 = Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body:FutureBuilder(
        future:  _dao.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Contact>? contacts = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts![index];
                return _ContactItem(
                  contact,
                  onDelete:() async {
                    await _dao.delete(contact.id);
                    setState(() {});
                  }
                  );
              },
              itemCount: contacts?.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ContactForm(),))
          .then((_){
            setState(() {});
          });          
        },
      ),
    );
    var scaffold = scaffold2;
    return scaffold;
  }
}

class _ContactItem extends StatelessWidget {

  final Contact contact;
  final void Function() onDelete;

  _ContactItem(this.contact, {required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
              title: Text(
                contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              subtitle: Text(
                contact.accountNumber.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: onDelete,
              ),
            ),
          );
  }
}