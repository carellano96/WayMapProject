//
//  MapViewController.m
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "MapViewController.h"
#import "TipsFirstTableViewController.h"
#import "TipsSecondTableViewController.h"
#import "GooglePlace.h"
#import "AddNewPlaceViewController.h"
#import "CustomAnnotation.h"
#import "AppDelegate.h"

@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;

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
AppDelegate*myDelegate;
Boolean correct;
@synthesize MapView,userLocation,LocationsNearby,Annotations,SelectedPlace,MasterLocations,MasterAnnotations,RadiusLabel,RemoveAnnotations,RadiusSlider,UserAddedLocations,CheckedInPlaces,RadiusRemoveAnnotations,FavoritedPlaces,RatedPlaces;
//view loads
- (void)viewDidLoad {
    //allocates memory to relevant arrays
    correct = false;
    CheckedInPlaces =[[NSMutableArray alloc]init];
    FavoritedPlaces = [[NSMutableArray alloc] init];
    MasterLocations=[[NSMutableArray alloc ]init];
    MasterAnnotations=[[NSMutableArray alloc]init];
    LocationsNearby = [[NSMutableArray alloc]init];
    RemoveAnnotations=[[NSMutableArray alloc]init];
    SelectedPlace =[[GooglePlace alloc ]init];
    Annotations= [[NSMutableArray alloc ]init];
    RadiusRemoveAnnotations= [[NSMutableArray alloc ]init];
    UserAddedLocations = [[NSMutableArray alloc ]init];
    RatedPlaces=[[NSMutableArray alloc] init];
    //sets radius sliders
    self.RadiusSlider.minimumValue=20;
    self.RadiusSlider.maximumValue=1000;
    self.tabBarController.delegate=self;
    self.placesClient = [[GMSPlacesClient alloc] init];
    _CurrentIndex=0;
    self.RadiusSlider.value = 510;
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
- (void)viewWillDisappear:(BOOL)animated{
    [self.locationManager stopUpdatingLocation];
}
- (void)tick {

    
    // Update our MGLShapeSource with the current locations.
    [self updatePolylineWithLocations:self.locations];
    
}

-(void) updatePolylineWithLocations:(NSArray<CLLocation*>*)locations{
    //create array of coordinates
    CLLocationCoordinate2D coordinates[locations.count];
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

}

//everytime there is a new location, this function is called

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{//clear locations nearby, annotations, and remove annotations list
    [self.Annotations removeAllObjects];
    //[self.LocationsNearby removeAllObjects];
    [self.RemoveAnnotations removeAllObjects];

    //locations array contains current user location, so we save that location in our own array
    NSLog(@"Main Location Updating %lu",(unsigned long)[self.locations count]);
    if (self.locations.count<=1){
        [self.locations addObject:locations.lastObject];
        myDelegate.UserLocation=locations.lastObject;
    }
    else if (self.locations.count>1){
        CLLocation* PreviousLocation=self.locations[self.locations.count-2];
        CLLocation* CurrentLocation= locations.lastObject;
        CLLocationDistance distances =[CurrentLocation distanceFromLocation:PreviousLocation];
        if (distances>(double)30){
    [self.locations addObject:locations.lastObject];
        myDelegate.UserLocation=locations.lastObject;
        }
    }
//then we animate the line
    [self animatePolyline];
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            //getting from Google API
            GMSPlace* CurrentPlace = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", CurrentPlace.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", CurrentPlace.formattedAddress);
            NSLog(@"Current Place attributions %@", CurrentPlace.attributions);
            NSLog(@"Current PlaceID %@", CurrentPlace.placeID);
            //creating Google Place
            if (![self DoesPlaceExist:CurrentPlace]){
                NSLog(@"new place alert %@",CurrentPlace.name);
            GooglePlace* tempplace = [[GooglePlace alloc] init];
            [tempplace Initiate:CurrentPlace.name:CurrentPlace.placeID :CurrentPlace.coordinate :CurrentPlace.types :CurrentPlace.openNowStatus :CurrentPlace.phoneNumber :CurrentPlace.formattedAddress :CurrentPlace.rating :CurrentPlace.priceLevel :CurrentPlace.website];
            //setting distance for google radius distance
            CLLocation*current = [[CLLocation alloc]initWithLatitude:tempplace.coordinate.latitude longitude:tempplace.coordinate.longitude];
            CLLocationDistance distance = [[locations lastObject] distanceFromLocation:current];
            if (distance<(double)RadiusSlider.value){
                //compare locations with checked in places
                //****figure out checked in places*******
                [LocationsNearby addObject:tempplace];

            }
            //add the object to Masterlocations
            [MasterLocations addObject:tempplace];
            //create the annotation for the point
        
            //add to master annotations as well to update them
        }
    }
        //add temp annotations and checking if any should be there based on radius slider
        for (GooglePlace* check in LocationsNearby){
            if (check.UserAdded){
                continue;
            }
            CustomAnnotation*tempAnnotation = [[CustomAnnotation alloc ]init];
            tempAnnotation.coordinate=check.coordinate;
            tempAnnotation.title=check.name;
            tempAnnotation.UserAdded=false;
            check.AnnotationPointer=tempAnnotation;
            NSLog(@"Locations Nearby contains: %@",check.name);
            userLocation=[locations lastObject];
            CLLocation*current = [[CLLocation alloc]initWithLatitude:check.coordinate.latitude longitude:check.coordinate.longitude];
            CLLocationDistance distance = [[locations lastObject] distanceFromLocation:current];
            if (distance<(double)RadiusSlider.value){
                [Annotations addObject:check.AnnotationPointer];
                [MasterAnnotations addObject:check.AnnotationPointer];

            }
            else{
                [RemoveAnnotations addObject:check.AnnotationPointer];
            }
        }
        
   
        //add user added locations
        for (GooglePlace* userplace in UserAddedLocations){
            NSLog(@"User added place:%@ ",userplace.name);
            CLLocation*current = [[CLLocation alloc]initWithLatitude:userplace.coordinate.latitude longitude:userplace.coordinate.longitude];
            CLLocationDistance distance1 = [[locations lastObject] distanceFromLocation:current];
            if (distance1<(double)RadiusSlider.value){
                CustomAnnotation*tempAnnotation = [[CustomAnnotation alloc ]init];
                tempAnnotation.coordinate=userplace.coordinate;
                tempAnnotation.title=userplace.name;
                tempAnnotation.UserAdded=true;
                userplace.AnnotationPointer=tempAnnotation;
                [Annotations addObject:tempAnnotation];
                [MasterAnnotations addObject:tempAnnotation];
                [MasterLocations addObject:userplace];
                [LocationsNearby addObject:userplace];
                NSLog(@"user place Within range");
            }
            
        }
        //////////////
        ////////////// Checks checked in places list
        if ([CheckedInPlaces count]!=0){
            for (int i=0;i<[LocationsNearby count];i++){
                //finding google place
                GooglePlace* Existing = [LocationsNearby objectAtIndex:i];
                for (GooglePlace*CheckedIn in CheckedInPlaces){
                    if ([CheckedIn.placeID isEqualToString:Existing.placeID]){
                        //add checked in place if it exists
                        [Existing setCheckedIn:true];
                        //[self.LocationsNearby replaceObjectAtIndex:i withObject:Existing];
                        NSLog(@"found checked in place %@",Existing.name);
                    }
                    
                }
            }
        }
        //check favorited places
        if ([FavoritedPlaces count]!=0){
            for (int i=0;i<[LocationsNearby count];i++){
                //finding google place
                GooglePlace* Existing = [LocationsNearby objectAtIndex:i];
                for (GooglePlace*Favorite in FavoritedPlaces){
                    if ([Favorite.placeID isEqualToString:Existing.placeID]){
                        //add favorited place if it exists
                        [Existing setFavorited:true];
                        //[self.LocationsNearby replaceObjectAtIndex:i withObject:Existing];
                        NSLog(@"found favorited place %@",Existing.name);
                    }
                    
                }
            }
        }
        //updates rating in user added locations
        //insert code here//
        if ([RatedPlaces count]!=0){
            for (int i=0;i<[LocationsNearby count];i++){
                GooglePlace* Existing= [LocationsNearby objectAtIndex:i];
                for (GooglePlace* Rated in RatedPlaces){
                    if ([Rated.placeID isEqualToString:Existing.placeID]){
                        [Existing setRated:YES];
                        [Existing setRating:Rated.Rating];
                        NSLog(@"found rated place %d",Existing.Rating);

                    }
                }
            }
        }
        myDelegate.LocationsNearby=self.LocationsNearby;


        //create a RemoveAnnotations array and master list of all locations user went nearby
        //create a UpdateAnnotationsMethod
        //method will iteraate through master list of locations array and check which location is more than 5 miles of the user
        //if it is more than x miles, add to remove array
        //else add to the annotations array
        //after for loop, add annotations and remove relevant annotations
        [self.MapView addAnnotations:Annotations];
        [self UpdateAnnotationsMethod:[locations lastObject]];
        [self.MapView removeAnnotations:RemoveAnnotations];

    }];
    
   

    int count=0;
    NSLog(@"Count for MapView of LikelyList is:%d",count);
    NSLog(@"type of delegate is %@",self.tabBarController.delegate);
    
}
- (BOOL) DoesPlaceExist:(GMSPlace*)NewPlace{
    
    for (GooglePlace* ExistingPlace in LocationsNearby){
        if ([ExistingPlace.placeID isEqualToString:NewPlace.placeID]&&[ExistingPlace.name isEqualToString:NewPlace.name]){
            NSLog(@"This place is in our array already: %@",ExistingPlace.name);
            //If this place exists already in our array, return true
            return true;
        }
    }//else if it doesn't exist return false
    return false;
}
//If you tap on a purple dot, the label appears for the name of the place and sends the user to the view controller with the name of the place
- (void) UpdateAnnotationsMethod:(CLLocation* )User{
    NSMutableArray* LocationRemove = [[NSMutableArray alloc]init];
    for (GooglePlace* place in LocationsNearby){
        NSLog(@"Things in locations nearby location: %@",place.name);
        CLLocation*current = [[CLLocation alloc]initWithLatitude:place.AnnotationPointer.coordinate.latitude longitude:place.AnnotationPointer.coordinate.longitude];
        CLLocationDistance distance = [User distanceFromLocation:current];
        if (distance>(double)RadiusSlider.value){
            NSLog(@"Removing annotation: %@",place.name);
            [RemoveAnnotations addObject:place.AnnotationPointer];
            [LocationRemove addObject:place];
        }
        
    }
    [LocationsNearby removeObjectsInArray:LocationRemove];
    for (CustomAnnotation* annotation1 in MasterAnnotations){
        CLLocation*current = [[CLLocation alloc]initWithLatitude:annotation1.coordinate.latitude longitude:annotation1.coordinate.longitude];
        CLLocationDistance distance = [[_locations lastObject] distanceFromLocation:current];
        if (distance>(double)RadiusSlider.value){
            [RemoveAnnotations addObject:annotation1];
        }
    }
}
//slider value changes which causes the annotations to change
- (IBAction)sliderValueChanged:(id)sender {
    [self.locationManager stopUpdatingLocation];
    float Feet = (RadiusSlider.value)*3.28084;
    [RadiusLabel setAlpha:0.0f];
    RadiusLabel.text=[[NSString alloc]initWithFormat:@"%.1f feet",Feet];
    [RadiusLabel setAlpha:1.0f];
    //fade out
    [UIView animateWithDuration:2.0f animations:^{
            
            [RadiusLabel setAlpha:0.0f];
            
        } completion:nil];
        
    //[self UpdateLocationsNearby:[self.locations lastObject]];
    correct=true;
    //[self UpdateAnnotationsMethod:[self.locations lastObject]];
    //[self.MapView removeAnnotations:RemoveAnnotations];
    [RadiusRemoveAnnotations removeAllObjects];
    for (GooglePlace* currentplace in LocationsNearby){
        CLLocation*current = [[CLLocation alloc]initWithLatitude:currentplace.coordinate.latitude longitude:currentplace.coordinate.longitude];
        CLLocationDistance distance1 = [[_locations lastObject] distanceFromLocation:current];
        if (distance1>(double)RadiusSlider.value){
            if ([self.MapView.annotations containsObject:currentplace.AnnotationPointer]){
                NSLog(@"does contain annotation");
               
            }
            [RadiusRemoveAnnotations addObject:currentplace.AnnotationPointer];
        }
        

    }
    [self.MapView removeAnnotations:RadiusRemoveAnnotations];
    [self.locationManager startUpdatingLocation];
}
//updates all locations nearby based on the slider
- (void) UpdateLocationsNearby:(CLLocation* )User{
    for (GooglePlace* place in LocationsNearby){
        CLLocation*current = [[CLLocation alloc]initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
        CLLocationDistance distance = [User distanceFromLocation:current];
        if (distance>(double)RadiusSlider.value){
            [LocationsNearby removeObject:place];
        }
        
    }
    
}
//unwind segues
- (IBAction)backToStart:(UIStoryboardSegue*) segue{
    NSLog(@"Returned!");
}
//unwind segue from the Add new Place
- (IBAction)backToStartFromAdding:(UIStoryboardSegue*) segue{
    NSLog(@"Returned from adding!");
    AddNewPlaceViewController* placeView = [segue sourceViewController];
    if (placeView.AddedLocation==true){
        GooglePlace*UserPlace=placeView.UserAddedPlace;
        NSLog(@"new added place is %@",UserPlace.name);
    [UserAddedLocations addObject:UserPlace];
        myDelegate.UserAddedLocations=UserAddedLocations;

        NSLog(@"saved, adding new locaiton!");

    }
    
}
//when the user taps on an annotation, then taps on callout, it takes user to Places Info View Controller
-(void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id<MGLAnnotation>)annotation{
    NSLog(@"Looking");
    for (GooglePlace* location in LocationsNearby){
        NSLog(@"Looking, currently at %@",location.name);
        NSLog(@"Annotation name is %@",annotation.title);
        if ([annotation.title isEqualToString:location.name]){
            SelectedPlace=location;
            NSLog(@"Checked in; %d favorited %d",location.CheckedIn,location.Favorited);
            
            NSLog(@"Found selected place: name %@",SelectedPlace.name);
            break;
        }
    }
    [self performSegueWithIdentifier:@"tapToLocation" sender:self];
}
//segue for the location information view controller
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
//everytime the view appears, we update the locations, their ratings, user added locations, checked in places, retrieving data from firebase
-(void) viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = NO;
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FIRUser *user = [FIRAuth auth].currentUser;
    [self.CheckedInPlaces removeAllObjects];
    [self.FavoritedPlaces removeAllObjects];
    [self.RatedPlaces removeAllObjects];
    [self.UserAddedLocations removeAllObjects];
    [self.locationManager startUpdatingLocation];
    self.ref = [[FIRDatabase database] reference];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Visited"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *VisitedPlace in snapshot.children){
            NSString *key = VisitedPlace.key;
            NSDictionary *checkedInPlacesDict = VisitedPlace.value;
            [checkedInPlacesDict objectForKey:key];
            GooglePlace *googletemp = [[GooglePlace alloc]init];
            googletemp.name =[checkedInPlacesDict objectForKey:@"Name"];
            googletemp.formattedAddress=[checkedInPlacesDict objectForKey:@"Address"];
            googletemp.placeID=[checkedInPlacesDict objectForKey:@"placeID"];
            [CheckedInPlaces addObject:googletemp];
        }
    }];
    [[[[_ref child:@"users"] child:user.uid] child:@"Favorite Places"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *favoritePlace in snapshot.children){
            NSString *key = favoritePlace.key;
            NSDictionary *favPlacesDict = favoritePlace.value;
            [favPlacesDict objectForKey:key];
            GooglePlace *googletemp = [[GooglePlace alloc]init];
            googletemp.name =[favPlacesDict objectForKey:@"Name"];
            googletemp.formattedAddress=[favPlacesDict objectForKey:@"Address"];
            googletemp.placeID=[favPlacesDict objectForKey:@"placeID"];
            [FavoritedPlaces addObject:googletemp];
        }
    }];
    [[[[_ref child:@"users"] child:user.uid] child:@"Rated Places"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        for (FIRDataSnapshot *ratedPlace in snapshot.children){
            NSString *key = ratedPlace.key;
            NSDictionary *ratedPlacesDict = ratedPlace.value;
            [ratedPlacesDict objectForKey:key];
            GooglePlace *tempplace = [[GooglePlace alloc]init];
            tempplace.placeID=[ratedPlacesDict objectForKey:@"placeID"];
            NSInteger RatingInteger =[[ratedPlacesDict objectForKey:@"User's Place Rating"] integerValue];
            tempplace.Rating=(int)RatingInteger;
            NSLog(@"temp place rating is %d",(int)RatingInteger);
            [RatedPlaces addObject:tempplace];
        }
    }];
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Added"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        for (FIRDataSnapshot *AddedPlace in snapshot.children){
            NSString *key = AddedPlace.key;
            NSDictionary *AddedPlacesDict = AddedPlace.value;
            [AddedPlacesDict objectForKey:key];
            GooglePlace *tempplace = [[GooglePlace alloc]init];
            tempplace.placeID=[AddedPlacesDict objectForKey:@"placeID"];
            tempplace.name=[AddedPlacesDict objectForKey:@"Name"];
            tempplace.formattedAddress=[AddedPlacesDict objectForKey:@"Address"];
            NSString*Type =[AddedPlacesDict objectForKey:@"Type"];
            NSMutableArray* Types = [[NSMutableArray alloc] initWithObjects:Type, nil];
            tempplace.types=Types;
            NSString* StringLatitude =[AddedPlacesDict objectForKey:@"Latitude"];
            NSString*StringLongitude =[AddedPlacesDict objectForKey:@"Longitude"];
            tempplace.coordinate=    CLLocationCoordinate2DMake([StringLatitude doubleValue], [StringLongitude doubleValue]);
            tempplace.UserAdded=true;
            [UserAddedLocations addObject:tempplace];
        }
    }];
//puts data in the delegate view controller for later use
    myDelegate.CheckInLocations=CheckedInPlaces;
    myDelegate.FavoritedPlaces=FavoritedPlaces;
    myDelegate.LocationsNearby=LocationsNearby;
    myDelegate.UserAddedLocations=UserAddedLocations;
    myDelegate.RatedPlaces=RatedPlaces;
    self.tabBarController.delegate=self;
    [self.LocationsNearby removeAllObjects];


}
//sets image as either purple dot or blue dot, depending if its a user added location
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


//if the user selects another tab view controller, it sends relevant information
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"TYPE OF CONTROLLER:%@",NSStringFromClass([viewController class]));
    if ([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController*Tips1 = (UINavigationController*)viewController;
        if ([Tips1.visibleViewController isKindOfClass:[TipsFirstTableViewController class]]){TipsFirstTableViewController*Tips=(TipsFirstTableViewController*)Tips1.visibleViewController;
        //Tips.NearbyLocations=self.LocationsNearby;
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
