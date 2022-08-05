import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  static String routeName ='/qr-scanner';

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {

  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? _qrController;

  @override
  void dispose(){
    _qrController?.dispose();
    super.dispose();
  }

  @override
  void reassemble()async{
    super.reassemble();

    if (Platform.isAndroid){
      await _qrController!.pauseCamera();
    }
    _qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 20, child: buildResult(),),
          ],
        ),
      ),
    );
  }

    Widget buildResult()=> Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white24,
      ),
      child: Text(
        barcode != null ? 'Result: ${barcode!.code}': 'Scan a QR code',
        maxLines: 3,
      ),
    );
    Widget buildQrView(BuildContext context)=> QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.greenAccent,
        borderWidth: 10,
        borderLength: 20,
        borderRadius: 10,
        cutOutSize: MediaQuery.of(context).size.width *0.8
      ),

    );

    void onQRViewCreated(QRViewController _qrController) {
      setState(() {
        this._qrController = _qrController;
      });
      _qrController.scannedDataStream.listen((barcode) => setState(() {
        this.barcode = barcode;
      })
      );

    }
}
