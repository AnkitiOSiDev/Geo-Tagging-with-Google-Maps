//
//  GTUtilty.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTUtilty : NSObject
+ (NSString *)saveImage:(UIImage*)image imageName:(NSString*)strImageName;
+(NSString *) getKeyFrom:(CLLocationCoordinate2D )coordinate;
    + (NSString*)getImageFromImageName:(NSString *)strImageName;
@end

NS_ASSUME_NONNULL_END
