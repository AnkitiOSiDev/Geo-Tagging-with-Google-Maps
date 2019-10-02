//
//  GTUserDefaults.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTUserDefaults : NSObject
- (NSMutableDictionary *)getTagForKey:(NSString*)strKey;
- (void)setTag:(NSMutableDictionary *) tag ForKey:(NSString*)strKey;
@end

NS_ASSUME_NONNULL_END
