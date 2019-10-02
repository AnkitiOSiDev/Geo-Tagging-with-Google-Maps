//
//  GTMapViewController.m
//  Geo-tagging
//
//  Created by Ankit on 23/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GTUtilty.h"
#import "GTMapMarkerView.h"
#import "GTModuleManager.h"
#import "GTTagModel.h"
#import "GTTagListViewController.h"

typedef void(^ GetImagePath)(NSString *strPath, BOOL iSCancel);

@interface GTMapViewController () <CLLocationManagerDelegate,GMSMapViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GTTagListViewControllerDelegate>
    @end

@implementation GTMapViewController {
    __weak IBOutlet GMSMapView *mapView;
    CLLocationManager *locationManager;
    GetImagePath getImagePathCompletionBlock;
    NSMutableArray *arrTags ;
}
    
#pragma mark - View Life Cycle Methods
    
- (void)viewDidLoad {
    [super viewDidLoad];
    arrTags = [[NSMutableArray alloc] initWithArray: [GTModuleManager.sharedInstance getAllTags]];
    [self initializeMap];
}
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (GTTagModel *tag in arrTags) {
        CLLocationCoordinate2D coordinate =  CLLocationCoordinate2DMake([tag.latitude doubleValue], [tag.longitude doubleValue]);
        [self addMarker:coordinate];
    }
}
    
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [mapView clear];
}
    
-(void)initializeMap {
    locationManager = [[CLLocationManager alloc] init];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDesiredAccuracy:kCLDistanceFilterNone];
    [locationManager startUpdatingLocation];
    mapView.delegate = self;
}
    
    -(void) addMarker:(CLLocationCoordinate2D)coordinate{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = coordinate;
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
    
    - (IBAction)btnTagsListDidClicked:(id)sender {
        GTTagListViewController *vcTagsList = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"GTTagListViewController"];
        vcTagsList.delegate = self;
        vcTagsList.arrTags = arrTags;
        vcTagsList.index = -1;
        [self presentViewController:vcTagsList animated:TRUE completion:nil] ;
    }
    
    -(void) getImagePath:(NSString *) strImageName {
        getImagePathCompletionBlock(strImageName,FALSE);
    }
    
    -(void)selectOption:(GetImagePath)completionBlock {
        getImagePathCompletionBlock = completionBlock;
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Geo Tag"
                                              message:@"Select"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        __weak UIViewController *controller = self;
        [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                [self showAlertWithTitle:@"Warning" andMessage:@"No Camera availabe"];
                return;
            }
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            if (controller != nil) {
                [controller presentViewController:picker animated:YES completion:nil];
            }
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            if (controller != nil) {
                [controller presentViewController:picker animated:YES completion:nil];
            }
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    -(void)showAlertWithTitle:(NSString *)strTitle andMessage:(NSString *)strMessage {
        getImagePathCompletionBlock(nil,TRUE);
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:strTitle
                                              message:strMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
#pragma mark - MapView and CLLocationManager Delegate methods
    
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
    {
    }
    
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    mapView.camera = [GMSCameraPosition cameraWithTarget:[locations objectAtIndex:0].coordinate zoom:12];
    [locationManager stopUpdatingLocation];
}
    
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        [locationManager startUpdatingLocation];
        break;
        
        default:
        [locationManager stopUpdatingLocation];
        break;
    }
}
    
-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    __weak  NSMutableArray *arrweakTags = arrTags;
    [self selectOption:^(NSString *strPath, BOOL iSCancel) {
        if (strPath != nil && !iSCancel) {
            GTTagModel *objTag = [[GTTagModel alloc] initWithCoordinate:coordinate forImage:strPath];
            [GTModuleManager.sharedInstance saveTag:objTag];
            [arrweakTags addObject:objTag];
            [self addMarker:coordinate];
        }
    }];
}
    
    -(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
        GTMapMarkerView *view =  [[[NSBundle mainBundle] loadNibNamed:@"GTMapMarkerView" owner:self options:nil] objectAtIndex:0];
        GTTagModel *tagModel = [GTModuleManager.sharedInstance getTagFor:marker.position];
        view.lblTitle.text = [NSString stringWithFormat: @"Lat %.2f\nLong %.2f",[tagModel.latitude doubleValue],[tagModel.longitude doubleValue]];
        view.imgLogo.image = [UIImage imageWithContentsOfFile:[GTUtilty getImageFromImageName:tagModel.strImageName]];
        return view;
    }
    
    - (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
        int index = 0;
        for (GTTagModel *tag in arrTags) {
            if ([tag.latitude doubleValue] == marker.position.latitude && [tag.longitude doubleValue] == marker.position.longitude) {
                break;
            }
            index = index + 1;
        }
        
        GTTagListViewController *vcTagsList = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"GTTagListViewController"];
        vcTagsList.delegate = self;
        vcTagsList.arrTags = arrTags;
        vcTagsList.index = index;
        [self presentViewController:vcTagsList animated:TRUE completion:nil] ;
    }
    
#pragma mark - Image Picker Delegates
    
    -(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
        getImagePathCompletionBlock(nil,TRUE);
        [picker dismissViewControllerAnimated:TRUE completion:nil];
    }
    
    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
        UIImage   *image    =   [info valueForKey:UIImagePickerControllerOriginalImage];
        NSString *strImageName = [GTUtilty saveImage:image imageName:[NSString stringWithFormat:@"img%f",[NSDate  timeIntervalSinceReferenceDate]]];
        [self getImagePath: strImageName];
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }
    
#pragma mark - GTTagListViewController Delegate methods
    - (void)showMarkerForLatitude:(NSString *)strLatitude longitude:(NSString *)strLongitude {
        CLLocationCoordinate2D coordinate =  CLLocationCoordinate2DMake([strLatitude doubleValue], [strLongitude doubleValue]);
        mapView.camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:12];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = coordinate;
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
        mapView.selectedMarker = marker;
    }
    @end
