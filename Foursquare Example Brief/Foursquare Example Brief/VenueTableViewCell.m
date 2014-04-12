//
//  FoursquareTableViewCell.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueTableViewCell.h"
#import "VenueRatingView.h"
#import "Venue.h"
#import "VenueLocation.h"
#import "VenueCategory.h"
#import "XDUtilities.h"

@interface VenueTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet VenueRatingView *ratingView;

@end

@implementation VenueTableViewCell
@synthesize nameLabel, categoryLabel, addressLabel, distanceLabel, ratingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVenueObject:(Venue *) venueObject {
    nameLabel.text = venueObject.name;
    addressLabel.text = venueObject.location.address != nil ? venueObject.location.address : @"No Address Given";
    VenueCategory *mainCategory = [venueObject getMainCategory];
    categoryLabel.text = mainCategory != nil ? mainCategory.name : @"Uncategorised";
    
    float miles = [XDUtilities metersToMilesFromNumber:venueObject.location.distance];
    NSString *milesStr = [NSString stringWithFormat:@"%.1f", miles];
    distanceLabel.text = [NSString stringWithFormat:@"(%@ %@)", milesStr, NSLocalizedString(@"miles", nil)];
    [ratingView setRating:venueObject.rating];
}

@end
