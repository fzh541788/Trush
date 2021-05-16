//
//  MapViewController.m
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "Masonry.h"
#import "TestView.h"
#import "UIImageView+WebCache.h"
#import "Manage.h"
#define mas_height self.view.frame.size.height
#define mas_width self.view.frame.size.width


@interface MapViewController ()<BMKMapViewDelegate,BMKLocationManagerDelegate,UIScrollViewDelegate,BMKRouteSearchDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger didPressButton;
@property (nonatomic, strong) BMKPlanNode *temporaryEnd;
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) UIView *pictureView;
//@property (nonatomic, copy) NSMutableArray *location;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",mas_height);
    //    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *tabBarImage = [UIImage imageNamed:@"ditudaohang-2.png"];
    UITabBarItem *secondTabBarItem = [[UITabBarItem alloc]initWithTitle:@"回收" image:tabBarImage tag:3];
    secondTabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    self.tabBarItem = secondTabBarItem;
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    // 显示定位信息
    _mapView.showsUserLocation = YES;
    // 将当前地图显示缩放等级设置为16级
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    [_mapView setZoomLevel:16];
    [self.view addSubview:_mapView];
    //    [self.locationManager startUpdatingLocation];
    [self locationManage];
    //    [self.locationManager startUpdatingHeading];
    _buttomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttomButton setImage:[UIImage imageNamed:@"shouhui.png"] forState:UIControlStateNormal];
    [self.view addSubview:_buttomButton];
    _buttomButton.backgroundColor = [UIColor whiteColor];
    [_buttomButton addTarget:self action:@selector(pressMore:) forControlEvents:UIControlEventTouchUpInside];
    [_buttomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(mas_height * 0.85961);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(mas_width, 48));
    }];
    _testView = [[TestView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, 200)];
    [self.view addSubview:_testView];
    //    _testView = [[TestView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    //    _testView.hidden = YES;
    
    [_testView.upButton addTarget:self action:@selector(pressUpButton) forControlEvents:UIControlEventTouchUpInside];
    [_testView.nearlyButton addTarget:self action:@selector(pressNearlyButton) forControlEvents:UIControlEventTouchUpInside];
    [_testView.delegtWayButton addTarget:self action:@selector(pressDelegtWayButton) forControlEvents:UIControlEventTouchUpInside];
    [_testView.refreshButton addTarget:self action:@selector(pressRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    [_testView.pictureButton addTarget:self action:@selector(pressPicture) forControlEvents:UIControlEventTouchUpInside];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    _testView.pictureButton.hidden = YES;
    
    _pictureView = [[UIView alloc]init];
    [self.view addSubview:_pictureView];
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_buttomButton.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(mas_width, 200));
    }];
    _pictureView.backgroundColor = [UIColor whiteColor];
    _pictureView.tag = 22;
    _pictureView.hidden = YES;
    
    _trashImage = [[UIImageView alloc]init];
    _trashImage.frame = CGRectMake(0, 0, mas_width, 200);
    [_pictureView addSubview:_trashImage];
    
}
//增加垃圾桶图片 到这去 刷新路径 删除点
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    NSString *identifier = @"baidu";
    BMKPinAnnotationView *annotationView = nil;
    if (!annotationView) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0,annotationView.image.size.width, annotationView.image.size.height);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [annotation.subtitle floatValue];
        
        annotationView.enabled = YES;
        annotationView.userInteractionEnabled = YES;
        [annotationView addSubview:btn];
    }
    return annotationView;
}

- (void)btnAction:(UIButton *)button {
    BMKRouteSearch *routeSearch = [[BMKRouteSearch alloc] init];
    routeSearch.delegate = self;
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(_locationOne, _locationTwo);
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    _temporaryEnd = [[BMKPlanNode alloc]init];
    for (int i = 0; i < _total; i++) {
        if (button.tag == i + 1) {
            end.pt = CLLocationCoordinate2DMake([_tempLatitude[i] floatValue], [_tempLongitude[i] floatValue]);
            _temporaryEnd.pt = CLLocationCoordinate2DMake([_tempLatitude[i] floatValue], [_tempLongitude[i] floatValue]);
            BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
            walkingRouteSearchOption.from = start;
            walkingRouteSearchOption.to = end;
           [_trashImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_trashImageScource[i]]]];
            
            BOOL flag = [routeSearch walkingSearch:walkingRouteSearchOption];
            if (flag) {
                NSLog(@"步行路线规划检索发送成功");
            } else {
                NSLog(@"步行路线规划检索发送失败");
            }
        }
    }
    
