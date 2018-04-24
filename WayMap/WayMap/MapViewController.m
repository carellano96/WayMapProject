//
//  MapViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "MapViewController.h"
#import "TipsFirstTableViewController.h"
#import "TipsSecondTableViewController.h"
#import "GooglePlace.h"
#import "AddNewPlaceViewController.h"
#import "CustomAnnotation.h"
#import "AppDelegate.h"

@interface MapViewController (){
    int _CurrentIndex;

    NSTimer *_timer;
    CLLocationCoordinate2D*coordinate;
    
}

@property (nonatomic) MGLShapeSource *polylineSource;
@property (nonatomic) MGLPolyline *polyline;
@property (nonatomic) NSMutableArray<CLLocation *> *locations;
@property CLLocationManager* locationManager;
@property GMSPlacesClient* placesClient; //client to get information
@end

@implementation MapViewController
@synthesize MapView,userLocation,LocationsNearby,Annotations,SelectedPlace,MasterLocations,MasterAnnotations,RadiusLabel,RemoveAnnotations,RadiusSlider,UserAddedLocations,CheckedInPlaces;
//view loads
- (void)viewDidLoad {
    CheckedInPlaces =[[NSMutableArray alloc]init];
    MasterLocations=[[NSMutableArray alloc ]init];
    MasterAnnotations=[[NSMutableArray alloc]init];
    LocationsNearby = [[NSMutableArray alloc]init];
    RemoveAnnotations=[[NSMutableArray alloc]init];
    SelectedPlace =[[GooglePlace alloc ]init];
    Annotations= [[NSMutableArray alloc ]init];
    UserAddedLocations = [[NSMutableArray alloc ]init];
    self.RadiusSlider.minimumValue=20;
    self.RadiusSlider.maximumValue=1000;
    self.tabBarController.delegate=self;
    self.placesClient = [[GMSPlacesClient alloc] init];
    _CurrentIndex=0;
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
    self.MapView.delegate=self;
    self.MapView.showsUserLocation=YES;
    userLocation = [[CLLocation alloc] initWithLatitude:MapView.userLocation.location.coordinate.latitude longitude:MapView.userLocation.location.coordinate.longitude];

    [MapView.self setUserTrackingMode:MGLUserTrackingModeFollow];
    [self mapView:MapView didSelectUserLocation:MapView.userLocation];
    [self.locationManager requestAlwaysAuthorization];
    
    // For use in foreground
    [self.locationManager requestWhenInUseAuthorization];
    

    [self.locationManager startUpdatingLocation];

    //[self.MapView setCenterCoordinate:MapView.userLocation.coordinate zoomLevel:11 animated:YES];
    // Do any additional setup after loading the view.
    //Fun new stuff
    
    [super viewDidLoad];


    
}

