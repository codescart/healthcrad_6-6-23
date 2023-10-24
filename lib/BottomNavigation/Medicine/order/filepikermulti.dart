import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
class file_picker extends StatefulWidget {
  const file_picker({Key? key}) : super(key: key);

  @override
  State<file_picker> createState() => _file_pickerState();
}

class _file_pickerState extends State<file_picker> {
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios_outlined),),
          title: const Text("File picker demo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(result != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected file:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Text(result?.files[index].name ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                        })
                  ],
                ),),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  result = await FilePicker.platform.pickFiles(allowMultiple: true );
                  // FilePickerResult? result = await FilePicker.platform.pickFiles(
                  //   type: FileType.custom,
                  //   allowedExtensions: ['jpg', 'pdf', 'doc'],
                  // );
                  if (result == null) {

                  } else {
                    setState(() {
                    });
                    result?.files.forEach((element) {

                    });
                  }
                },
                child: const Text("File Picker"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