//    if (button.tag == 2) {
//        end.pt = CLLocationCoordinate2DMake([_tempLatitude[1] floatValue], [_tempLongitude[1] floatValue]);
//        _temporaryEnd.pt = CLLocationCoordinate2DMake([_tempLatitude[1] floatValue], [_tempLongitude[1] floatValue]);
//        BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
//        walkingRouteSearchOption.from = start;
//        walkingRouteSearchOption.to = end;
//        [_trashImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_trashImageScource[1]]]];
//
//        BOOL flag = [routeSearch walkingSearch:walkingRouteSearchOption];
//        if (flag) {
//            NSLog(@"步行路线规划检索发送成功");
//        } else {
//            NSLog(@"步行路线规划检索发送失败");
//        }
//    }
    _testView.pictureButton.hidden = NO;
}


#pragma mark - BMKRouteSearchDelegate
/**
 返回步行路线检索结果
 */
- (void)mapViewFitPolyline:(BMKPolyline *)polyline withMapView:(BMKMapView *)mapView {
    double leftTop_x, leftTop_y, rightBottom_x, rightBottom_y;
    if (polyline.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyline.points[0];
    leftTop_x = pt.x;
    leftTop_y = pt.y;
    //左上方的点lefttop坐标（leftTop_x，leftTop_y）
    rightBottom_x = pt.x;
    rightBottom_y = pt.y;
    //右底部的点rightbottom坐标（rightBottom_x，rightBottom_y）
    for (int i = 1; i < polyline.pointCount; i++) {
        BMKMapPoint point = polyline.points[i];
        if (point.x < leftTop_x) {
            leftTop_x = point.x;
        }
        if (point.x > rightBottom_x) {
            rightBottom_x = point.x;
        }
        if (point.y < leftTop_y) {
            leftTop_y = point.y;
        }
        if (point.y > rightBottom_y) {
            rightBottom_y = point.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTop_x , leftTop_y);
    rect.size = BMKMapSizeMake(rightBottom_x - leftTop_x, rightBottom_y - leftTop_y);
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 10, 20, 10);
    [mapView fitVisibleMapRect:rect edgePadding:padding withAnimated:YES];
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //+polylineWithPoints: count:坐标点的个数
        __block NSUInteger pointCount = 0;
        //获取所有步行路线中第一条路线
        BMKWalkingRouteLine *routeline = (BMKWalkingRouteLine *)result.routes.firstObject;
        //遍历步行路线中的所有路段
        [routeline.steps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //获取步行路线中的每条路段
            BMKWalkingStep *step = routeline.steps[idx];
            //初始化标注类BMKPointAnnotation的实例
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            //设置标注的经纬度坐标为子路段的入口经纬度
            annotation.coordinate = step.entrace.location;
            /**
             当前地图添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:方法
             来生成标注对应的View
             @param annotation 要添加的标注
             */
            [_mapView addAnnotation:annotation];
            //统计路段所经过的地理坐标集合内点的个数
            pointCount += step.pointsCount;
        }];
        //+polylineWithPoints: count:指定的直角坐标点数组
        
        BMKMapPoint *points = new BMKMapPoint[pointCount];
        __block NSUInteger j = 0;
        //遍历步行路线中的所有路段
        [routeline.steps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //获取步行路线中的每条路段
            BMKWalkingStep *step = routeline.steps[idx];
            //遍历路段所经过的地理坐标集合
            for (NSUInteger i = 0; i < step.pointsCount; i ++) {
                //将每条路段所经过的地理坐标点赋值给points
                points[j].x = step.points[i].x;
                points[j].y = step.points[i].y;
                j ++;
            }
        }];
        //根据指定直角坐标点生成一段折线
        BMKPolyline *polyline = [BMKPolyline polylineWithPoints:points count:pointCount];
        /**
         向地图View添加Overlay，需要实现BMKMapViewDelegate的-mapView:viewForOverlay:方法
         来生成标注对应的View
         
         @param overlay 要添加的overlay
         */
        [_mapView addOverlay:polyline];
        //根据polyline设置地图范围
        [self mapViewFitPolyline:polyline withMapView:self.mapView];
    }
}
/**
 根据overlay生成对应的BMKOverlayView
 
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        //初始化一个overlay并返回相应的BMKPolylineView的实例
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        //设置polylineView的画笔颜色
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        //设置polylineView的线宽度
        polylineView.lineWidth = 4.0;
        return polylineView;
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}

- (void)pressMore:(UIButton *)button {
    if (_didPressButton == 0) {
        //弹出动画
        CABasicAnimation *firstUpAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        firstUpAnima.fromValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.88561)];
        firstUpAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.68)];
        firstUpAnima.duration = 0.54f;
        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
        firstUpAnima.fillMode = kCAFillModeForwards;
        firstUpAnima.removedOnCompletion = NO;
        firstUpAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [button.layer addAnimation:firstUpAnima forKey:@"positionAnimation"];
        
        CABasicAnimation *testViewUpAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        testViewUpAnima.fromValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height)];
        testViewUpAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.81)];
        testViewUpAnima.duration = 0.55f;
        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
        testViewUpAnima.fillMode = kCAFillModeForwards;
        testViewUpAnima.removedOnCompletion = NO;
        testViewUpAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [_testView.layer addAnimation:testViewUpAnima forKey:@"positionAnimation"];
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(mas_height * 0.645788);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(mas_width, 48));
        }];
        
        [button setImage:[UIImage imageNamed:@"xiala.png"] forState:UIControlStateNormal];
        //    button.frame = CGRectMake(0, self.view.frame.size.height - 328, self.view.frame.size.width, 48);
        
        //        [button addTarget:self action:@selector(unPressMore:) forControlEvents:UIControlEventTouchUpInside];
        
        _testView.frame = CGRectMake(0, self.view.frame.size.height -  270, self.view.frame.size.width, 200);
    } else if (_didPressButton == 1) {
        CABasicAnimation *firstDownAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        firstDownAnima.fromValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.68)];
        firstDownAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.88561)];
        firstDownAnima.duration = 0.6f;
        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
        firstDownAnima.fillMode = kCAFillModeForwards;
        firstDownAnima.removedOnCompletion = NO;
        firstDownAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [button.layer addAnimation:firstDownAnima forKey:@"positionAnimation"];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(mas_height * 0.85961);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(mas_width, 48));
        }];
        
        CABasicAnimation *testViewDownAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        testViewDownAnima.fromValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height * 0.81)];
        testViewDownAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(mas_width / 2, mas_height + 15)];
        testViewDownAnima.duration = 0.6f;
        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
        testViewDownAnima.fillMode = kCAFillModeForwards;
        testViewDownAnima.removedOnCompletion = NO;
        testViewDownAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [_testView.layer addAnimation:testViewDownAnima forKey:@"positionAnimation"];
        
        _testView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
        [button setImage:[UIImage imageNamed:@"shouhui.png"] forState:UIControlStateNormal];
        //        [button addTarget:self action:@selector(pressMore:) forControlEvents:UIControlEventTouchUpInside];
        if (_pictureView.hidden == NO) {
            [self pressPicture];
        }
    }
    _didPressButton = !_didPressButton;
}

- (void)pressPicture {
    if (_didSecondChange) {
        [_testView.pictureButton setTitle:@"图片" forState:UIControlStateNormal];
        _pictureView.hidden = YES;
    } else {
        [_testView.pictureButton setTitle:@"收起" forState:UIControlStateNormal];
        _pictureView.hidden = NO;
    }
    _didSecondChange = !_didSecondChange;
    
}


- (void)pressUpButton {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    [alertViewController addAction:cancle];
    [alertViewController addAction:photo];
    [alertViewController addAction:picture];
    // support iPad
    alertViewController.popoverPresentationController.sourceView = self.view;
    alertViewController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height, 1.0, 1.0);
    [self presentViewController:alertViewController animated:YES completion:nil];
}

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
    } else {
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
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //通过key值获取到图片123
    NSData *imageData = UIImageJPEGRepresentation(image,1.0f);
    [[Manage sharedManager]netWorkOfUpBin:_location and:imageData and:_locationTwo and:_locationOne and:^(UpBinModel * _Nonnull mainViewNowModel) {
        if (mainViewNowModel.status == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"添加成功！" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                            [alert addAction:sureAction];
                            [self presentViewController:alert animated:NO completion:nil];
        } else if (mainViewNowModel.status == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"该垃圾桶已存在！" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                            [alert addAction:sureAction];
                            [self presentViewController:alert animated:NO completion:nil];
        }
    } error:^(NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
}

- (void)pressNearlyButton {
    [[Manage sharedManager]netWorkOfNearbyBin:_location and:^(NearbyBinModel * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_tempLongitude = [[NSMutableArray alloc]init];
            self->_tempLatitude = [[NSMutableArray alloc]init];
            self->_trashImageScource = [[NSMutableArray alloc]init];
            _total = mainViewNowModel.data.count;
            for (int i = 0; i < mainViewNowModel.data.count; i++) {
                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
                annotation.coordinate = CLLocationCoordinate2DMake([[mainViewNowModel.data[i]latitude] floatValue], [[mainViewNowModel.data[i]longitude] floatValue]);
                [self->_trashImageScource addObject:[mainViewNowModel.data[i]picture]];
                [self->_tempLongitude addObject:[mainViewNowModel.data[i]longitude]];
                [self->_tempLatitude addObject:[mainViewNowModel.data[i]latitude]];
                //设置标注的标题
                //副标题
                annotation.subtitle = [NSString stringWithFormat:@"%d",i + 1];
                [self->_mapView addAnnotation:annotation];
            }
            
            
//            BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
//            annotation1.coordinate = CLLocationCoordinate2DMake([[mainViewNowModel.data[1]latitude] floatValue], [[mainViewNowModel.data[1]longitude] floatValue]);
//            [self->_trashImageScource addObject:[mainViewNowModel.data[1]picture]];
//            [self->_tempLongitude addObject:[mainViewNowModel.data[1]longitude]];
//            [self->_tempLatitude addObject:[mainViewNowModel.data[1]latitude]];
////            NSLog(@"%@",self->_tempLongitude);
//            //设置标注的标题
//            //副标题
//            annotation1.subtitle = @"2";
//            [self->_mapView addAnnotation:annotation1];
            self->_flag = 1;
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)pressDelegtWayButton {
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    _flag = 0;
    [_testView.pictureButton setTitle:@"图片" forState:UIControlStateNormal];
    _testView.pictureButton.hidden = YES;
    [_mapView setZoomLevel:16];
    _pictureView.hidden = YES;
}

- (void)pressRefreshButton {
    [self requestLocation];
    BMKRouteSearch *routeSearch = [[BMKRouteSearch alloc] init];
    routeSearch.delegate = self;
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(_locationOne, _locationTwo);
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = _temporaryEnd;
    
    BOOL flag = [routeSearch walkingSearch:walkingRouteSearchOption];
    if (flag) {
        NSLog(@"步行路线规划检索发送成功");
    } else{
        NSLog(@"步行路线规划检索发送失败");
    }
}

- (void)locationManage {
    //因为mapView是在一个分离出来的view中创建的，所以在这里将signSetTypeView中的mapView赋给当前viewcontroller的mapView；
    //        self.mapView = self.signSetTypeView.mapView;
    //        self.mapView.delegate = self;
    //    self.annotation = [[BMKPointAnnotation alloc] init];
    
    // self.mapView是BMKMapView对象
    //精度圈设置
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    //设置显示精度圈，默认YES
    param.isAccuracyCircleShow = YES;
    //精度圈 边框颜色
    param.accuracyCircleStrokeColor = [UIColor colorWithRed:242/255.0 green:129/255.0 blue:126/255.0 alpha:1];
    
    //精度圈 填充颜色
    param.accuracyCircleFillColor = [UIColor colorWithRed:242/255.0 green:129/255.0 blue:126/255.0 alpha:0.3];
    [self.mapView updateLocationViewWithParam:param];
    
    _locationManager = [[BMKLocationManager alloc] init];
    //设置定位管理类实例的代理
    _locationManager.delegate = self;
    //设定定位坐标系类型，默认为 BMKLocationCoordinateTypeGCJ02
    _locationManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
    //设定定位精度，默认为 kCLLocationAccuracyBest
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设定定位类型，默认为 CLActivityTypeAutomotiveNavigation
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //指定定位是否会被系统自动暂停，默认为NO
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    /**
     是否允许后台定位，默认为NO。只在iOS 9.0及之后起作用。
     设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。
     由于iOS系统限制，需要在定位未开始之前或定位停止之后，修改该属性的值才会有效果。
     */
    _locationManager.allowsBackgroundLocationUpdates = NO;
    /**
     指定单次定位超时时间,默认为10s，最小值是2s。注意单次定位请求前设置。
     注意: 单次定位超时时间从确定了定位权限(非kCLAuthorizationStatusNotDetermined状态)
     后开始计算。
     */
    _locationManager.locationTimeout = 10;
    //请求一次定位
    [self requestLocation];
}

- (void)requestLocation {
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        NSLog(@"");
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            if (location.location) {
                NSLog(@"LOC = %f , %f",location.location.coordinate.longitude,location.location.coordinate.latitude);
                self->_locationOne = location.location.coordinate.latitude;//one latitude
                self->_locationTwo = location.location.coordinate.longitude;// two longitude
            }
            if (location.rgcData) {
                NSLog(@"rgc = %@",[location.rgcData description]);
                self->_location = [NSString stringWithFormat:@"%@%@",[location.rgcData city],[location.rgcData street]];
                NSLog(@"%@",self->_location);
            }
    
            if (!location) {
                return;
            }
            if (!self.userLocation) {
                self.userLocation = [[BMKUserLocation alloc] init];
            }
            self.userLocation.location = location.location;
            [self.mapView updateLocationData:self.userLocation];
            CLLocationCoordinate2D mycoordinate = location.location.coordinate;
            self.mapView.centerCoordinate = mycoordinate;
        }
    }];
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
@end