- (void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style {
    //after map finishing loading initially, creates the line layer
    [self addLayer:self.polylineSource];
    

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
    [self.Annotations removeAllObjects];
    [self.LocationsNearby removeAllObjects];
    [self.RemoveAnnotations removeAllObjects];
    NSLog(@"Updating %lu",(unsigned long)[locations count]);
    //locations array contains current user location, so we save that location in our own array
    NSLog(@"Main Location Updating %lu",(unsigned long)[self.locations count]);
    [self.locations addObject:locations.lastObject];
//then we animate the line
    [self animatePolyline];
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* CurrentPlace = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", CurrentPlace.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", CurrentPlace.formattedAddress);
            NSLog(@"Current Place attributions %@", CurrentPlace.attributions);
            NSLog(@"Current PlaceID %@", CurrentPlace.placeID);
            GooglePlace* tempplace = [[GooglePlace alloc] init];
            [tempplace Initiate:CurrentPlace.name:CurrentPlace.placeID :CurrentPlace.coordinate :CurrentPlace.types :CurrentPlace.openNowStatus :CurrentPlace.phoneNumber :CurrentPlace.formattedAddress :CurrentPlace.rating :CurrentPlace.priceLevel :CurrentPlace.website];
            CLLocation*current = [[CLLocation alloc]initWithLatitude:tempplace.coordinate.latitude longitude:tempplace.coordinate.longitude];
            CLLocationDistance distance = [[locations lastObject] distanceFromLocation:current];
            if (distance<(double)RadiusSlider.value){
                if ([CheckedInPlaces count]!=0){
                for (GooglePlace*place1 in CheckedInPlaces){
                    if ([place1.placeID isEqualToString:tempplace.placeID]){
                        //add checked in place
                        [LocationsNearby addObject:place1];
                    }
                    else{
                        //add none checked in places
                        [LocationsNearby addObject:tempplace];
                    }
                }
                }
                else{
                    [LocationsNearby addObject:tempplace];
                }
            }
            [MasterLocations addObject:tempplace];
            CustomAnnotation*tempAnnotation = [[CustomAnnotation alloc ]init];
            tempAnnotation.coordinate=tempplace.coordinate;
            tempAnnotation.title=tempplace.name;
            tempAnnotation.UserAdded=false;
            tempplace.AnnotationPointer=tempAnnotation;
            [Annotations addObject:tempAnnotation];
            [MasterAnnotations addObject:tempAnnotation];
            userLocation=[locations lastObject];
        }
        for (GooglePlace* userplace in UserAddedLocations){
            NSLog(@"User added place:%@ ",userplace.name);
            CLLocation*current = [[CLLocation alloc]initWithLatitude:userplace.coordinate.latitude longitude:userplace.coordinate.longitude];
            CLLocationDistance distance1 = [[locations lastObject] distanceFromLocation:current];
            if (distance1<(double)RadiusSlider.value){
                [LocationsNearby addObject:userplace];
                NSLog(@"user place Within range");
            }
            CustomAnnotation*tempAnnotation = [[CustomAnnotation alloc ]init];
            tempAnnotation.coordinate=userplace.coordinate;
            tempAnnotation.title=userplace.name;
            tempAnnotation.UserAdded=true;
            userplace.AnnotationPointer=tempAnnotation;
            [Annotations addObject:tempAnnotation];
            [MasterAnnotations addObject:tempAnnotation];
            [MasterLocations addObject:userplace];
        }
        

        //create a RemoveAnnotations array and master list of all locations user went nearby
        //create a UpdateAnnotationsMethod
        //method will iteraate through master list of locations array and check which location is more than 5 miles of the user
        //if it is more than 5 miles, add to remove array
        //else add to the annotations array
        //after for loop, add annotations and remove relevant annotations
        [self.MapView addAnnotations:Annotations];
        [self UpdateAnnotationsMethod:[locations lastObject]];
        [self.MapView removeAnnotations:RemoveAnnotations];
        NSLog(@"Removing annotations");

    }];
    
   

    int count=0;
    NSLog(@"Count for MapView of LikelyList is:%d",count);
    NSLog(@"type of delegate is %@",self.tabBarController.delegate);
    
}
//If you tap on a purple dot, the label appears for the name of the place and sends the user to the view controller with the name of the place
- (void) UpdateAnnotationsMethod:(CLLocation* )User{
    for (GooglePlace* place in MasterLocations){
        CLLocation*current = [[CLLocation alloc]initWithLatitude:place.AnnotationPointer.coordinate.latitude longitude:place.AnnotationPointer.coordinate.longitude];
        CLLocationDistance distance = [User distanceFromLocation:current];
        if (distance>(double)RadiusSlider.value){
            [RemoveAnnotations addObject:place.AnnotationPointer];
        }
        
    }
}
- (IBAction)sliderValueChanged:(id)sender {
    float Feet = (RadiusSlider.value)*3.28084;
    [RadiusLabel setAlpha:0.0f];
    RadiusLabel.text=[[NSString alloc]initWithFormat:@"%.1f feet",Feet];
    [RadiusLabel setAlpha:1.0f];
    //fade in
    [UIView animateWithDuration:2.0f animations:^{
            
            [RadiusLabel setAlpha:0.0f];
            
        } completion:nil];
        
    
    //[self UpdateAnnotationsMethod:userLocation];
    //[self UpdateLocationsNearby:userLocation];
}
- (void) UpdateLocationsNearby:(CLLocation* )User{
    for (GooglePlace* place in LocationsNearby){
        CLLocation*current = [[CLLocation alloc]initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
        CLLocationDistance distance = [User distanceFromLocation:current];
        if (distance>(double)RadiusSlider.value){
            [LocationsNearby removeObject:place];
        }
        
    }
}

- (IBAction)backToStart:(UIStoryboardSegue*) segue{
    NSLog(@"Returned!");
}
- (IBAction)backToStartFromAdding:(UIStoryboardSegue*) segue{
    NSLog(@"Returned from adding!");
    AddNewPlaceViewController* placeView = [segue sourceViewController];
    if (placeView.AddedLocation==true){
        GooglePlace*UserPlace=placeView.UserAddedPlace;
        NSLog(@"new added place is %@",UserPlace.name);
    [UserAddedLocations addObject:UserPlace];
        NSLog(@"saved, adding new locaiton!");

    }
    
}

-(void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id<MGLAnnotation>)annotation{
    NSLog(@"Looking");
    for (GooglePlace* location in LocationsNearby){
        NSLog(@"Looking, currently at %@",location.name);
        NSLog(@"Annotation name is %@",annotation.title);
        if ([annotation.title isEqualToString:location.name]){
            SelectedPlace=location;
            
            NSLog(@"Found selected place: name %@",SelectedPlace.name);
            break;
        }
    }
    [self performSegueWithIdentifier:@"tapToLocation" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"tapToLocation"]){
        PlacesInformationViewController* Info = [segue destinationViewController];
        Info.SelectedPlace=self.SelectedPlace;
        Info.segueUsed=segue.identifier;
    }
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

-(void) viewWillAppear:(BOOL)animated{
        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CheckedInPlaces=myDelegate.CheckInLocations;
    if ([CheckedInPlaces count]!=0){
        GooglePlace*place =[CheckedInPlaces objectAtIndex:0];
        NSLog(@"checked in place is %@", place.name);
    }
    self.tabBarController.delegate=self;
    [self.LocationsNearby removeAllObjects];
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* CurrentPlace = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", CurrentPlace.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", CurrentPlace.formattedAddress);
            NSLog(@"Current Place attributions %@", CurrentPlace.attributions);
            NSLog(@"Current PlaceID %@", CurrentPlace.placeID);
            GooglePlace* tempplace = [[GooglePlace alloc] init];
            [tempplace Initiate:CurrentPlace.name:CurrentPlace.placeID :CurrentPlace.coordinate :CurrentPlace.types :CurrentPlace.openNowStatus :CurrentPlace.phoneNumber :CurrentPlace.formattedAddress :CurrentPlace.rating :CurrentPlace.priceLevel :CurrentPlace.website];
            [LocationsNearby addObject:tempplace];
        }
        
        
    }];

}

