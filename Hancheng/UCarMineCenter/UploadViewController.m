//
//  UploadViewController.m
//  Hancheng
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UploadViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UploadimgAPI.h"
#import <Photos/Photos.h>
#import <MWPhotoBrowser.h>
#import "C_58_infoModel.h"
#import <UIImageView+WebCache.h>
@interface UploadViewController ()<UINavigationBarDelegate, MWPhotoBrowserDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSString *imgReturn;
}
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UILabel *upLoadTipString;


@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;


@end


@implementation UploadViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadAssets];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
}


- (IBAction)chooseAction:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"重新上传"] || [sender.titleLabel.text isEqualToString:@"上传并预览"]) {
        UIActionSheet *AlertSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
        [AlertSheet showInView:self.view];
        
    } else if ([sender.titleLabel.text isEqualToString:@"提交"]) {
        if (imgReturn.length != 0) {
            PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"photo": imgReturn} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
            [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                NSLog(@"-%@-", request.responseBody);
                if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
                    UIAlertView *alt= [[UIAlertView alloc] initWithTitle:@"" message:@"上传成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alt show];
                }
            } failure:^(YTKBaseRequest *request) {

            }];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)chooseImagePicker
{
    UIImagePickerController *tempImagePicker = [[UIImagePickerController alloc] init];
    tempImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    tempImagePicker.showsCameraControls  = YES;
    tempImagePicker.delegate = self;
    tempImagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    tempImagePicker.mediaTypes = @[(NSString*)kUTTypeImage];
    [self presentViewController:tempImagePicker animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self chooseImagePicker];
    } else if (buttonIndex == 1) {
        [self choosePhoto];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UploadimgAPI *API = [[UploadimgAPI alloc] initWithImage:image withFileName:@".png"];
    _introduceLabel.text = @"";
    [_chooseButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setTitle:@"重新上传" forState:UIControlStateNormal];
    _commitButton.layer.cornerRadius = 15;
    _commitButton.layer.borderWidth = 1;
    _commitButton.layer.borderColor = RGB(255, 80, 0).CGColor;
    [_commitButton setTitleColor:RGB(255, 80, 0) forState:UIControlStateNormal];
    _commitButton.backgroundColor = [UIColor whiteColor];
    [_commitButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"-%@-", request.responseBody);
        imgReturn = request.responseBody[@"data"][@"imgs"];
        self.img.image = image;
        
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"错误%@", request);
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)choosePhoto
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    @synchronized(_assets) {
        NSMutableArray *copy = [_assets copy];
        if (NSClassFromString(@"PHAsset")) {
            // Photos library
            UIScreen *screen = [UIScreen mainScreen];
            CGFloat scale = screen.scale;
            // Sizing is very rough... more thought required in a real implementation
            CGFloat imageSize = MAX(screen.bounds.size.width, screen.bounds.size.height) * 1.5;
            CGSize imageTargetSize = CGSizeMake(imageSize * scale, imageSize * scale);
            CGSize thumbTargetSize = CGSizeMake(imageSize / 3.0 * scale, imageSize / 3.0 * scale);
            for (PHAsset *asset in copy) {
                [photos addObject:[MWPhoto photoWithAsset:asset targetSize:imageTargetSize]];
                [thumbs addObject:[MWPhoto photoWithAsset:asset targetSize:thumbTargetSize]];
            }
        } else {
            // Assets library
            for (ALAsset *asset in copy) {
                MWPhoto *photo = [MWPhoto photoWithURL:asset.defaultRepresentation.url];
                [photos addObject:photo];
                MWPhoto *thumb = [MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]];
                [thumbs addObject:thumb];
                if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
                    photo.videoURL = asset.defaultRepresentation.url;
                    thumb.isVideo = true;
                }
            }
        }
    }
    
    self.photos = photos;
    self.thumbs = thumbs;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = YES;
    browser.enableSwipeToDismiss = NO;
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    [self.navigationController pushViewController:browser animated:YES];
    

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {

    [photoBrowser.navigationController popViewControllerAnimated:YES];
    MWPhoto * photo = [_thumbs objectAtIndex:index];
    NSLog(@"ACTION! %@", [photo underlyingImage]);
    UIImage *tempImage =[photo underlyingImage];
    _introduceLabel.text = @"";
    [_chooseButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setTitle:@"重新上传" forState:UIControlStateNormal];
    _commitButton.layer.cornerRadius = 15;
    _commitButton.layer.borderWidth = 1;
    _commitButton.layer.borderColor = RGB(255, 80, 0).CGColor;
    [_commitButton setTitleColor:RGB(255, 80, 0) forState:UIControlStateNormal];
    _commitButton.backgroundColor = [UIColor whiteColor];
    [_commitButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UploadimgAPI *API = [[UploadimgAPI alloc] initWithImage:tempImage withFileName:@".png"];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"-%@-", request.responseBody);
        self.img.image = tempImage;
        
        
        imgReturn = request.responseBody[@"data"][@"imgs"];
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"错误%@", request);
    }];

}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}


- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.photoURL.length > 40) {
        [_chooseButton setTitle:@"重新上传" forState:UIControlStateNormal];
    }
    self.view.backgroundColor = BACKGROUNDCOLOR;
    // Do any additional setup after loading the view from its nib.
  
    UCARNSUSERDEFULTS(userDefaults)
    NSString *role_id = [userDefaults objectForKey:UCARROLE_ID];
    if ([role_id isEqualToString:@"1"] || [role_id isEqualToString:@"3"]) {
        self.title = @"身份认证";
        self.img.image = [UIImage imageNamed:@"uck_pcenter_pat_example_id_card"];
        self.upLoadTipString.text = @"上传本人手持身份证照片";
        if (self.photoURL.length > 5) {
            [self.img sd_setImageWithURL:[NSURL URLWithString:self.photoURL] placeholderImage:[UIImage imageNamed:@"uck_pcenter_pat_example_id_card"]];
        }
    } else {
        self.title = @"企业认证";
        self.img.image = [UIImage imageNamed:@"uck_pcenter_pat_example_business_identification"];
        self.upLoadTipString.text = @"上传企业营业执照照片";
        if (self.photoURL.length > 5) {
            [self.img sd_setImageWithURL:[NSURL URLWithString:self.photoURL] placeholderImage:[UIImage imageNamed:@"uck_pcenter_pat_example_business_identification"]];
        }
    }
    
}



#pragma mark - Load Assets

- (void)loadAssets {
    if (NSClassFromString(@"PHAsset")) {
        
        // Check library permissions
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self performLoadAssets];
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self performLoadAssets];
        }
        
    } else {
        
        // Assets library
        [self performLoadAssets];
        
    }
}

- (void)performLoadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    
    // Load
    if (NSClassFromString(@"PHAsset")) {
        
        // Photos library iOS >= 8
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHFetchOptions *options = [PHFetchOptions new];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [_assets addObject:obj];
            }];
            if (fetchResults.count > 0) {
            }
        });
        
    } else {
        
        // Assets Library iOS < 8
        _ALAssetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // Run in the background as it takes a while to get all assets from the library
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
            NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
            
            // Process assets
            void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                    if ([assetType isEqualToString:ALAssetTypePhoto] || [assetType isEqualToString:ALAssetTypeVideo]) {
                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                        NSURL *url = result.defaultRepresentation.url;
                        [_ALAssetsLibrary assetForURL:url
                                          resultBlock:^(ALAsset *asset) {
                                              if (asset) {
                                                  @synchronized(_assets) {
                                                      [_assets addObject:asset];
                                                      if (_assets.count == 1) {
                                                          // Added first asset so reload date
                                                      }
                                                  }
                                              }
                                          }
                                         failureBlock:^(NSError *error){
                                             NSLog(@"operation was not successfull!");
                                         }];
                        
                    }
                }
            };
            
            // Process groups
            void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
                if (group != nil) {
                    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                    [assetGroups addObject:group];
                }
            };
            
            // Process!
            [_ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                            usingBlock:assetGroupEnumerator
                                          failureBlock:^(NSError *error) {
                                              NSLog(@"There is an error");
                                          }];
            
        });
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
