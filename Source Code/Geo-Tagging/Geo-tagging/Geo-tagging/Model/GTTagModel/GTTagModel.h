//
//  GTTagModel.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag+CoreDataClass.h"
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTagModel : NSObject
    @property (nonatomic, strong) NSString *strImageName;
    @property (nonatomic, strong) NSString *strIndex;
    @property (nonatomic, strong) NSString *latitude;
    @property (nonatomic, strong) NSString *longitude;
    
    - (instancetype)initWithEntity:(Tag *)tagEntity;
    - (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate forImage:(NSString *) strPath;
@end

NS_ASSUME_NONNULL_END
