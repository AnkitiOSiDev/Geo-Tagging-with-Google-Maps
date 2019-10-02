//
//  GTDatabaseManager.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GTTagModel.h"
#import "GTCoreDataManager.h"
#import "GTUtilty.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTDatabaseManager : NSObject
    - (void) saveTag:(GTTagModel *)tagModel;
    -(GTTagModel *) getTagFor:(CLLocationCoordinate2D )coordinate;
    -(NSArray*) getAllTags;
@end

NS_ASSUME_NONNULL_END
