//
//  GTCoreDataManager.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTCoreDataManager.h"

@implementation GTCoreDataManager
    
#pragma mark - Core Data stack
    
    @synthesize managedObjectContext = _managedObjectContext;
    @synthesize managedObjectModel = _managedObjectModel;
    @synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
    @synthesize context;
    
    
    -(id)init {
        if (self = [super init])     {
            return self;
        }
        return nil;
    }
    
#pragma mark - Functions For Insert
    
-(void)createContextForInsert {
    self.context = [self managedObjectContext];
}
    
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
    
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
    
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Tag.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
    
    
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
    
#pragma mark - Core Data Saving support
    
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
    
#pragma mark - insert Tags details in DB
    
-(void)insertData:(GTTagModel *)objTag {
    [self createContextForInsert];
    Tag *tagEntity = [NSEntityDescription
                      insertNewObjectForEntityForName:kEntity_Name
                      inManagedObjectContext:self.context];
    tagEntity.strImageName = objTag.strImageName;
    tagEntity.index = objTag.strIndex;
    tagEntity.latitude = objTag.latitude;
    tagEntity.longitude = objTag.longitude;
    [self.context save:nil];
}
    
#pragma mark - get Tags details
-(NSMutableArray*)getAllTags {
    
    NSMutableArray *allTagsArray = [[NSMutableArray alloc]init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEntity_Name
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   
    for (Tag *tagEntity in fetchedRecords)
    {
        [allTagsArray addObject:[self getTagFromEntity: tagEntity]];
    }
    
    return allTagsArray;
}
    
-(GTTagModel *)getTagForIndex:(NSString *)tagIndex{
    self.context = [self managedObjectContext];
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:kEntity_Name];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"index==%@",tagIndex];
    fetchRequest.predicate = predicate;
    Tag *tagEntity  = [[self.context executeFetchRequest:fetchRequest error:nil] lastObject];
    return [self getTagFromEntity: tagEntity];
}
    
    
-(GTTagModel *)getTagFromEntity: (Tag *)  tagEntity {
    GTTagModel *objTag=[[GTTagModel alloc] initWithEntity:tagEntity];
    return objTag;
}
    @end
