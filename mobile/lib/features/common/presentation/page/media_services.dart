import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';





class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];
    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: requestType);
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }

  Future loadAssets(AssetPathEntity assetPathEntity) async {
    List<AssetEntity> assetList = await assetPathEntity.getAssetListRange(
      start: 0,
      end: await assetPathEntity.assetCountAsync,
    );
    return assetList;
  }
}
