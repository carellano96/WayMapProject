//
//  MapViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController (){
    int _CurrentIndex;

    NSTimer *_timer;
    CLLocationCoordinate2D*coordinate;
}
@property (nonatomic) MGLShapeSource *polylineSource;
@property (nonatomic) MGLPolyline *polyline;
@property (nonatomic) NSMutableArray<CLLocation *> *locations;
@property CLLocationManager* locationManager;
@end

@implementation MapViewController
@synthesize MapView;

- (void)viewDidLoad {
    _CurrentIndex=0;
    [super viewDidLoad];
    self.locations=[[NSMutableArray alloc] init];
     self.polylineSource = [[MGLShapeSource alloc] initWithIdentifier:@"polyline" features:@[] options:nil];
    CLLocationCoordinate2D coordinate;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    [self.locationManager startUpdatingLocation];
    coordinate.latitude = self.locationManager.location.coordinate.latitude;
    coordinate.longitude= self.locationManager.location.coordinate.longitude;
    MapView.delegate=self;
    MapView.showsUserLocation=YES;
    [MapView.self setUserTrackingMode:MGLUserTrackingModeFollow];
    [self mapView:MapView didSelectUserLocation:MapView.userLocation];
    [self.locationManager requestAlwaysAuthorization];
    
    // For use in foreground
    [self.locationManager requestWhenInUseAuthorization];
    

    [self.locationManager startUpdatingLocation];
    //[self.MapView setCenterCoordinate:MapView.userLocation.coordinate zoomLevel:11 animated:YES];
    // Do any additional setup after loading the view.
    //Fun new stuff
    


}
- (void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style {
    [self addLayer:self.polylineSource];
    NSLog(@"Reach here?");
}


- (void)addLayer:(MGLShapeSource *)source {
    // Add an empty MGLShapeSource, we’ll keep a reference to this and add points to this later.
    [self.MapView.style addSource:self.polylineSource];
    
    // Add a layer to style our polyline.
    MGLLineStyleLayer *layer = [[MGLLineStyleLayer alloc] initWithIdentifier:@"polyline" source:source];
    layer.lineJoin = [MGLStyleValue valueWithRawValue:[NSValue valueWithMGLLineJoin:MGLLineJoinRound]];
    layer.lineCap = [MGLStyleValue valueWithRawValue:[NSValue valueWithMGLLineCap:MGLLineCapRound]];
    layer.lineColor = [MGLStyleValue valueWithRawValue:[UIColor purpleColor]];
    layer.lineWidth = [MGLStyleValue valueWithInterpolationMode:MGLInterpolationModeExponential
                                                        cameraStops: @{
                                                                   @14: [MGLStyleValue valueWithRawValue:@5],
                                                                   @18: [MGLStyleValue valueWithRawValue:@20]
                                                                   }
                                                        options:@{MGLStyleFunctionOptionDefaultValue:@1.75}];
    
    [self.MapView.style addLayer:layer];
}

- (void)animatePolyline {
    // Start a timer that will simulate adding points to our polyline. This could also represent coordinates being added to our polyline from another source, such as a CLLocationManagerDelegate.
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick {

    
    // Create a subarray of locations up to the current index.
    
    // Update our MGLShapeSource with the current locations.
    [self updatePolylineWithLocations:self.locations];
    
}

-(void) updatePolylineWithLocations:(NSArray<CLLocation*>*)locations{
    CLLocationCoordinate2D coordinates[locations.count];
    NSLog(@"Update Poly Line with Locations %lu",(unsigned long) locations.count);

    for (NSUInteger i = 0; i < locations.count; i++) {
        coordinates[i] = locations[i].coordinate;
    }
    
    if (locations.count<=1){//ensure that purple line is trailing the thing
        self.polyline = [MGLPolylineFeature polylineWithCoordinates:coordinates count:locations.count];
    }
    else{
        self.polyline = [MGLPolylineFeature polylineWithCoordinates:coordinates count:locations.count-1];}
    self.polylineSource.shape=self.polyline;
    NSLog(@"2Update Poly Line with Locations %lu",(unsigned long)[locations count]);

}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"REACHED HERE again???");
    NSLog(@"Updating %lu",(unsigned long)[locations count]);

    CLLocation*location = [locations lastObject];
    [self.locations addObject:location];
    NSLog(@"Main Location Updating %lu",(unsigned long)[self.locations count]);

    [self animatePolyline];
    
}


- (void)mapView:(MGLMapView *)mapView didSelectUserLocation:(MGLUserLocation*)location {
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate: location.coordinate fromDistance:4000 pitch:0 heading:0];
    [mapView setCamera:camera animated:true];
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

- (IBAction)UserLocation:(id)sender {
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:MapView.userLocation.coordinate fromDistance:1000 pitch:0 heading:0];
    [MapView setCamera:camera animated:true];
}
@end
