//
//  GTUserDefaults.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTUserDefaults.h"

@implementation GTUserDefaults

    - (NSMutableDictionary *)getTagForKey:(NSString*)strKey{
       return  [[NSUserDefaults standardUserDefaults] objectForKey:strKey];
    }
    
- (void)setTag:(NSMutableDictionary *)tag ForKey:(NSString*)strKey{
    [[NSUserDefaults standardUserDefaults] setObject:tag forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
