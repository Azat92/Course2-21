//
//  ViewController.m
//  Lesson21
//
//  Created by Azat Almeev on 11.05.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "ViewController.h"
#import <BlocksKit+MessageUI.h>
#import <BlocksKit+UIKit.h>

@interface NSNumber (Extended)
- (NSArray *)take;
@end

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation ViewController
- (IBAction)update:(id)sender {
    self.navigationItem.title=@"0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *input = [@5 take];

    UILabel *multLabel = [UILabel new];
    [multLabel setText:@"Mult"];
    [multLabel setFrame:CGRectMake(10, 60, 50, 30)];
    [self.view addSubview:multLabel];
    NSArray *buttons = [input bk_map:^id(id obj) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [addButton setTitle:[NSString stringWithFormat:@"%@", obj] forState:UIControlStateNormal];
        NSInteger index = [obj integerValue];
        addButton.frame = CGRectMake(50*index +40, 60, 90, 30);
        [addButton bk_addEventHandler:^(UIButton *sender) {
            [self.navigationItem setTitle:[NSString stringWithFormat:@"%ld", [self.navigationItem.title integerValue]* index]];
        } forControlEvents:UIControlEventTouchUpInside];
        return addButton;
    }];
    [buttons bk_each:^(id obj) {
        [self.view addSubview:obj];
    }];
    
    UILabel *addLabel = [UILabel new];
    [addLabel setText:@"Add"];
    [addLabel setFrame:CGRectMake(10, 100, 50, 30)];
    [self.view addSubview:addLabel];
    NSArray *addButtons = [input bk_map:^id(id obj) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [addButton setTitle:[NSString stringWithFormat:@"%@", obj] forState:UIControlStateNormal];
        NSInteger index = [obj integerValue];
        addButton.frame = CGRectMake(50*index +40, 100, 90, 30);
        [addButton bk_addEventHandler:^(UIButton *sender) {
            [self.navigationItem setTitle:[NSString stringWithFormat:@"%ld", [self.navigationItem.title integerValue]+ index]];
        } forControlEvents:UIControlEventTouchUpInside];
        return addButton;
    }];
    [addButtons bk_each:^(id obj) {
        [self.view addSubview:obj];
    }];

    UILabel *filterLabel = [UILabel new];
    [filterLabel setText:@"Filter"];
    [filterLabel setFrame:CGRectMake(10, 140, 50, 30)];
    [self.view addSubview:filterLabel];
    NSArray *filterButtons = [[@2 take] bk_map:^id(id obj) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [addButton setTitle:[NSString stringWithFormat:@"%@", obj] forState:UIControlStateNormal];
        NSInteger index = [obj integerValue];
        addButton.frame = CGRectMake(50*index +40, 140, 90, 30);
        [addButton bk_addEventHandler:^(UIButton *sender) {
           __block NSString *title = self.navigationItem.title.copy;
            NSMutableArray *value = [NSMutableArray new];
            for (int i = 0; i < title.length ;i++) [value addObject: [NSString stringWithFormat:@"%c",[title characterAtIndex:i] ]];
           value = [value bk_select:^BOOL(id obj) {
                int i = index == 1 ? 1 : 0;
                return [obj integerValue]%2==i;
            }];
            title = @"";
            [value bk_each:^(id obj) {
                title = [NSString stringWithFormat:@"%@%@",title, obj];
            }];
            title =  title.length> 0  ? title : @"0" ;
            [self.navigationItem setTitle:title];
        } forControlEvents:UIControlEventTouchUpInside];
        return addButton;
    }];
    [filterButtons bk_each:^(id obj) {
        [self.view addSubview:obj];
    }];

    
    
}


- (NSArray <NSNumber *>*)incrementArrayBy1:(NSArray <NSNumber *>*)input {
    return [input bk_map:^id(NSNumber *obj) {
        return @(obj.integerValue + 1);
    }];
}

- (NSArray <NSNumber *>*)getLengthsOfElements:(NSArray <NSString *>*)input {
    return [input bk_map:^id(NSString *obj) {
        return @(obj.length);
    }];
}

@end

@implementation NSNumber (Extended)

- (NSArray *)take {
    NSMutableArray *res = [NSMutableArray new];
    for (int i = 1; i <= self.integerValue; i++)
        [res addObject:@(i)];
    return res.copy;
}

@end

