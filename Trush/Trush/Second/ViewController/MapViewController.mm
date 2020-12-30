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

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationManagerDelegate,UIScrollViewDelegate,BMKRouteSearchDelegate>
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) BMKPlanNode *temporaryEnd;
//@property (nonatomic, copy) NSMutableArray *location;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [_buttomButton setImage:[UIImage imageNamed:@"tongyong_shangla.png"] forState:UIControlStateNormal];
    _buttomButton.frame = CGRectMake(0, self.view.frame.size.height - 130, self.view.frame.size.width, 48);
    _buttomButton.backgroundColor = [UIColor whiteColor];
    [_buttomButton addTarget:self action:@selector(pressMore:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttomButton];
    
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

- (void)btnAction:(UIButton *)button{
    BMKRouteSearch *routeSearch = [[BMKRouteSearch alloc] init];
    routeSearch.delegate = self;
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(_locationOne, _locationTwo);
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    _temporaryEnd = [[BMKPlanNode alloc]init];
    if (button.tag == 1) {
        end.pt = CLLocationCoordinate2DMake(34.167098, 108.9012);
        _temporaryEnd.pt = CLLocationCoordinate2DMake(34.167098, 108.9012);
    }
    if (button.tag == 2) {
        end.pt = CLLocationCoordinate2DMake(34.147098, 108.9012);
        _temporaryEnd.pt = CLLocationCoordinate2DMake(34.167098, 108.9012);
    }
   
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    
    BOOL flag = [routeSearch walkingSearch:walkingRouteSearchOption];
    if (flag) {
        NSLog(@"步行路线规划检索发送成功");
    } else{
        NSLog(@"步行路线规划检索发送失败");
    }
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
    button.frame = CGRectMake(0, self.view.frame.size.height - 328, self.view.frame.size.width, 48);
    [button addTarget:self action:@selector(unPressMore:) forControlEvents:UIControlEventTouchUpInside];
    _viewTest = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 200)];
    _viewTest.backgroundColor = [UIColor whiteColor];
    _viewTest.tag = 22;
    [self.view addSubview:_viewTest];
    _viewTest.pagingEnabled = NO;
    _viewTest.delegate = self;
    _viewTest.contentSize = CGSizeMake(self.view.frame.size.width, 201);
    _viewTest.showsVerticalScrollIndicator = FALSE;
    _viewTest.showsHorizontalScrollIndicator = FALSE;
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setFrame:CGRectMake(self.view.frame.size.width * 0.0701, 25, 65, 65)];
    [_upButton setImage:[UIImage imageNamed:@"zengjia-3.png"] forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(pressUpButton) forControlEvents:UIControlEventTouchUpInside];
    [_viewTest addSubview:_upButton];
    UILabel *upLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 80, 30)];
    upLabel.text = @"增加回收点";
    upLabel.textColor = [UIColor blackColor];
    upLabel.font = [UIFont systemFontOfSize:13];
    [_upButton addSubview:upLabel];
    
    _nearlyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nearlyButton setFrame:CGRectMake(self.view.frame.size.width * 0.56075, 30, 55, 55)];
    [_nearlyButton setImage:[UIImage imageNamed:@"08.png"] forState:UIControlStateNormal];
    [_nearlyButton addTarget:self action:@selector(pressNearlyButton) forControlEvents:UIControlEventTouchUpInside];
    [_viewTest addSubview:_nearlyButton];
    UILabel *nearlyLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, 55, 80, 30)];
    nearlyLabel.text = @"附近回收点";
    nearlyLabel.textColor = [UIColor blackColor];
    nearlyLabel.font = [UIFont systemFontOfSize:13];
    [_nearlyButton addSubview:nearlyLabel];
    
    _delegtWayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delegtWayButton setFrame:CGRectMake(self.view.frame.size.width * 0.327, 20, 64, 64)];
    [_delegtWayButton setImage:[UIImage imageNamed:@"luxian.png"] forState:UIControlStateNormal];
    [_delegtWayButton addTarget:self action:@selector(pressDelegtWayButton) forControlEvents:UIControlEventTouchUpInside];
    [_viewTest addSubview:_delegtWayButton];
    UILabel *delegtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 80, 30)];
    delegtLabel.text = @"取消规划";
    delegtLabel.textColor = [UIColor blackColor];
    delegtLabel.font = [UIFont systemFontOfSize:13];
    [_delegtWayButton addSubview:delegtLabel];
    
    
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refreshButton setFrame:CGRectMake(self.view.frame.size.width * 0.7944, 30, 55, 55)];
    [_refreshButton setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateNormal];
    [_refreshButton addTarget:self action:@selector(pressRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    [_viewTest addSubview:_refreshButton];
    UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 80, 30)];
    refreshLabel.text = @"刷新规划";
    refreshLabel.textColor = [UIColor blackColor];
    refreshLabel.font = [UIFont systemFontOfSize:13];
    [_refreshButton addSubview:refreshLabel];
    
    _pictureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_pictureButton setTitle:@"图片" forState:UIControlStateNormal];
    _pictureButton.frame = CGRectMake(170, 150, 80, 20);
    [_viewTest addSubview:_pictureButton];
    _pictureButton.hidden = YES;
    [_pictureButton addTarget:self action:@selector(pressPicture) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressPicture {

        if (_didSecondChange) {
            [_pictureButton setTitle:@"图片" forState:UIControlStateNormal];
        } else {
            [_pictureButton setTitle:@"收起" forState:UIControlStateNormal];
//                _viewTest.frame = CGRectMake(0, self.view.frame.size.height - 480, self.view.frame.size.width, 200);
//                _secondView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 200)];
//                _secondView.backgroundColor = [UIColor whiteColor];
//                _secondView.tag = 23;
//                [self.view addSubview:_secondView];
//                _secondView.pagingEnabled = NO;
//                _secondView.delegate = self;
//                _secondView.contentSize = CGSizeMake(self.view.frame.size.width, 200);
//                _secondView.showsVerticalScrollIndicator = FALSE;
//                _secondView.showsHorizontalScrollIndicator = FALSE;
        }
        _didSecondChange = !_didSecondChange;
}


- (void)pressUpButton {
    
}

- (void)pressNearlyButton {
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(34.167098, 108.9012);
    //设置标注的标题
    annotation.title = @"垃圾桶";
    //副标题
    annotation.subtitle = @"1";
    [_mapView addAnnotation:annotation];
    
    BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(34.147098, 108.9012);
    //设置标注的标题
    annotation1.title = @"垃圾桶";
    //副标题
    annotation1.subtitle = @"2";
    [_mapView addAnnotation:annotation1];
    _flag = 1;
    _pictureButton.hidden = NO;
}

- (void)pressDelegtWayButton {
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    _flag = 0;
    _pictureButton.hidden = YES;
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

- (void)unPressMore:(UIButton *)button {
//    [button setTitle:@"      -      " forState:UIControlStateNormal];
    _buttomButton.frame = CGRectMake(0, self.view.frame.size.height - 130, self.view.frame.size.width, 48);
    [button addTarget:self action:@selector(pressMore:) forControlEvents:UIControlEventTouchUpInside];
    
    for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag == 22) {
                [subviews removeFromSuperview];
            }
        }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag == 22) {
                if (currentOffsetY < 0) {
                    [self unPressMore:_buttomButton];
                }
            }
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
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            if (location.location) {
                NSLog(@"LOC = %f , %f",location.location.coordinate.longitude,location.location.coordinate.latitude);
                self->_locationOne = location.location.coordinate.latitude;
                self->_locationTwo = location.location.coordinate.longitude;
                
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

