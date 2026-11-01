import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum MediaPermissionResult {
  granted,
  denied,
  permanentlyDenied,
}

class MediaService {
  static final MediaService _instance = MediaService._internal();
  factory MediaService() => _instance;

  final ImagePicker _picker;

  MediaService._internal({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  /// Constructor con fines de prueba o inyección de dependencias
  MediaService.withCustomPicker(ImagePicker picker) : _picker = picker;

  /// Solicita y comprueba el permiso de Cámara con control de permisos denegados
  Future<MediaPermissionResult> requestCameraPermission() async {
    if (kIsWeb) return MediaPermissionResult.granted;

    final status = await Permission.camera.status;
    if (status.isGranted || status.isLimited) {
      return MediaPermissionResult.granted;
    }

    final requestStatus = await Permission.camera.request();
    if (requestStatus.isGranted || requestStatus.isLimited) {
      return MediaPermissionResult.granted;
    } else if (requestStatus.isPermanentlyDenied) {
      return MediaPermissionResult.permanentlyDenied;
    }
    return MediaPermissionResult.denied;
  }

  /// Solicita y comprueba el permiso de Galería / Almacenamiento multimedia
  Future<MediaPermissionResult> requestGalleryPermission() async {
    if (kIsWeb) return MediaPermissionResult.granted;

    // En Android 13+ (API 33+) se utiliza photos, en versiones anteriores storage
    Permission permission = Permission.photos;
    var status = await permission.status;

    if (status.isDenied) {
      permission = Permission.storage;
      status = await permission.status;
    }

    if (status.isGranted || status.isLimited) {
      return MediaPermissionResult.granted;
    }

    final requestStatus = await permission.request();
    if (requestStatus.isGranted || requestStatus.isLimited) {
      return MediaPermissionResult.granted;
    } else if (requestStatus.isPermanentlyDenied) {
      return MediaPermissionResult.permanentlyDenied;
    }
    return MediaPermissionResult.denied;
  }

  /// Captura una foto en tiempo real utilizando la cámara nativa
  Future<XFile?> takePhoto({
    double maxWidth = 1200,
    double maxHeight = 1200,
    int imageQuality = 85,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    try {
      return await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
        preferredCameraDevice: preferredCameraDevice,
      );
    } catch (e) {
      debugPrint('Error en captura de cámara: $e');
      return null;
    }
  }

  /// Selecciona una imagen desde la galería nativa del dispositivo
  Future<XFile?> pickImageFromGallery({
    double maxWidth = 1200,
    double maxHeight = 1200,
    int imageQuality = 85,
  }) async {
    try {
      return await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
    } catch (e) {
      debugPrint('Error al seleccionar imagen de la galería: $e');
      return null;
    }
  }

  /// Permite abrir la configuración del sistema si el permiso fue denegado permanentemente
  Future<bool> openSettings() async {
    if (kIsWeb) return false;
    return await openAppSettings();
  }
}

