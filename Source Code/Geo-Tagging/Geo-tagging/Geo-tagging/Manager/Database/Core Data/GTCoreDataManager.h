//
//  GTCoreDataManager.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag+CoreDataClass.h"
#import "GTTagModel.h"

#define kModelName                        @"GTTagCoreDataModel"
#define kEntity_Name                      @"Tag"

NS_ASSUME_NONNULL_BEGIN

@interface GTCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectContext *context;

-(void)createContextForInsert;
-(void)saveContext;

-(NSMutableArray*)getAllTags;
-(void)insertData:(GTTagModel *)objEntity;
-(GTTagModel *)getTagForIndex:(NSString *)tagIndex;

@end

NS_ASSUME_NONNULL_END
