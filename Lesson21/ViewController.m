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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *addNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *removeNumbersButton;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;
@property (weak, nonatomic) IBOutlet UITextField *sumTextField;
@property (weak, nonatomic) IBOutlet UIButton *sumButton;
@property (weak, nonatomic) IBOutlet UITextField *multTextField;
@property (weak, nonatomic) IBOutlet UIButton *multButton;
@property (weak, nonatomic) IBOutlet UIButton *evenButton;
@property (weak, nonatomic) IBOutlet UIButton *oddButton;

@property NSMutableArray<NSNumber *> *numbers;
@property NSNumberFormatter *formatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numbers = [NSMutableArray new];
    self.formatter = [NSNumberFormatter new];
    [self.addNumberButton bk_addEventHandler:^(UIButton *sender) {
        if (self.numbers.count < 10) {
            NSNumber *number = [self.formatter numberFromString:self.addNumberTextField.text];
            [self.numbers addObject:number];
            if (self.numbers.count < 10) {
                self.numbersLabel.text = [NSString stringWithFormat:@"%@ %@,", self.numbersLabel.text, number];
            } else {
                self.numbersLabel.text = [NSString stringWithFormat:@"%@ %@", self.numbersLabel.text, number];
            }
        } else {
            self.addNumberTextField.text = @"";
            self.addNumberTextField.placeholder = @"Максимум чисел.";
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.removeNumbersButton bk_addEventHandler:^(UIButton *sender) {
        [self.numbers removeAllObjects];
        self.numbersLabel.text = @"Числа: ";
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.sumButton bk_addEventHandler:^(UIButton *sender) {
        self.numbers = [NSMutableArray arrayWithArray:[self.numbers bk_map:^NSNumber*(NSNumber *obj) {
            NSNumber *number = [self.formatter numberFromString:self.sumTextField.text];
            return [NSNumber numberWithInteger:([obj integerValue] + [number integerValue])];
        }]];
        [self updateLabel];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.multButton bk_addEventHandler:^(UIButton *sender) {
        self.numbers = [NSMutableArray arrayWithArray:[self.numbers bk_map:^NSNumber*(NSNumber *obj) {
            NSNumber *number = [self.formatter numberFromString:self.multTextField.text];
            return [NSNumber numberWithInteger:([obj integerValue] * [number integerValue])];
        }]];
        [self updateLabel];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.evenButton bk_addEventHandler:^(UIButton *sender) {
        self.numbers = [NSMutableArray arrayWithArray:[self.numbers bk_select:^BOOL(NSNumber *obj) {
            return obj.integerValue % 2 == 0;
        }]];
        [self updateLabel];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.oddButton bk_addEventHandler:^(UIButton *sender) {
        self.numbers = [NSMutableArray arrayWithArray:[self.numbers bk_select:^BOOL(NSNumber *obj) {
            return obj.integerValue % 2 != 0;
        }]];
        [self updateLabel];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateLabel {
    self.numbersLabel.text = @"Числа: ";
    if (self.numbers.count == 10) {
        for (int i = 0; i < 10; i++) {
            self.numbersLabel.text = [NSString stringWithFormat:@"%@ %@,", self.numbersLabel.text, self.numbers[i]];
        }
        self.numbersLabel.text = [NSString stringWithFormat:@"%@ %@", self.numbersLabel.text, self.numbers[9]];
    } else {
        for (int i = 0; i < self.numbers.count; i++) {
            self.numbersLabel.text = [NSString stringWithFormat:@"%@ %@,", self.numbersLabel.text, self.numbers[i]];
        }
    }
}

@end

