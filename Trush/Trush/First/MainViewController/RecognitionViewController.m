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

@interface RecognitionViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,AVAudioRecorderDelegate>
@property (nonatomic, strong)FirstView *firstView;
@end

@implementation RecognitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
        
        [self presentViewController:alertViewController animated:YES completion:nil];

}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera {
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //录制视频时长，默认10s
        _imagePickerController.videoMaximumDuration = 15;
     
        //相机类型（拍照、录像...）字符串需要做相应的类型转换
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
     
        //视频上传质量
        //UIImagePickerControllerQualityTypeHigh高清
        //UIImagePickerControllerQualityTypeMedium中等质量
        //UIImagePickerControllerQualityTypeLow低质量
        //UIImagePickerControllerQualityType640x480
        _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
     
        //设置摄像头模式（拍照，录制视频）为录像模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;

    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum {
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
     [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    _imageView.image = image;  //给UIimageView赋值已经选择的相片
    _imageView.frame = CGRectMake(100, self.view.frame.size.height / 2 + 200, 80, 80);
    [self.view addSubview:_imageView];
    
     //上传图片到服务器--在这里进行图片上传的网络请求，这里不再介绍
 }

//当用户取消选择的时候，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


- (void)pressVoice:(UIButton *)sender {
    sender.selected = !sender.selected;
       if (sender.selected != YES) {
         [_audioRecorder stop];
         return ;
       }
       //  URL是本地的URL AVAudioRecorder需要一个存储的路径
       NSString *name = [NSString stringWithFormat:@"%d.aiff" ,( int )[NSDate date].timeIntervalSince1970];
       
       NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:name];
       NSError *error;
       //  录音机 初始化
       _audioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:path] settings:@{AVNumberOfChannelsKey:@2,AVSampleRateKey:@44100,AVLinearPCMBitDepthKey:@32,AVEncoderAudioQualityKey:@(AVAudioQualityMax),AVEncoderBitRateKey:@128000} error:&error];
       [_audioRecorder prepareToRecord];
       [_audioRecorder record];
       _audioRecorder.delegate = self;
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
       NSLog(@ "%@" ,path);
}
- ( void )audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:( BOOL )flag{
   NSLog(@ "录音结束" );
////  文件操作的类
//   NSFileManager *manger = [NSFileManager defaultManager];
// 
//   NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
////  获得当前文件的所有子文件subpathsAtPath
//   NSArray *pathlList = [manger subpathsAtPath:path];
// 
////  需要只获得录音文件
//   NSMutableArray *audioPathList = [NSMutableArray array];
////  遍历所有这个文件夹下的子文件
//   for (NSString *audioPath in pathlList) {
////    通过对比文件的延展名（扩展名 尾缀） 来区分是不是录音文件
//     if ([audioPath.pathExtension isEqualToString:@ "aiff" ]) {
////      把筛选出来的文件放到数组中
//       [audioPathList addObject:audioPath];
//     }
//   }
//   
//   NSLog(@ "%@" ,audioPathList);
   
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
