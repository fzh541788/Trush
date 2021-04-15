//
//  ImageViewController.h
//  Trush
//
//  Created by young_jerry on 2020/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController : UIImagePickerController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

NS_ASSUME_NONNULL_END
