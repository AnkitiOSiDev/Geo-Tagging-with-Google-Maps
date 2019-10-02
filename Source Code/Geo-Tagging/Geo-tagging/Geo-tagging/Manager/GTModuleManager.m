//
//  GTModuleManager.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTModuleManager.h"
#import "GTDatabaseManager.h"
@implementation GTModuleManager{
    GTDatabaseManager *dbManager ;
}
    
+ (id)sharedInstance {
    static GTModuleManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
    
- (id)init {
    if (self = [super init]) {
        dbManager = [[GTDatabaseManager alloc] init];
    }
    return self;
}
    
    - (void) saveTag:(GTTagModel *)tagModel{
        [dbManager saveTag:tagModel];
    }
    
    -(GTTagModel *) getTagFor:(CLLocationCoordinate2D )coordinate{
        return  [dbManager getTagFor:coordinate];
    }
    
    -(NSArray*) getAllTags{
        return [dbManager getAllTags];
    }
    @end
