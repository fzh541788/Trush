//
//  RecognitionViewController.m
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import "RecognitionViewController.h"
#import "FirstView.h"
#import "SearchViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
//#import "PictureModel.h"
#import "ResultViewController.h"
#import "Manage.h"
#import <Speech/Speech.h>
 

@interface RecognitionViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,AVAudioRecorderDelegate,SFSpeechRecognizerDelegate>
@property (nonatomic, strong)FirstView *firstView;
//@property (nonatomic, strong)PictureModel *pictureModel;

@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (nonatomic, strong)ResultViewController *secondView;
@property (strong, nonatomic) SFSpeechRecognitionTask  *recognitionTask;
@property (strong, nonatomic) SFSpeechRecognizer       *speechRecognizer;
@property (strong, nonatomic) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;

@end

@implementation RecognitionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _secondView = [[ResultViewController alloc]init];
    // Do any additional setup after loading the view.
    _firstView = [[FirstView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_firstView];
    [_firstView.pictureButton addTarget:self action:@selector(pressPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_firstView.voiceButton addTarget:self action:@selector(pressVoice:) forControlEvents:UIControlEventTouchUpInside];
    _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
    
    _imageView = [[UIImageView alloc]init];
    self.firstView.searchTextField.delegate = self;
    
    _testName = [[NSString alloc]init];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//点击UITextField的响应事件
-(void)textFieldDidBeginEditing:(UITextField*)textField {
  //点击这个方法 就相当于点击了一个按钮，在这里做自己想做的
    if(textField == self.firstView.searchTextField) {
        [textField resignFirstResponder];
        SearchViewController *searchViewController = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:searchViewController animated:YES];
        
    }
}
//点击UITextField--Return响应事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)pressPhoto {
    
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];

        /*关于UIAlertActionStyle有三种样式
         UIAlertActionStyleDefault  , 默认样式
         UIAlertActionStyleCancel,      取消
         UIAlertActionStyleDestructive, 有毁灭性的操作是使用, 呈现红色
         */
        [alertViewController addAction:cancle];
        [alertViewController addAction:photo];
        [alertViewController addAction:picture];
    // support iPad
    alertViewController.popoverPresentationController.sourceView = self.view;
    alertViewController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height, 1.0, 1.0);
        [self presentViewController:alertViewController animated:YES completion:nil];

}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //设置UIImagePickerController的代理，同时要遵循
            //UIImagePickerControllerDelegate，
            //UINavigationControllerDelegate协议
            picker.delegate = self;
            
            //设置拍照之后图片是否可编辑，如果设置成可编辑的话会
            //在代理方法返回的字典里面多一些键值。PS：
            //如果在调用相机的时候允许照片可编辑，
            //那么用户能编辑的照片的位置并不包括边角。
            picker.allowsEditing = YES;
     
            //UIImagePicker选择器的类型，UIImagePickerControllerSourceTypeCamera调用系统相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
     
            [self presentViewController:picker animated:YES completion:nil];
            NSLog(@"拍照中");
        }
        else{
            //如果当前设备没有摄像头
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:NO completion:nil];
        }

}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum {
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
     [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    _imageView.image = image;  //给UIimageView赋值已经选择的相片
    [[Manage sharedManager]NetWorkPicture:[self encodeToBase64String:image] and:^(PictureModel * _Nonnull mainViewNowModel) {
            NSLog(@"%@",[mainViewNowModel.data[0]list]);
        self->_secondView.maybe = [[NSMutableArray alloc]init];
        self->_secondView.name = [[NSMutableArray alloc]init];
        for (int i = 0; i < [mainViewNowModel.data[0]list].count; i++) {
            [self->_secondView.maybe addObject:[[mainViewNowModel.data[0]list][i]category]];
            [self->_secondView.name addObject:[[mainViewNowModel.data[0]list][i]name]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.secondView.tableView reloadData];
            [self presentViewController:self->_secondView animated:YES completion:nil];
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"网络请求失败");
        }];
 }
- (NSString *)encodeToBase64String:(UIImage *)image {
    UIImage *newImag = [self yasuoImage:image];
    NSData *data = UIImageJPEGRepresentation(newImag, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [self urlEncodeStr:encodedImageStr];
}
// 压缩图片
- (UIImage *)yasuoImage:(UIImage *)image {
    // 图片限制大小100KB
    NSData *tpData = UIImagePNGRepresentation(image);
    NSInteger dxLengh = [tpData length]/1024;
    NSInteger num = 0;
    while (dxLengh >= 100) {
        if (num > 100) {
            break;
        }
        UIImage *tpImg = [UIImage imageWithData:tpData];
        CGSize tpSize = tpImg.size;
        UIImage *newImg = [self scaleToSize:tpImg size:CGSizeMake(tpSize.width*0.8, tpSize.height*0.8)];
        tpData = UIImageJPEGRepresentation(newImg, 1);
        dxLengh = [tpData length]/1024;
        num = num + 1;
    }
    UIImage *rImage = [UIImage imageWithData:tpData];
    return rImage;
}
 
// 压缩图片大小 并不是截取图片而是按照size绘制图片
- (UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size {
    // 创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 保存图片
    // UIImageWriteToSavedPhotosAlbum(scaledImage, nil, nil, nil);
    return scaledImage;
}

- (NSString *)urlEncodeStr:(NSString *)input {
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

//当用户取消选择的时候，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)pressVoice:(UIButton *)sender {
    //本身对按钮的点击是不会改变selected状态的,需要我们在按钮的监听方法里去对这个值设置 这里就是简单
    sender.selected = !sender.selected;
       if (sender.selected != YES) {
         [_audioRecorder stop];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"录音结束！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
         return ;
       }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"开始录音，再次点击按钮结束录音" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //  URL是本地的URL AVAudioRecorder需要一个存储的路径
        NSString *name = [NSString stringWithFormat:@"%d.aiff" ,( int )[NSDate date].timeIntervalSince1970];
        
        self->_path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:name];
        NSError *error;
        //  录音机 初始化
        self->_audioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:self->_path] settings:@{AVNumberOfChannelsKey:@2,AVSampleRateKey:@44100,AVLinearPCMBitDepthKey:@32,AVEncoderAudioQualityKey:@(AVAudioQualityMax),AVEncoderBitRateKey:@128000} error:&error];
        [self->_audioRecorder prepareToRecord];
        [self->_audioRecorder record];
        self->_audioRecorder.delegate = self;
        /*
         1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
         2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k
         3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
         4.AVEncoderAudioQualityKey 声音质量
             ① AVAudioQualityMin  = 0, 最小的质量
             ② AVAudioQualityLow  = 0x20, 比较低的质量
             ③ AVAudioQualityMedium = 0x40, 中间的质量
             ④ AVAudioQualityHigh  = 0x60,高的质量
             ⑤ AVAudioQualityMax  = 0x7F 最好的质量
         5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
         */
        NSLog(@ "%@" ,self->_path);
    }];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];

}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:( BOOL )flag{
   NSLog(@ "录音结束" );

//  文件操作的类
   NSFileManager *manger = [NSFileManager defaultManager];

   NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//  获得当前文件的所有子文件subpathsAtPath
   NSArray *pathlList = [manger subpathsAtPath:path];

//  需要只获得录音文件
   NSMutableArray *audioPathList = [NSMutableArray array];
//  遍历所有这个文件夹下的子文件
   for (NSString *audioPath in pathlList) {
//    通过对比文件的延展名（扩展名 尾缀） 来区分是不是录音文件
     if ([audioPath.pathExtension isEqualToString:@ "aiff" ]) {
//      把筛选出来的文件放到数组中
       [audioPathList addObject:audioPath];
     }
   }
   NSLog(@"%@" ,audioPathList);
    
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSURL *url = [NSURL fileURLWithPath:_path];
    NSLog(@"%@",url);
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error != NULL) {
            NSLog(@"%@",error);
        } else {
        if (result.isFinal) {
            [[Manage sharedManager]NetWorkText:[result.bestTranscription.formattedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] and:^(TextModel * _Nonnull mainViewNowModel) {
                self->_secondView.maybe = [[NSMutableArray alloc]init];
                self->_secondView.name = [[NSMutableArray alloc]init];
                for (int i = 0; i < mainViewNowModel.data.list.count; i++) {
                    [self->_secondView.maybe addObject:[mainViewNowModel.data.list[i]category]];
                    [self->_secondView.name addObject:[mainViewNowModel.data.list[i]name]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.secondView.tableView reloadData];
                    [self presentViewController:self->_secondView animated:YES completion:nil];
                });
                } error:^(NSError * _Nonnull error) {
                    NSLog(@"网络请求失败");
                }];
        }
        }
    }];
    
}

@end
