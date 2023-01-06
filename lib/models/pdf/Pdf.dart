import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Pdf {
  static Future<File> generate({String? projectName , String? year , String? firstStudent , String? secondStudent , String? thirdStudent ,
      String? supervisorName , dynamic supervisorMark , String? presidentName ,  dynamic presidentMark , String? examinerName ,  dynamic examinerMark ,
      dynamic finalMark}) async {
    final pdf = Document();

    var customFont = Font.ttf(await rootBundle.load("fonts/VarelaRound-Regular.ttf"));

    pdf.addPage(MultiPage(
      build: (context) => <Widget> [
        Header(text :'Universite Constantine 2 - Abdelhamid Mehri' , textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            font: customFont,
        ),
          // padding: EdgeInsets.all(5.0),
          // decoration: BoxDecoration(color: PdfColors.blue),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Paragraph(text: 'PV Dissertation' , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold, font: customFont)),
        ),
        SizedBox(
          height: 15.0,
        ),
        Paragraph(text: 'ViVa Detail :' , style: TextStyle(fontSize: 21 , fontWeight: FontWeight.bold, font: customFont , decoration: TextDecoration.underline)),
        SizedBox(
          height: 15.0,
        ),
        Row(
            children: [
              Paragraph(text: 'Project Name : ' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, font: customFont)),
              Paragraph(text: '$projectName' , style: TextStyle(fontSize: 19 , font: customFont)),
            ]
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Paragraph(text: 'Year : ' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, font: customFont)),
            Paragraph(text: '$year' , style: TextStyle(fontSize: 18 , font: customFont)),
          ]
        ),
        SizedBox(
          height: 10.0,
        ),
        Paragraph(text: 'Students : ' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, font: customFont)),
        Paragraph(text: '1- $firstStudent' , style: TextStyle(fontSize: 18 , font: customFont)),
        SizedBox(
          height: 5.0,
        ),
        (secondStudent != '') ? Paragraph(text: '2- $secondStudent' , style: TextStyle(fontSize: 18 , font: customFont)) : Container(),
        SizedBox(
          height: 5.0,
        ),
        (thirdStudent != '') ? Paragraph(text: '3- $thirdStudent' , style: TextStyle(fontSize: 18 , font: customFont)) : Container(),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Composition Of The Jury',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    font: customFont,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Paragraph(text: 'Supervisor Name : ' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold, font: customFont)),
                Paragraph(text: 'President Name : ' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold, font: customFont)),
                Paragraph(text: 'Examiner Name : ' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold, font: customFont)),
              ]
            ),
            Column(
                children: [
                  Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      font: customFont,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Paragraph(text: '$supervisorName' , style: TextStyle(fontSize: 17 , font: customFont)),
                  Paragraph(text: '$presidentName' , style: TextStyle(fontSize: 17 , font: customFont)),
                  Paragraph(text: '$examinerName' , style: TextStyle(fontSize: 17 , font: customFont)),

                ]
            ),
            Column(
                children: [
                  Text(
                    'Mark',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      font: customFont,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Paragraph(text: '$supervisorMark' , style: TextStyle(fontSize: 17 , font: customFont)),
                  Paragraph(text: '$presidentMark' , style: TextStyle(fontSize: 17 , font: customFont)),
                  Paragraph(text: '$examinerMark' , style: TextStyle(fontSize: 17 , font: customFont)),
                ]
            ),
          ]
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //
        //   ]
        // ),
        // SizedBox(
        //   height: 12.0,
        // ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //   ]
        // ),
        // SizedBox(
        //   height: 7.0,
        // ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //     ]
        // ),
        SizedBox(
          height: 7.0,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ]
        ),

        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Paragraph(text: 'Final Mark : ' , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold, font: customFont , decoration: TextDecoration.underline)),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 8.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0,),
                ),
                child: Paragraph(text: '$finalMark' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold, font: customFont )),),
              ]
            ),
      ],
    ));

    return saveDocument(name: 'ViVa_Detail.pdf', pdf: pdf);

  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;


    await OpenFile.open(url);
  }


}