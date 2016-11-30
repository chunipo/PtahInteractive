//
//  LocalVideoViewController.m
//  PtahInteractive
//
//  Created by ptah on 16/8/5.
//  Copyright © 2016年 Ptah. All rights reserved.
//




#import "LocalVideoViewController.h"
#import "MyvideoVc.h"
#import "TeriManerger.h"
#import "Local.h"
#import "GooglePanaromaVc.h"

@interface LocalVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate>
{

    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    //5
    UIImageView *_load;
    
    
    UICollectionView *_collectionview;
    
    UICollectionReusableView* _header;
    
    MyvideoVc   *_MyviewVc;

}
@property(nonatomic,strong)NSManagedObjectContext *context;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation LocalVideoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Local"];
    self.dataArr = [_context executeFetchRequest:request error:nil];
    [_collectionview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     __weak typeof(self) weakSelf = self;
    
    [self useCoredata];
    [self crteaTitle];
    
      [self createui];
    
}

-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)crteaTitle{
    
    //创建标题。。。。
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),TopH-35 , LFScreenW*2/5, pich)];
    lab.text = self.title;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [self.view addSubview:lab];
    
}

#pragma mark collectionview------------------------------------------------------
-(void)createui{
    //self.dataArr  = [NSMutableArray array];

    
    
    
    UICollectionViewFlowLayout *latyout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH) collectionViewLayout:latyout];
    
    
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.shouldGroupAccessibilityChildren = YES;
    //注册
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    
    //    [_collectionview  registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeaderwithReuseIdentifier:@"header"];
    //
    //
    //    [_collectionview reg]
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    
    _collectionview.backgroundColor = GrayColor;
    
    [self.view addSubview:_collectionview];
    
    
    [self createTopView];
    self.IndextTtile.text = @"Local";
    //创建右上角菜单栏
    [self blackHeimu];
    [self createMenu];
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
}




- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(LFScreenW,LFScreenH*1/4+45);
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    //
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    //}
    
    cell.backgroundColor = [UIColor redColor];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW/2-10,LFScreenH/5-30)];
    img.userInteractionEnabled = YES;
    img.image = [UIImage imageNamed:@"project-small"];
    img.image = [UIImage imageWithData:[_dataArr[indexPath.row] miniImg] ];
    //img.image = [UIImage imageNamed:@"hot"];
    img.tag=350+indexPath.row;
    UITapGestureRecognizer *tapG2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapintoVR:)];
    [img addGestureRecognizer:tapG2];
    [cell.contentView addSubview:img];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(0, img.maxY, LFScreenW/2-10, 30)];
    whiteback.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:whiteback];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, img.maxY, (LFScreenW/2-10)*3/5, 30)];
    lab.text = [_dataArr[indexPath.row] imgName];
    [cell.contentView addSubview:lab];
    lab.font = [UIFont systemFontOfSize:12];
    
    //
    UIImageView *edit = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-30, lab.y+10, 15, 15)];
//    edit.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
//    [edit addGestureRecognizer:tapG];
    edit.tag=300;
    
    edit.image = [UIImage imageNamed:@"local-video_edit"];
    [cell.contentView addSubview:edit];

    
    //    UIImageView *love = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-10-35, 10, 10, 10)];
    //    love.image = [UIImage imageNamed:@"love"];
    //    [whiteback addSubview:love];
    //
    //    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(love.maxX, 10, 20, 10)];
    //    lab2.text = @"251";
    //    lab2.textColor = [UIColor grayColor];
    //    [whiteback addSubview:lab2];
    //    lab2.font = [UIFont systemFontOfSize:10];
    
    
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
    
}

#pragma MARK 设置collectionview的大小以及每一个cell的间距
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(LFScreenW/2-10,LFScreenH/5);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5,5,5);
}


-(UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath{
    
    //创建UICollectionReusableView视图
    
    if (!_header) {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        
        _header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        //添加头视图内容
    }
    [self createView];
    
    _header.backgroundColor = [UIColor colorWithRed:22./255 green:137./255 blue:206./255 alpha:1];
    
    }
    return _header;
}

