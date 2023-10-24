import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:healthcrad_user/ambulance/msgtxt.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf_viewer_and_downloader_example/pdf_viewer_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class myreport extends StatefulWidget {

  const myreport({Key? key}) : super(key: key);

  @override
  State<myreport> createState() => _myreportState();
}
var click;
// Future<File> loadPdfFromNetwork(String url) async {
//   final response = await http.get(Uri.parse(url));
//   final bytes = response.bodyBytes;
//   return _storeFile(url, bytes);
// }
//
// Future<File> _storeFile(String url, List<int> bytes) async {
//   final filename = basename(url);
//   final dir = await getApplicationDocumentsDirectory();
//   final file = File('${dir.path}/$filename');
//   await file.writeAsBytes(bytes, flush: true);
//   if (kDebugMode) {
//     print('$file');
//   }
//   return file;
// }
class _myreportState extends State<myreport> {
  var selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black26)
                )
            ),
            padding: EdgeInsets.only(top:5, left: 5, right: 5, bottom: 0),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                             width:70,
                            child: Image.asset("assets/doctor_logo.png")),
                        Container(
                          height: 50,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Color(0xff000000), fontWeight: FontWeight.w700,),),
                              Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Color(0xff000000), fontWeight: FontWeight.bold,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      child:Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                        ],
                      ) ,
                    )
                  ],
                ),
              ],
            )
        ) ,
        // backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50, width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.5)
                    ),
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Reports", style:TextStyle(fontSize: 25, ),),
                    Icon(Icons.arrow_right, size: 50, color: Theme.of(context).primaryColor,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Table(
                border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1),
                children: [
                  TableRow( children: [
                    Column(children:[Container(padding: EdgeInsets.all(12), child: Text('PathLab', style: TextStyle(fontSize: 20.0)))]),
                    Column(children:[Container(padding: EdgeInsets.all(12),child: Text('Date', style: TextStyle(fontSize: 20.0)))]),
                    Column(children:[Container(padding: EdgeInsets.all(12),child: Text('Report', style: TextStyle(fontSize: 20.0)))]),
                  ]),
                ],
              ),
              FutureBuilder<List<doctor>>(
                  future: medicine(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                         return Table(
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1),
                          children: [
                            TableRow(
                                children: [
                              Column(children:[Container(padding: EdgeInsets.all(12),child: Text(snapshot.data![index].lab_name.toString()))]),
                              Column(children:[Container(padding: EdgeInsets.all(12),child: Text(snapshot.data![index].test_date.toString()))]),
                              Column(children:[Container(padding: EdgeInsets.all(5),child: snapshot.data![index].report==null?
                               Container(
                                  padding: EdgeInsets.only(top: 10), child: Text("Wait for report", style: TextStyle(fontSize: 13, color: Colors.black38,),)):
                              TextButton(onPressed: ()async {
                                setState(() {
                                  // selectedIndex=true;
                                  // selectedIndex = snapshot.data![index].id;
                                });
                                     final url ="https://app.healthcrad.com/api/uploads/pathlab_report/"+snapshot.data![index].report.toString();
                                     final file = await loadPdfFromNetwork(url);
                                     openPdf(context, file, url);
                                     FileDownloader.downloadFile(url:url);
                                     },
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>msgtxt()));
                                child: Text("Download", style: TextStyle(color: Theme.of(context).primaryColor),)
                                // Center(child: CircularProgressIndicator(
                                //   color: Theme.of(context).primaryColor,
                                // ),)
                              // : Text("Download", style: TextStyle(color: Theme.of(context).primaryColor),),
                              ))]),
                            ]),
                          ],
                        );
                      },
                    ):Center(child:CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                  }),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    ));
  }
  Future<List<doctor>> medicine() async{
    // final catgId = widget.catid;
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(user_id);
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/show_report?user_id=$user_id'),
    );
    var jsond = json.decode(response.body)["data"];
    print(jsond);
    print("hhhhhhhhhhh");
    List<doctor> allround = [];
    for (var o in jsond)  {
      doctor al = doctor(
        o["id"],
        o["test_date"],
        o["lab_name"],
        o["report"],
      );
      allround.add(al);
    }
    return allround;
  }

  // my all code.....
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    return File(result.paths.first ?? '');
  }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }
  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }


  //final file = File('example.pdf');
  //await file.writeAsBytes(await pdf.save());

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );
}
class doctor {
  String? id;
  String? test_date;
  String? lab_name;
  String? report;
  doctor(
      this.id,
      this.test_date,
      this.lab_name,
      this.report,
      );

}
