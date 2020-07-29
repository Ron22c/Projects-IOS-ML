//
//  TestXCTests.m
//  TestXCTests
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface TestXCTests : XCTestCase
@property ViewController *vcTest;
@end

@implementation TestXCTests

- (void)setUp {
    _vcTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSString *expected = @"this is a string";
    [_vcTest updateString];
    NSString *resultString = _vcTest.string;
    XCTAssertEqualObjects(expected, resultString, @"Testing update String");
}

- (void)testExampletwo {
    NSString *expected = @"this is a string";
    [_vcTest updateString];
    NSString *resultString = _vcTest.string;
    XCTAssertEqualObjects(expected, resultString, @"Testing update String");
}

- (void)testExampleAddition {
    int result = [_vcTest addition:21 num2:22];
    int expected = 43;
    
    XCTAssertEqual(result, expected);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
