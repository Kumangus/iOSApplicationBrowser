//
//  Application.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "Application.h"

@implementation Application

- (Application *)initWithBundleID:(NSString *)bundleID name:(NSString *)name version:(NSString *)version
{
    self = [super init];
    if(self)
    {
        _bundleID = bundleID;
        _bundleShortVersion = @"";
        _bundleVersion = version;
        _signerIdentity = @"";
        _bundleExecutable = @"";
        _entitlements = nil;
        _environmentVariables = nil;
        _bundleURL = @"";
        _bundleContainerURL = @"";
        
        _name = name;
        _shortName = @"";
        _type = @"";
        _teamID = @"";
        _vendorName = @"";
        _sourceAppIdentifier = @"";
        _iconImage = nil;
        
        _containerURL = @"";
        _dataContainerURL = @"";
      
        _appStoreReceiptURL = @"";
        
        _cacheGUID = nil;
        _uniqueIdentifier = nil;
        _machOUUIDs = nil;
        
        _installType = 0;
        _originalInstallType = 0;
        _sequenceNumber = 0;
        _appHash = 0;
        
        _foundBackingBundle = YES;
        
        _profileValidated = NO;
        _isInstalled = YES;
        _isRestricted = NO;
        
        _storeCohortMetadata = @"";
        _tags = nil;
    }
    
    return self;
}

- (id)getValueForKey:(NSString *)key
{
    id value = nil;
    if([key isEqualToString:APP_BUNDLE_ID])
    {
        value = self.bundleID;
    }
    else if([key isEqualToString:APP_BUNDLE_SHORT_VERSION])
    {
        value = self.bundleShortVersion;
    }
    if([key isEqualToString:APP_BUNDLE_VERSION])
    {
        value = self.bundleVersion;
    }
    else if([key isEqualToString:APP_BUNDLE_SIGNER_IDENTITY])
    {
        value = self.signerIdentity;
    }
    else if([key isEqualToString:APP_BUNDLE_EXECUTABLE])
    {
        value = self.bundleExecutable;
    }
    else if([key isEqualToString:APP_BUNDLE_ENTITLEMENTS])
    {
        value = self.entitlements;
    }
    else if([key isEqualToString:APP_BUNDLE_ENVIRONMENT_VARIABLES])
    {
        value = self.environmentVariables;
    }
    else if([key isEqualToString:APP_BUNDLE_URL])
    {
        value = self.bundleURL;
    }
    else if([key isEqualToString:APP_BUNDLE_CONTAINER_URL])
    {
        value = self.bundleContainerURL;
    }
    else if([key isEqualToString:APP_NAME])
    {
        value = self.name;
    }
    else if([key isEqualToString:APP_SHORT_NAME])
    {
        value = self.shortName;
    }
    else if([key isEqualToString:APP_TYPE])
    {
        value = self.type;
    }
    if([key isEqualToString:APP_TEAM_ID])
    {
        value = self.teamID;
    }
    else if([key isEqualToString:APP_VENDOR_NAME])
    {
        value = self.vendorName;
    }
    else if([key isEqualToString:APP_SOURCE_IDENTIFIER])
    {
        value = self.sourceAppIdentifier;
    }
    else if([key isEqualToString:APP_CONTAINER_URL])
    {
        value = self.containerURL;
    }
    else if([key isEqualToString:APP_DATA_CONTAINER_URL])
    {
        value = self.dataContainerURL;
    }
    else if([key isEqualToString:APP_STORE_RECEIPT_URL])
    {
        value = self.appStoreReceiptURL;
    }
    else if([key isEqualToString:APP_CACHE_GUID])
    {
        value = self.cacheGUID;
    }
    else if([key isEqualToString:APP_UNIQUE_IDENTIFIER])
    {
        value = self.uniqueIdentifier;
    }
    else if([key isEqualToString:APP_MACH_O_UUIDS])
    {
        value = self.machOUUIDs;
    }
    if([key isEqualToString:APP_INSTALL_TYPE])
    {
        NSNumber *numInstallType = [NSNumber numberWithUnsignedLongLong:self.installType];
        value = numInstallType;
    }
    else if([key isEqualToString:APP_ORIGINAL_INSTALL_TYPE])
    {
        NSNumber *numOriginalInstallType = [NSNumber numberWithUnsignedLongLong:self.originalInstallType];
        value = numOriginalInstallType;
    }
    else if([key isEqualToString:APP_SEQUENCE_NUMBER])
    {
        NSNumber *numSequenceNumber = [NSNumber numberWithUnsignedInt:self.sequenceNumber];
        value = numSequenceNumber;
    }
    else if([key isEqualToString:APP_HASH])
    {
        NSNumber *numAppHash = [NSNumber numberWithUnsignedInt:self.appHash];
        value = numAppHash;
    }
    if([key isEqualToString:APP_FOUND_BACKING_BUNDLE])
    {
        NSNumber *numFoundBackingBundle = [NSNumber numberWithBool:self.foundBackingBundle];
        value = numFoundBackingBundle;
    }
    if([key isEqualToString:APP_PROFILE_VALIDATED])
    {
        NSNumber *numIsProfileValidated = [NSNumber numberWithBool:self.profileValidated];
        value = numIsProfileValidated;
    }
    if([key isEqualToString:APP_IS_INSTALLED])
    {
        NSNumber *numIsInstalled = [NSNumber numberWithBool:self.isInstalled];
        value = numIsInstalled;
    }
    else if([key isEqualToString:APP_IS_RESTRICTED])
    {
        NSNumber *numIsRestricted = [NSNumber numberWithBool:self.isRestricted];
        value = numIsRestricted;
    }
    if([key isEqualToString:APP_STORE_COHORT_METADATA])
    {
        value = self.storeCohortMetadata;
    }
    else if([key isEqualToString:APP_TAGS])
    {
        value = self.tags;
    }
    return value;
}

@end
