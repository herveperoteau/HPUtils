//
//  HPUtilsTests.m
//  HPUtilsTests
//
//  Created by Hervé PEROTEAU on 11/12/2013.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+HPUtils.h"
#import "MD5Digest.h"

@interface HPUtilsTests : XCTestCase

@end

@implementation HPUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMD5Digest
{
    NSString *str = @"test";
    NSLog(@"%@ => %@", str, [str md5Digest]);
}


- (void)testdateAtZeroHour
{
    NSDate *date = [[NSDate date] dateAtZeroHour];
    
    NSLog(@"dateAtZeroHour=%@", date);
}

- (void)testdateAtZeroHourMinus7Days
{
    NSDate *date = [[NSDate date] dateAtZeroHourMinusXDays:7];
    
    NSLog(@"testdateAtZeroHourMinus7Days=%@", date);
}

@end
