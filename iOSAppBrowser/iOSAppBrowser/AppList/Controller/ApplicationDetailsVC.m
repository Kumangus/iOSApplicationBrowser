//
//  ApplicationDetailsVC.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "ApplicationDetailsVC.h"

@interface ApplicationDetailsVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *applicationParameters;
    NSArray *highlightedParameters;
}
@end

@implementation ApplicationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    applicationParameters = @[APP_BUNDLE_ID,APP_BUNDLE_SHORT_VERSION,APP_BUNDLE_VERSION,APP_BUNDLE_SIGNER_IDENTITY,APP_BUNDLE_EXECUTABLE,APP_BUNDLE_ENTITLEMENTS,APP_BUNDLE_ENVIRONMENT_VARIABLES,APP_BUNDLE_URL,APP_BUNDLE_CONTAINER_URL,APP_NAME,APP_SHORT_NAME,APP_TYPE,APP_TEAM_ID,APP_VENDOR_NAME,APP_SOURCE_IDENTIFIER,APP_STORE_NAME,APP_REGISTERED_DATE,APP_CONTAINER_URL,APP_DATA_CONTAINER_URL,APP_STORE_RECEIPT_URL,APP_STORE_FRONT,APP_PURCHASER_DSID,APP_APPLICATION_DSID,APP_CACHE_GUID,APP_UNIQUE_IDENTIFIER,APP_MACH_O_UUIDS,APP_INSTALL_TYPE,APP_ORIGINAL_INSTALL_TYPE,APP_SEQUENCE_NUMBER,APP_HASH,APP_FOUND_BACKING_BUNDLE,APP_IS_ADHOC_CODE_SIGNED,APP_PROFILE_VALIDATED,APP_IS_INSTALLED,APP_IS_RESTRICTED,APP_STORE_COHORT_METADATA,APP_UI_BACKGROUND_MODES,APP_TAGS,APP_COMPANION_APP_IDENTIFIER];
    
    highlightedParameters = @[APP_BUNDLE_ID,APP_BUNDLE_SIGNER_IDENTITY,APP_BUNDLE_ENTITLEMENTS,APP_TEAM_ID,APP_SOURCE_IDENTIFIER,APP_STORE_NAME,APP_STORE_FRONT,APP_PURCHASER_DSID,APP_APPLICATION_DSID,APP_HASH,APP_PROFILE_VALIDATED,APP_STORE_COHORT_METADATA,APP_UI_BACKGROUND_MODES];
    
    self.navigationItem.title = @"Application Info";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getStringRepresentationForParameterAtIndex:(NSInteger)index
{
    NSString *parameter = [applicationParameters objectAtIndex:index];
    NSString *paramValue = nil;
    
    id value = [self.application getValueForKey:parameter];
    if([value isKindOfClass:[NSString class]])
    {
        paramValue = value;
    }
    else if([value isKindOfClass:[NSNumber class]])
    {
        paramValue = [value stringValue];
    }
    else if([value isKindOfClass:[NSUUID class]])
    {
        paramValue = [value UUIDString];
    }
    else if([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (id member in value)
        {
            if([member isKindOfClass:[NSUUID class]])
            {
                [mutableArray addObject:[member UUIDString]];
            }
            else if([member isKindOfClass:[NSString class]])
            {
                [mutableArray addObject:member];
            }
        }
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mutableArray options:NSJSONWritingPrettyPrinted error:&error];
        if(!jsonData)
        {
            NSLog(@"Got an error: %@", error);
            paramValue = @"NA";
        }
        else
        {
            paramValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else if([value isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *paramDict = value;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDict options:NSJSONWritingPrettyPrinted error:&error];
        if(!jsonData)
        {
            NSLog(@"Got an error: %@", error);
            paramValue = @"NA";
        }
        else
        {
            paramValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else if([value isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"E dd MM yyyy hh:mm a"];
        paramValue = [formatter stringFromDate:value];
    }
    return paramValue;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *parameter = [applicationParameters objectAtIndex:indexPath.row];
    NSString *paramValue = [self getStringRepresentationForParameterAtIndex:indexPath.row];
    
    CGFloat requiredHeight = 0;
    UIFont *parameterFont = [UIFont fontWithName:@"Helvetica" size:16];
    UIFont *parameterValueFont = [UIFont fontWithName:@"Helvetica" size:11];
    
    CGSize maximumLableSize = CGSizeMake(self.view.frame.size.width-100, CGFLOAT_MAX);
    
//    NSStringDrawingUsesDeviceMetrics
    CGRect requiredSizeForParameter = [parameter boundingRectWithSize:maximumLableSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:parameterFont} context:nil];
    CGRect requiredSizeForParameterValue = [paramValue boundingRectWithSize:maximumLableSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:parameterValueFont} context:nil];
    
    requiredHeight += requiredSizeForParameter.size.height;
    requiredHeight += 5;   //Padding
    requiredHeight += requiredSizeForParameterValue.size.height;
    
    NSLog(@"Param value: %@",paramValue);
    NSLog(@"ParamValueHeight: %f",requiredSizeForParameterValue.size.height);
    NSLog(@"Font line height: %f",parameterValueFont.lineHeight);
    int paramValueNumberOfLines = ceil((requiredSizeForParameterValue.size.height) / parameterValueFont.lineHeight);
    
    NSLog(@"IndexPath: %d Height: %f Lines: %d",indexPath.row,requiredHeight,paramValueNumberOfLines);
    
    NSInteger extraPadding = 15;
    requiredHeight += extraPadding;
    
//        return UITableViewAutomaticDimension;
    return requiredHeight;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return applicationParameters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *applicationDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"ApplicationDetailsCell"];
    
    NSString *parameter = [applicationParameters objectAtIndex:indexPath.row];
    NSString *paramValue = [self getStringRepresentationForParameterAtIndex:indexPath.row];
    
    applicationDetailsCell.textLabel.text = parameter;
    applicationDetailsCell.detailTextLabel.text = paramValue;
    
    if([highlightedParameters containsObject:parameter])
    {
        applicationDetailsCell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }
    else
    {
        applicationDetailsCell.backgroundColor = [UIColor whiteColor];
    }

    return applicationDetailsCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
