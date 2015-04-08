//
//  CSFChatterFollowingPageOutputTest.h
//  CoreSalesforce
//
//  Created automatically by Michael Nachbaur on 12/04/14.
//  Copyright (c) 2012 Salesforce.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "CSFChatterFollowingPageOutput.h"

@interface CSFChatterFollowingPageOutputTest : XCTestCase

@end

@implementation CSFChatterFollowingPageOutputTest

- (void)testInitializer {
    NSString *fn = [[NSBundle bundleForClass:self.class] pathForResource:@"CSFChatterFollowingPageOutput" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:fn]; 
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    XCTAssertNil(error);

    CSFChatterFollowingPageOutput *model = [[CSFChatterFollowingPageOutput alloc] initWithJSON:json context:nil];
    XCTAssertNotNil(model, @"Output object should not be nil");

    CSFChatterFollowingPageOutput *model2 = [[CSFChatterFollowingPageOutput alloc] initWithJSON:json context:nil];
    XCTAssertEqualObjects(model, model2, @"Output objects should be equal");
    XCTAssertTrue([model isEqual:model2], @"Output objects should pass isEqual");
    XCTAssertTrue([model isEqualToOutput:model2], @"Output objects should pass isEqualToOutput");
}

@end