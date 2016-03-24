//
//  UCarBChooseImageViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBChooseImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MWPhotoBrowser.h"
#import <Photos/Photos.h>
#import "SDImageCache.h"
#import "MWCommon.h"
#import <MLSelectPhoto.h>
#import <UIImageView+WebCache.h>

#import "UCarBCarImageCollectionViewCell.h"

static NSString *const reuseCollectionView = @"UCarBCarImageCollectionViewCell";

@interface UCarBChooseImageViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MWPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UICollectionView *collectionViewImage;


@property (nonatomic, strong) NSMutableArray *assets;        //WMPhotoBrower 相册数据库

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) MWPhotoBrowser *browser;
@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;
@property (nonatomic, strong) NSMutableArray *selections;   // 选中状态


@property (nonatomic, assign) NSInteger selectedIndexNumber; // 当前选择第几个
@property (nonatomic, assign) NSInteger selectedCount;       // 选择总数量
@property (nonatomic, strong) NSArray *tempImageArray;
@property (nonatomic, strong) NSMutableArray *tempURLArray;  // 当前页面本次上传的图片网址数组
@property (nonatomic, strong) NSMutableArray *tempsImageArray; // 当前本次选择的图片原图数组

@property (nonatomic, strong) MLSelectPhotoPickerViewController *pickerVc;


@end

@implementation UCarBChooseImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"上传图片";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadImages:)];
    self.selectedCount = self.imageURLArray.count;

        self.pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.selectedCount = self.imageURLArray.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionViewImage];
    [self configLayout];

    self.tempURLArray = [NSMutableArray new];
}


#pragma mark ImagePickShow
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.tempsImageArray = [NSMutableArray new];
    self.tempURLArray = [NSMutableArray new];
    [self.tempsImageArray addObject:image];
        [self saveImageArray];
        [self.collectionViewImage reloadData];
        NSLog(@"算了");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self pushtuNextView];
    } else if (buttonIndex == 0) {
        UIImagePickerController *tempImagePicker = [[UIImagePickerController alloc] init];
        tempImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        tempImagePicker.showsCameraControls  = YES;

        tempImagePicker.delegate = self;
        tempImagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
       
//        tempImagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        //设置相机支持的类型，拍照和录像
        tempImagePicker.mediaTypes = @[(NSString*)kUTTypeImage];
        //设置拍摄时屏幕的view的transform属性，可以实现旋转，缩放功能        [self presentViewController:tempImagePicker animated:YES completion:nil];
        [self presentViewController:tempImagePicker animated:YES completion:nil];
        
    }
}


#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.collectionViewImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(10, 12, 0, 12));
    }];
}

#pragma mark 保存图片上传图片
- (void)saveImageArray
{
    [self performSelector:@selector(upLoadImageself:) withObject:[NSNumber numberWithInteger:0] afterDelay:0];
    [self.collectionViewImage reloadData];
}


- (void)upLoadImageself:(NSNumber *)number
{
    NSInteger currentSecond=(NSInteger)[number integerValue];
    if (currentSecond < _tempsImageArray.count) {
        UIImage *upImage = [_tempsImageArray objectAtIndex:[number integerValue]];
        UploadimgAPI *api = [[UploadimgAPI alloc] initWithImage:upImage withFileName:@".jpg"];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [self performSelector:@selector(upLoadImageself:) withObject:[NSNumber numberWithInteger:currentSecond + 1] afterDelay:0];
            [self.tempURLArray addObject:api.result];
        } failure:^(YTKBaseRequest *request) {
            
        }];
    } else {
        self.imageURLArray = [self.imageURLArray mutableCopy];
        [self.imageURLArray addObjectsFromArray:[_tempURLArray mutableCopy]];
        NSLog(@"%@",self.imageURLArray);
        self.assetsArray = [self.assetsArray mutableCopy];
        [self.assetsArray addObjectsFromArray:[self.tempsImageArray mutableCopy]];
        
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSString *urlString in self.imageURLArray) {
            NSArray *temp = [urlString componentsSeparatedByString:@"/"];
            [tempArray addObject:[temp lastObject]];
        }
        self.imageURLArray = [tempArray mutableCopy];
        self.selectedCount = self.imageURLArray.count;
        [self.collectionViewImage reloadData];
    }
}

