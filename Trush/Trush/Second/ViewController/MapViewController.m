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

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationManagerDelegate>
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象
@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    // 显示定位信息
    _mapView.showsUserLocation = YES;
    // 将当前地图显示缩放等级设置为17级
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    [_mapView setZoomLevel:17];
    [self.view addSubview:_mapView];
//    [self.locationManager startUpdatingLocation];
    [self locationManage];
//    [self.locationManager startUpdatingHeading];
//
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
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
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            if (location.location) {
                NSLog(@"LOC = %@",location.location);
            }
            if (location.rgcData) {
                NSLog(@"rgc = %@",[location.rgcData description]);
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