#pragma mark  头部视图创建－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)createView{
    CGFloat headH = _header.height-45;
    
    NSArray *arr = @[@"local-video_make a panorama",@"local-video_edit my local video"];
    NSArray *arr2 = @[@"Make a Panorama from my video",@"Edit my local video"];
    for (int i = 0; i<arr.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/4-LFScreenW/6/2+i*LFScreenW/2, headH/2-headH/4/2-20, LFScreenW/6, headH/4)];
        img.image = [UIImage imageNamed:arr[i]];
        img.userInteractionEnabled = YES;
        img.tag=100+i;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        
        [img addGestureRecognizer:tapG];
        [_header addSubview:img];
        
        //
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10+i*LFScreenW/2, img.maxY+5, LFScreenW/2-20, headH/4)];
        lab1.textColor = [UIColor whiteColor];
        //lab1.backgroundColor = [UIColor redColor];
        lab1.numberOfLines = 0;
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.text = arr2[i];
        [_header addSubview:lab1];
        
    }
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, headH, LFScreenW, 45)];
    view1.backgroundColor = GrayColor;
    [_header addSubview:view1];
    
    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, headH+20, 35, 15)];
    _load.image = [UIImage imageNamed:@"local-video_my panorama"];
    _load.backgroundColor = [UIColor clearColor];
    
    [_header addSubview:_load];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, headH+17, 200, 22)];
    lab.text = @"My panorama";
    lab.font = [UIFont systemFontOfSize:19];
    lab.backgroundColor = [UIColor clearColor];
    [_header addSubview:lab];
    
    //白色竖线
    UIView *whiteLine = [[UIView alloc ]initWithFrame:CGRectMake(LFScreenW/2, 0, 2, headH)];
    whiteLine.backgroundColor = [UIColor whiteColor];
    whiteLine.alpha = 0.3;
    [_header addSubview:whiteLine];
    
    //创建垃圾桶
    UIImageView *laji = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW-25, lab.y, 20, 25)];
     UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
    [laji addGestureRecognizer:tapG];
    laji.userInteractionEnabled = YES;
    laji.tag=200;
    
    laji.image = [UIImage imageNamed:@"local-video_delete"];
    //[_header addSubview:laji];
    
    
}

#pragma mark 点击滑动图片进入
-(void)tapG:(UITapGestureRecognizer *)tap{
    
    
    //垃圾桶
    if (tap.view.tag==200) {
        
    }
    //小笔编辑
    else if (tap.view.tag==300){
    
    
    }
    //删除最近视频
    else if (tap.view.tag==101){
        _MyviewVc = [[MyvideoVc alloc]init];
        
        [self.navigationController pushViewController:_MyviewVc animated:YES];
    }
    //获取手机里的图片
    else if (tap.view.tag==100){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    
    }
  
    
}
#pragma mark 点击进入vr播放界面
-(void)tapintoVR:(UITapGestureRecognizer *)tap{
    //点击小图片进入全景图片
    NSInteger index = tap.view.tag-350;
    Local *model = _dataArr[index];
    NSLog(@"%@",model.originalpic);
  //  UIImage *image = [UIImage imageWithData:[_dataArr[index] originalImg]];
    NSString * path = [_dataArr[index] originalpic];
    
    // 二进制的数据就可以进行上传
        NSData * data = [NSData dataWithContentsOfFile:path];
        UIImage * image = [UIImage imageWithData:data];
    
    GooglePanaromaVc *goovr = [[GooglePanaromaVc alloc]init];
    goovr.type=2;
    goovr.image = image;
    
    [self presentViewController:goovr animated:YES completion:nil];
    
    
}

