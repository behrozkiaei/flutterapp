import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paytel/widgets/utils/enterAmountBottomSheet.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:paytel/style/theme.dart' as Style;
import '../utils/elevateButton.style.dart';
import "./enterCodeBottomSheet.dart" ;
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  String? selectedString;

  @override
  void dispose() {
    print("disposeeeeeed");
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller?.resumeCamera();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||  MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Style.Colors.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
        });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          SizedBox( height:height*0.7 ,child: _buildQrView(context)),
          SizedBox(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30,),
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: 
                        StyledElevatedButton(
                          width: 150,
                          height: 40,
                          icon: Icons.refresh,
                          text:" روشن کردن دوربین",
                          textSize:10 ,
                          textColor: Style.Colors.white,
                          onPressed: () async {
                              await controller?.resumeCamera();
                            },)
                      ),
                      SizedBox(height: height*0.40,),
                      Container(
                                margin: const EdgeInsets.all(10),
                                child:
                              StyledElevatedButton(
                                width: 130,
                                height: 40,
                                text: "پرداخت با کد",
                                icon: Icons.keyboard,
                                textSize: 10,
                                textColor: Style.Colors.white,
                                onPressed: () async {
                                    await controller?.pauseCamera();
                                    // ignore: use_build_context_synchronously
                                    ScannerBottomSheets.show(context,(value){
                                      if(value !=null ){
                                        EnterAmountBottomSheet.show(context, (result) => null, value);
                                      }
                                    });
                                  },
                                )
                      )
                      
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
}