#pragma mark 保存数据返回主视图
- (void)upLoadImages:(UIBarButtonItem *)button
{
    self.imageBlock(self.assetsArray, self.imageURLArray);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 删除图片
- (void)deleteImageFormArray:(UIBarButtonItem *)button
{
   
    self.imageURLArray = [self.imageURLArray mutableCopy];
    
    self.assetsArray = [self.assetsArray mutableCopy];
    
    [self.navigationController popViewControllerAnimated:YES];
    self.selectedCount--;
    [self.imageURLArray  removeObjectAtIndex:self.selectedIndexNumber];
    if (self.pageSize != 1) {
    [self.assetsArray removeObjectAtIndex:self.selectedIndexNumber];
    }

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedIndexNumber inSection:0];
    [self. collectionViewImage deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark Collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.imageURLArray.count == 0) {
        return 1;
    }
    else {
        return self.imageURLArray.count + 1;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UCarBCarImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCollectionView forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.item == self.imageURLArray.count) {
        cell.imageCollectionViewCell.image = [UIImage imageNamed:@"photoCameraIcon"];
    } else {
        NSInteger Index = indexPath.item ;
        if (self.pageSize == 1) {
            NSString *urlString = [NSString stringWithFormat:@"%@%@",self.imageSMURL,[self.imageURLArray objectAtIndex:Index]];
            [cell.imageCollectionViewCell sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"PlaceHolderImage"]];
        } else {
            if (self.imageURLArray.count == 0) {
               cell.imageCollectionViewCell.image = [UIImage imageNamed:@"photoCameraIcon"];
            } else {
                NSString *urlString = [NSString stringWithFormat:@"http://123.57.233.174/api/upload/image_sm/%@",[self.imageURLArray objectAtIndex:Index]];
                [cell.imageCollectionViewCell sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"PlaceHolderImage"]];
        }
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_imageURLArray.count  == indexPath.item || self.imageURLArray.count == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
        [actionSheet showInView:self.view];
    } else {
        [self previewImageBrower:indexPath.item];
    }
}



- (UICollectionView *)collectionViewImage
{
    if (_collectionViewImage == nil) {
        UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc] init];
        FlowLayout.itemSize = CGSizeMake((SCREENWIDTH - 34) / 3, (SCREENWIDTH - 34) / 3);
        FlowLayout.minimumInteritemSpacing = 3;
        FlowLayout.minimumLineSpacing = 5;
        UICollectionView *tempCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:FlowLayout];
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.backgroundColor = BACKGROUNDCOLOR;
        [tempCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseCollectionView];
        _collectionViewImage = tempCollectionView;
    }
    return _collectionViewImage;
}

#pragma mark 相册选取
- (void)pushtuNextView
{
    // Push
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(global, ^{
        self.pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
        _pickerVc.status = PickerViewShowStatusGroup;
        _pickerVc.maxCount = 8 - _selectedCount;
        
        weakSelf.tempsImageArray = [NSMutableArray new];
        weakSelf.tempURLArray = [NSMutableArray new];
        
        _pickerVc.selectPickers = nil;
        _pickerVc.callBack = ^(NSArray *assets){
            // CallBack or Delegate
            weakSelf.assetsArray = [weakSelf.assetsArray mutableCopy];
            for (MLSelectPhotoAssets *assetImage in assets) {
                [weakSelf.tempsImageArray addObject:assetImage.originImage];
            }
            [weakSelf saveImageArray];
        };
        
        dispatch_async(mainQueue, ^{
           [_pickerVc showPickerVc:self];
        });
        
    });
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 预览已选图片
- (void)previewImageBrower:(NSInteger)index
{
    self.thumbs = [NSMutableArray new];
    
//    if (self.pageSize == 1) {
        for (NSString *urlString in self.imageURLArray) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.imageURL,urlString]]];
            [self.thumbs addObject:photo];
//        }
//    } else {
//    for (UIImage *image in _assetsArray) {
//        MWPhoto *photo = [MWPhoto photoWithImage:image];
//        [self.thumbs addObject:photo];
//    }
    }
    self.browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _browser.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImageFormArray:)];
    _browser.displayActionButton = NO;
    _browser.displayNavArrows = NO;
    _browser.displaySelectionButtons = NO;
    _browser.alwaysShowControls = NO;
    _browser.zoomPhotosToFill = YES;
    _browser.enableGrid = NO;
    _browser.startOnGrid = NO;
    _browser.enableSwipeToDismiss = YES;
    _browser.autoPlayOnAppear = YES;
    [_browser setCurrentPhotoIndex:index];
    self.selections = [NSMutableArray array];
    for (int i = 0; i < _thumbs.count; i++) {
        [_selections addObject:[NSNumber numberWithBool:NO]];
    }
    [self.navigationController pushViewController:_browser animated:YES];
}

- (NSString *)imageURL
{
    if (_imageURL == nil) {
        NSString *url = @"http://123.57.233.174/api/upload/image";
        _imageURL = url;
    }
    return _imageURL;
}

- (NSMutableArray *)assets
{
    if (_assets == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _assets = tempArray;
    }
    return _assets;
}

- (NSMutableArray *)tempURLArray
{
    if (_tempURLArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _tempURLArray = tempArray;
    }
    return _tempURLArray;
}


- (NSMutableArray *)assetsArray
{
    if (_assetsArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _assetsArray = tempArray;
    }
    return _assetsArray;
}

- (NSMutableArray *)imageURLArray
{
    if (_imageURLArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _imageURLArray = tempArray;
    }
    return _imageURLArray;
}

- (NSMutableArray *)tempsImageArray
{
    if (_tempsImageArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _tempsImageArray = tempArray;
    }
    return _tempsImageArray;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _thumbs.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}


- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    self.selectedIndexNumber = index;
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
