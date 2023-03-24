import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/src/core/consts.dart';
import '/src/core/widgets/common.dart';
import '/src/core/service/service_root.dart';
import '/src/core/repository/repository_root.dart';

class GetQRCodeWidget extends StatefulWidget {
  final void Function(MessageModel qrCode) resultCallback;

  const GetQRCodeWidget({super.key, required this.resultCallback});

  @override
  State<GetQRCodeWidget> createState() => _GetQRCodeWidgetState();
}

class _GetQRCodeWidgetState extends State<GetQRCodeWidget> {
  final _myPeerId = PeerId(
    token: GetIt.I<ServiceRoot>().networkService.myId,
    name: GetIt.I<RepositoryRoot>().settingsRepository.deviceName,
  );
  late Rect _scanWindow;
  var _canPaste = false;
  Timer? _snackBarTimer;

  @override
  void initState() {
    super.initState();
    Clipboard.hasStrings().then(
      (final bool hasStrings) {
        if (_canPaste != hasStrings) setState(() => _canPaste = hasStrings);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    final scanAreaSize = size.width * 0.66;
    _scanWindow = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: scanAreaSize,
      height: scanAreaSize,
    );
  }

  @override
  void dispose() {
    _snackBarTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            scanWindow: _scanWindow,
            onDetect: (final BarcodeCapture captured) {
              if (captured.barcodes.isEmpty) return;
              _processCode(captured.barcodes.first.rawValue!);
            },
          ),
          CustomPaint(painter: _ScannerOverlay(scanWindow: _scanWindow)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              const HeaderBar(
                caption: 'Scan the QR Code',
                closeButton: HeaderBarCloseButton(),
                isTransparent: true,
              ),
              // Body
              if (_canPaste)
                Padding(
                  padding: paddingBottom32,
                  child: ElevatedButton(
                    onPressed: () async {
                      var code =
                          (await Clipboard.getData(Clipboard.kTextPlain))?.text;

                      if (code != null) {
                        code = code.trim();
                        final whiteSpace = code.lastIndexOf('\n');
                        code = whiteSpace == -1
                            ? code
                            : code.substring(whiteSpace).trim();
                        _processCode(code);
                      }
                    },
                    child: Text(
                      'Paste from Clipboard',
                      style: textStylePoppins616,
                    ),
                  ),
                ),
            ],
          ),
        ],
      );

  void _processCode(final String code) {
    SnackBar? errorSnackBar;
    final qrCode = MessageModel.tryFromBase64(code);

    if (qrCode == null) {
      errorSnackBar = buildSnackBar(
        text: 'The Code is not valid!\n'
            'Please, make sure if it was generated by Keyper',
        isError: true,
      );
    } else if (qrCode.peerId == _myPeerId) {
      errorSnackBar = buildSnackBar(
        text: qrCode.code == MessageCode.takeGroup
            ? 'Transferring ownership to a guardian device is not supported yet.'
            : 'This operation is not supported yet.',
        isError: true,
      );
    }

    if (errorSnackBar == null) {
      widget.resultCallback(qrCode!);
    } else {
      // Debounce
      if (_snackBarTimer?.isActive ?? false) return;
      _snackBarTimer = Timer(snackBarDuration, () {});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }
}

class _ScannerOverlay extends CustomPainter {
  final Rect scanWindow;

  const _ScannerOverlay({required this.scanWindow});

  @override
  bool shouldRepaint(covariant final CustomPainter _) => false;

  @override
  void paint(final Canvas canvas, final Size size) => canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.largest),
          Path()..addRect(scanWindow),
        ),
        Paint()
          ..color = clIndigo900.withOpacity(0.5)
          ..style = PaintingStyle.fill
          ..blendMode = BlendMode.dstOut,
      );
}
