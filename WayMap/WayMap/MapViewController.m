//
//  MapViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "MapViewController.h"
#import "TipsFirstTableViewController.h"

@interface MapViewController (){
    int _CurrentIndex;

    NSTimer *_timer;
    CLLocationCoordinate2D*coordinate;
    
}

@property (nonatomic) MGLShapeSource *polylineSource;
@property (nonatomic) MGLPolyline *polyline;
@property (nonatomic) NSMutableArray<CLLocation *> *locations;
@property CLLocationManager* locationManager;
@property GMSPlacesClient* placesClient;
@end

@implementation MapViewController
@synthesize MapView,LikelyList;
//view loads
- (void)viewDidLoad {
    
    self.tabBarController.delegate=self;
    LikelyList=[[GMSPlaceLikelihoodList alloc ]init];
    self.placesClient = [[GMSPlacesClient alloc] init];
    _CurrentIndex=0;
    [super viewDidLoad];
    //creates an array of locations that will be stored for t
    self.locations=[[NSMutableArray alloc] init];
    //creates a line upon loading app
     self.polylineSource = [[MGLShapeSource alloc] initWithIdentifier:@"polyline" features:@[] options:nil];
    //creates the location manager which will help us in tracking
    self.locationManager = [[CLLocationManager alloc] init];
    //sets location manager delegate as the VC
    self.locationManager.delegate=self;
    //sets desired accuracy
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    //updates user location every second
    [self.locationManager startUpdatingLocation];
    //sets delegate and shows user location
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
    //after map finishing loading initially, creates the line layer
    [self addLayer:self.polylineSource];
    MGLPointAnnotation* annotation = [[MGLPointAnnotation alloc ] init];
    
    //tracks user to follow them on map
    annotation.coordinate=CLLocationCoordinate2DMake(37.785834, -122.406417);
    annotation.title= @"Test";
    annotation.subtitle=@"TestPoint";
    [MapView addAnnotation:annotation];

}

- (MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation {
    // Try to reuse the existing ‘pisa’ annotation image, if it exists.
    MGLAnnotationImage *annotationImage = [mapView dequeueReusableAnnotationImageWithIdentifier:@"purpledot"];
    
    // If the ‘pisa’ annotation image hasn‘t been set yet, initialize it here.
    if (!annotationImage) {
        // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
        UIImage *image = [UIImage imageNamed:@"purpledot"];
        
        // The anchor point of an annotation is currently always the center. To
        // shift the anchor point to the bottom of the annotation, the image
        // asset includes transparent bottom padding equal to the original image
        // height.
        //
        // To make this padding non-interactive, we create another image object
        // with a custom alignment rect that excludes the padding.
        image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, image.size.height/2, 0)];
        
        // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
        annotationImage = [MGLAnnotationImage annotationImageWithImage:image reuseIdentifier:@"purpledot"];
    }
    
    return annotationImage;
}

- (void)addLayer:(MGLShapeSource *)source {
    // Add an empty MGLShapeSource, we’ll keep a reference to this and add points to this later.
    [self.MapView.style addSource:self.polylineSource];
    // Add a layer to style our polyline.
    MGLLineStyleLayer *layer = [[MGLLineStyleLayer alloc] initWithIdentifier:@"polyline" source:source];
    //a bunch of layer styling stuff
    layer.lineJoin = [MGLStyleValue valueWithRawValue:[NSValue valueWithMGLLineJoin:MGLLineJoinRound]];
    layer.lineCap = [MGLStyleValue valueWithRawValue:[NSValue valueWithMGLLineCap:MGLLineCapRound]];
    layer.lineColor = [MGLStyleValue valueWithRawValue:[UIColor purpleColor]];
    layer.lineWidth = [MGLStyleValue valueWithInterpolationMode:MGLInterpolationModeExponential
                                                        cameraStops: @{
                                                                   @14: [MGLStyleValue valueWithRawValue:@5],
                                                                   @18: [MGLStyleValue valueWithRawValue:@20]
                                                                   }
                                                        options:@{MGLStyleFunctionOptionDefaultValue:@1.75}];
    //add the layer
    [self.MapView.style addLayer:layer];
}

- (void)animatePolyline {
    // Start a timer that will simulate adding points to our polyline. This could also represent coordinates being added to our polyline from another source, such as a CLLocationManagerDelegate.
    //create a timer to continuosly update the polyline
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick {

    
    // Update our MGLShapeSource with the current locations.
    [self updatePolylineWithLocations:self.locations];
    
}

-(void) updatePolylineWithLocations:(NSArray<CLLocation*>*)locations{
    //create array of coordinates
    CLLocationCoordinate2D coordinates[locations.count];
    NSLog(@"Update Poly Line with Locations %lu",(unsigned long) locations.count);
//update coordinates
    for (NSUInteger i = 0; i < locations.count; i++) {
        coordinates[i] = locations[i].coordinate;
    }
    
    if (locations.count<=1){//ensure that purple line is trailing the user location
        self.polyline = [MGLPolylineFeature polylineWithCoordinates:coordinates count:locations.count];
    }
    else{
        self.polyline = [MGLPolylineFeature polylineWithCoordinates:coordinates count:locations.count-1];}
    //makes the shape of the layer the line
    self.polylineSource.shape=self.polyline;
    NSLog(@"2Update Poly Line with Locations %lu",(unsigned long)[locations count]);;

}

//everytime there is a new location, this function is called

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"Updating %lu",(unsigned long)[locations count]);
    //locations array contains current user location, so we save that location in our own array
    CLLocation*location = [locations lastObject];
    [self.locations addObject:location];
    CLCircularRegion *region =[[CLCircularRegion alloc] initWithCenter:location.coordinate radius:500 identifier:@"CurrentRegion"];
    
    NSLog(@"Main Location Updating %lu",(unsigned long)[self.locations count]);
//then we animate the line
    [self animatePolyline];
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* place = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", place.formattedAddress);
            NSLog(@"Current Place attributions %@", place.attributions);
            NSLog(@"Current PlaceID %@", place.placeID);
        }
        self.LikelyList=likelihoodList;

        
    }];
    int count=0;
    for (GMSPlaceLikelihood *likehood in self.LikelyList.likelihoods){
        NSLog(@"LIKELY LIST PLACE CAUGHT!!!");
        count++;
        GMSPlace* place = likehood.place;
        NSLog(@"Current Place name %@ at likelihood %g", place.name, likehood.likelihood);
    }
    NSLog(@"Count for MapView of LikelyList is:%d",count);
    
}



//this is if the user selects their own location
- (void)mapView:(MGLMapView *)mapView didSelectUserLocation:(MGLUserLocation*)location {
    
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate: location.coordinate fromDistance:500 pitch:0 heading:0];
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
//button that shows user location when pressed
- (IBAction)UserLocation:(id)sender {
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:MapView.userLocation.coordinate fromDistance:1000 pitch:0 heading:0];
    [MapView setCamera:camera animated:true];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"TYPE OF CONTROLLER:%@",NSStringFromClass([viewController class]));
    if ([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController*Tips1 = (UINavigationController*)viewController;
        TipsFirstTableViewController*Tips=(TipsFirstTableViewController*)Tips1.visibleViewController;
        Tips.LikelyList=self.LikelyList;
        NSLog(@"Switching view controllers to TipsFirst");
        
    }
}
@end
