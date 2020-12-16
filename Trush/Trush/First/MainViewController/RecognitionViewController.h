//
//  RecognitionViewController.h
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import <UIKit/UIKit.h>
//录音功能框架
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface RecognitionViewController : UIViewController

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
