//
//  XDMapViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDMapViewController.h"
#import <RestKit/CoreData.h>
#import "XDUtilities.h"
#import "VenueLocation.h"
#import "Venue.h"

@interface XDMapViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation XDMapViewController

@synthesize fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"VenueLocation"];
    
    // Sort venues by distance
    NSSortDescriptor *distanceDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
    fetchRequest.sortDescriptors = @[distanceDescriptor];
    
    // Setup fetched results
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                     sectionNameKeyPath:nil
                                                                              cacheName:@"MapViewCache"]; // TODO - caching?
    [fetchedResultsController setDelegate:self];
    
    [self refreshAnnotations];
}

- (void) refreshAnnotations {
    NSError *error = nil;
    BOOL fetchSuccessful = [fetchedResultsController performFetch:&error];
    if (!fetchSuccessful) {
        [XDUtilities showAlert:@"Venue Map Error" withMessage:error.description];
    } else {
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotations:[fetchedResultsController fetchedObjects]];
    }
}


- (void)centerMapOnDefaultCoords {
    NSDictionary *mapDictionary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Default map info"];
    NSNumber *latitude = [mapDictionary objectForKey:@"Latitude"];
    NSNumber *longitude = [mapDictionary objectForKey:@"Longitude"];
    NSNumber *mileReach = [mapDictionary objectForKey:@"Mile reach"];
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    // display a mile - good enough region
    int meterReach = [XDUtilities milesToMetersFromNumber:mileReach];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, meterReach, meterReach);
    [_mapView setRegion:viewRegion animated:YES];
    
}
     
- (CLLocationCoordinate2D) getUserLocation {
    MKUserLocation *userLoc = [_mapView userLocation];
    return [userLoc.location coordinate];
}

- (MKPinAnnotationColor) pinColorForQueryType:(NSString*) queryType {
    NSArray *viableQueries = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare queries"];
    
    // only support two queries here
    if ([queryType isEqualToString:[viableQueries objectAtIndex:0]]) {
        return MKPinAnnotationColorGreen;
    } else if ([queryType isEqualToString:[viableQueries objectAtIndex:1]]) {
        return MKPinAnnotationColorPurple;
    } else {
       return MKPinAnnotationColorRed;
    }
}

#pragma mark - MKMapView delegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"VenueLocation";
    if ([annotation isKindOfClass:[VenueLocation class]]) {
        VenueLocation *venueLocation = (VenueLocation*)annotation;
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinAnnotationView.enabled = YES;
            pinAnnotationView.animatesDrop = YES;
            pinAnnotationView.canShowCallout = YES;
        } else {
            pinAnnotationView.annotation = annotation;
        }
        NSString *venueQueryType = [venueLocation.venue getQueryType];
        pinAnnotationView.pinColor = [self pinColorForQueryType:venueQueryType];
        
        return pinAnnotationView;
    }
    
    return nil;
}

#pragma mark - NSFetchedResultsControllerDelegate methods
- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self fetchedResultsChangeInsert:anObject];
            break;
        case NSFetchedResultsChangeDelete:
            [self fetchedResultsChangeDelete:anObject];
            break;
        case NSFetchedResultsChangeUpdate:
            [self fetchedResultsChangeUpdate:anObject];
            break;
        case NSFetchedResultsChangeMove:
            // do nothing
            break;
            
        default:
            break;
    }
}

- (void)fetchedResultsChangeInsert:(VenueLocation *) venueLocation {
    [self.mapView addAnnotation:venueLocation];
}

- (void)fetchedResultsChangeDelete:(VenueLocation *) venueLocation {
    [self.mapView removeAnnotation:venueLocation];
}

- (void)fetchedResultsChangeUpdate:(VenueLocation *) venueLocation {
    [self fetchedResultsChangeDelete:venueLocation];
    [self fetchedResultsChangeInsert:venueLocation];
}

@end
