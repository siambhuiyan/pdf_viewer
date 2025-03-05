// import 'dart:io';
// import 'package:external_path/external_path.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf_viewer/pdf_view_screen.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as path;
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> _pdfFiles = [];
//   List<String> _filteredFiles = [];
//   bool isSearching = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     baseDirectory();
//   }
//
//   Future<void> baseDirectory() async {
//     PermissionStatus permissionStatus =
//         await Permission.manageExternalStorage.request();
//     if (permissionStatus.isGranted) {
//       var rootDirectory = await ExternalPath.getExternalStorageDirectories();
//       await getFiles(rootDirectory!.first);
//     }
//   }
//
//   Future<void> getFiles(String diretoryPath) async {
//     try {
//       var rootDirectory = Directory(diretoryPath);
//       var directories = rootDirectory.list(recursive: false);
//       await for (var element in directories) {
//         if (element is File) {
//           if (element.path.endsWith('.pdf')) {
//             setState(() {
//               _pdfFiles.add(element.path);
//               _filteredFiles = _pdfFiles;
//             });
//           }
//         } else {
//           await getFiles(element.path);
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
//
//   void _filterFiles(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _filteredFiles = _pdfFiles;
//       });
//     } else {
//       setState(() {
//         _filteredFiles = _pdfFiles
//             .where((file) => file
//                 .split('/')
//                 .last
//                 .toLowerCase()
//                 .contains(query.toLowerCase()))
//             .toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       appBar: AppBar(
//         title: !isSearching
//             ? Text(
//                 'PDF Viewer',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             : TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search PDFS...",
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   _filterFiles(value);
//                 },
//               ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             iconSize: 30,
//             onPressed: () {
//               setState(() {
//                 isSearching = !isSearching;
//                 _filteredFiles = _pdfFiles;
//               });
//             },
//             icon: Icon(isSearching ? Icons.cancel : Icons.search),
//           ),
//         ],
//       ),
//       body: _filteredFiles.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: _filteredFiles.length,
//               itemBuilder: (context, index) {
//                 String filePath = _filteredFiles[index];
//                 String fileName = path.basename(filePath);
//                 return Card(
//                   color: Colors.white,
//                   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     title: Text(
//                       fileName,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     leading: Icon(
//                       Icons.picture_as_pdf,
//                       color: Colors.redAccent,
//                       size: 30,
//                     ),
//                     trailing: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 18,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PdfViewScreen(
//                             pdfName: fileName,
//                             pdfPath: filePath,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // to refresh list of pdf
//           baseDirectory();
//         },
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
//

import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer/pdf_view_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _pdfFiles = [];
  List<String> _filteredFiles = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    baseDirectory();
  }

  Future<void> baseDirectory() async {
    PermissionStatus permissionStatus =
    await Permission.manageExternalStorage.request();
    if (permissionStatus.isGranted) {
      var rootDirectory = await ExternalPath.getExternalStorageDirectories();
      await getFiles(rootDirectory!.first);
    }
  }

  Future<void> getFiles(String diretoryPath) async {
    try {
      var rootDirectory = Directory(diretoryPath);
      var directories = rootDirectory.list(recursive: false);
      await for (var element in directories) {
        if (element is File) {
          if (element.path.endsWith('.pdf')) {
            setState(() {
              _pdfFiles.add(element.path);
              _filteredFiles = _pdfFiles;
            });
          }
        } else {
          await getFiles(element.path);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _filterFiles(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredFiles = _pdfFiles;
      });
    } else {
      setState(() {
        _filteredFiles = _pdfFiles
            .where((file) => file
            .split('/')
            .last
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent AppBar
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PDF Viewer",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF Pro Display',
                    color: Colors.black,
                  ),
                ),
                if (isSearching)
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search PDFs...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _filterFiles(value);
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  _filteredFiles = _pdfFiles;
                });
              },
              iconSize: 30,
            ),
          ],
        ),
      ),
      body: _filteredFiles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _filteredFiles.length,
        itemBuilder: (context, index) {
          String filePath = _filteredFiles[index];
          String fileName = path.basename(filePath);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewScreen(
                    pdfName: fileName,
                    pdfPath: filePath,
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                title: Text(
                  fileName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF Pro Display',
                    color: Colors.black,
                  ),
                ),
                leading: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                  size: 32,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          baseDirectory();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