- (MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation {
    // Try to reuse the existing ‘pisa’ annotation image, if it exists.
    CustomAnnotation *currentanno = (CustomAnnotation*)annotation;
    NSLog(@"current anno %d",currentanno.UserAdded);
    MGLAnnotationImage *annotationImage;
    if (!currentanno.UserAdded){
        annotationImage = [mapView dequeueReusableAnnotationImageWithIdentifier:@"purpledot"];}
    else if (currentanno.UserAdded){
        annotationImage = [mapView dequeueReusableAnnotationImageWithIdentifier:@"bluediamond"];}
    // If the ‘pisa’ annotation image hasn‘t been set yet, initialize it here.
    
    if (!annotationImage) {
        if (!currentanno.UserAdded){
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
        else if (currentanno.UserAdded){
            UIImage *image = [UIImage imageNamed:@"bluediamond"];
            
            // The anchor point of an annotation is currently always the center. To
            // shift the anchor point to the bottom of the annotation, the image
            // asset includes transparent bottom padding equal to the original image
            // height.
            //
            // To make this padding non-interactive, we create another image object
            // with a custom alignment rect that excludes the padding.
            image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, image.size.height/2, 0)];
            
            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
            annotationImage = [MGLAnnotationImage annotationImageWithImage:image reuseIdentifier:@"bluediamond"];
        }
    }
    NSLog(@"making the dot");
    
    return annotationImage;
}
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always allow callouts to popup when annotations are tapped.
    return YES;
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"TYPE OF CONTROLLER:%@",NSStringFromClass([viewController class]));
    if ([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController*Tips1 = (UINavigationController*)viewController;
        if ([Tips1.visibleViewController isKindOfClass:[TipsFirstTableViewController class]]){TipsFirstTableViewController*Tips=(TipsFirstTableViewController*)Tips1.visibleViewController;
        Tips.NearbyLocations=self.LocationsNearby;
            Tips.userLocation=self.userLocation;
            Tips.index=1;
        NSLog(@"Switching view controllers to TipsFirst");
            }
        else if ([Tips1.visibleViewController isKindOfClass:[TipsSecondTableViewController class]]){
            TipsSecondTableViewController *Tips2 = (TipsSecondTableViewController*)Tips1.visibleViewController;
            Tips2.userLocation=self.userLocation;
            NSLog(@"Switching view controllers to SecondTipsFirst");

        }
        else{
            NSLog(@"Type of current view %@",NSStringFromClass([Tips1.visibleViewController class]));
        }
    }
    
    return YES;
}
@end