#pragma mark 实现代理方法<UIImagePickerControllerDelegate>
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
     [picker dismissViewControllerAnimated:YES completion:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [self.view addSubview:hud];

    dispatch_queue_t nimei = dispatch_queue_create("lalal", DISPATCH_QUEUE_CONCURRENT);
    
   
    
    
    dispatch_async( nimei, ^{
       
            // 保存原始图片
        UIImage *image =info[UIImagePickerControllerOriginalImage];
        [self saveImage:image WithName:@""];
//        //UIImage *image =info[UIImagePickerControllerEditedImage];
//
////        //imageView.image = info[UIImagePickerControllerOriginalImage];
////        //NSData *data = UIImageJPEGRepresentation(image, 0);
//        NSMutableData *data ;
//        if (UIImagePNGRepresentation(image) == nil) {
//            
//            data = UIImageJPEGRepresentation(image, 1);
//            
//        } else {
//            
//            data = UIImagePNGRepresentation(image);
//        }
//        //保存小图片
////        NSMutableData *data2;
////        UIImageView *imaview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
////        imaview.image = image;
//       
//        
////        if (UIImagePNGRepresentation(imaview.image) == nil) {
////            
////            data2 = UIImageJPEGRepresentation(imaview.image, 0.00001);
////            
////        } else {
////            
////            data2 = UIImagePNGRepresentation(imaview.image);
////        }
//        
//        //    添加进入数据库
//        Local *localdata = [NSEntityDescription insertNewObjectForEntityForName:@"Local" inManagedObjectContext:_context];
//        
//        localdata.originalImg = data;
//       // localdata.miniImg = data2;
//        localdata.imgName = @"Local Image";
//        
//        
//        NSError *error = nil;
//        
//        BOOL isok = [_context save:&error];
//        
//        if (isok) {
//            NSLog(@"保存图片到本地成功");
//        }else
//            NSLog(@"保存图片到本地失败");
//        
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Local"];
//        self.dataArr = [_context executeFetchRequest:request error:nil];
        
      //  UIImage *image = info[UIImagePickerControllerOriginalImage];
        
       

    dispatch_sync(dispatch_get_main_queue(), ^{
//        GooglePanaromaVc *goovr = [[GooglePanaromaVc alloc]init];
//        goovr.type=2;
//        goovr.image = image;
        
//        [self presentViewController:goovr animated:YES completion:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [_collectionview reloadData];

    });
        
           });
    

}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // .....
    // 关闭选择图片界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSMutableData * imageData = UIImageJPEGRepresentation(tempImage, 0);

    //设置image的尺寸
    CGSize imageSize = tempImage.size;
    imageSize.height =LFScreenH;
    imageSize.width =LFScreenW;
    //对图片大小进行压缩--
    tempImage = [self imageWithImage:tempImage scaledToSize:imageSize];
    NSData *imageData2 = UIImageJPEGRepresentation(tempImage,0.00001);
    

    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
       //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    NSInteger index = _dataArr.count;
    NSString *str = [NSString stringWithFormat:@"/image%@.jpg",[NSNumber numberWithInteger:index]];
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    //[fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingPathComponent:str] contents:imageData attributes:nil]; //将图片保存为JPEG格式
    //用于用户图片上传，重进app就会消失
    // [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:str] contents:imageData attributes:nil]; //将图片保存为JPEG格式
    
    //得到选择后沙盒中图片的完整路径
   // filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, str];

    
            //    添加进入数据库
            Local *localdata = [NSEntityDescription insertNewObjectForEntityForName:@"Local" inManagedObjectContext:_context];
    
            //localdata.originalImg = data;
            localdata.miniImg = imageData2;
            localdata.imgName = @"Local Image";
            localdata.originalpic = filePath;
    //localdata.miniImg =
    
            NSError *error = nil;
    
            BOOL isok = [_context save:&error];
    
            if (isok) {
                NSLog(@"保存图片到本地成功");
            }else
                NSLog(@"保存图片到本地失败");
    
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Local"];
            self.dataArr = [_context executeFetchRequest:request error:nil];
    
            
    
    // 将存入到沙盒的图片再取出来，目的是为了进行上传
//    NSLog(@"fullPathToFile:%@", documentsDirectory);
//    NSString * path = documentsDirectory;
    // 二进制的数据就可以进行上传
//    NSData * data = [NSData dataWithContentsOfFile:path];
//    UIImage * image = [UIImage imageWithData:data];
   // self.postImage.image = image;
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
