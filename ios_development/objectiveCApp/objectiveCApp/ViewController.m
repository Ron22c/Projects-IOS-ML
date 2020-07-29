//
//  ViewController.m
//  objectiveCApp
//
//  Created by Ranajit on 21/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "ViewController.h"
#import "Inheritace.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"hello we are starting the application");
    // int x = 5;
    float heightOfEverestBaseCamp = 16900.3;
    float heightOfEverest = 29029;
    float distanceToTravel = heightOfEverest - heightOfEverestBaseCamp;
    NSLog(@"Distance to travel is %f", distanceToTravel);
    
    
    NSString *myString = @"hey this is a string which we will test for verious string functionalities of objective c";
    
    NSArray *wordsInString = [myString componentsSeparatedByString:@" "];
    NSLog(@"%@",wordsInString);
    
    NSMutableArray *capitalizedWords = [[NSMutableArray alloc] init];
    for (int word = 0; word < [wordsInString count]; word++){
        NSString *capitalizedWord = [[wordsInString objectAtIndex:word] capitalizedString];
        [capitalizedWords addObject:capitalizedWord];
    }
    
    NSLog(@"%@", capitalizedWords);
    
    NSMutableArray *lowerCaseWords = [[NSMutableArray alloc] init];
    for (NSString *word in wordsInString){
        NSString *smallWords = [word lowercaseString];
        [lowerCaseWords addObject:smallWords];
    }
    
    NSLog(@"%@", lowerCaseWords);
    
    Inheritace *inheriExample = [[Inheritace alloc] init];
    [inheriExample setBlabla:@"HEY this is bla bla"];
    NSLog(@"%@", [inheriExample blabla]);
    NSLog(@"%@", inheriExample.blabla);
    
    NSString *one = @"First";
    NSString *two = @"second";
    NSArray *array1 = [[NSArray alloc] initWithObjects: one, two , nil];
    
    NSLog(@"%@", array1);
    
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    [array2 addObject:one];
    [array2 addObject:two];
    [array2 addObject:array1];
    
    NSLog(@"%@", array2);
    
    CGPoint poi = CGPointMake(12, 13);
    NSLog(@"%f %F", poi.x, poi.y);
    NSLog(@"Response is : %@", [self getDataFrom:@"https://www.google.com"]);
}

- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, [responseCode statusCode]);
        return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


- (IBAction)button:(UIButton *)sender {
    NSLog(@"the text vlaue is: %@", self.textField.text);
    self.name.text=self.textField.text;
    [self.textField resignFirstResponder];
}

- (void) changeString {
    self.stringOne = @"This is string one";
}


@end
