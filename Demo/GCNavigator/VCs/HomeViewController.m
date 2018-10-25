//
//  HomeViewController.m
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/23.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "HomeViewController.h"
#import "GCNavigator.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)presentAction:(id)sender {
    if(self.textField.text.length != 0){
        [GCSharedNavigator presentToURL:[NSURL URLWithString:self.textField.text] animated:YES completion:nil];
    }
}
- (IBAction)pushAction:(id)sender {
    if(self.textField.text.length != 0){
        [GCSharedNavigator pushToURL:[NSURL URLWithString:self.textField.text] atTabBarIndex:2 animated:YES completion:nil];
//        [GCSharedNavigator pushToURL:[NSURL URLWithString:self.textField.text] animated:YES completion:nil];
    }
}
- (IBAction)popAction:(id)sender {
    if(self.textField.text.length != 0){
        [GCSharedNavigator popBackToURL:[NSURL URLWithString:self.textField.text] animated:YES completion:nil];
    }else{
        [GCSharedNavigator popBackWithAnimated:YES completion:nil];
    }
}
- (IBAction)backAction:(id)sender {
    [GCSharedNavigator popBackWithAnimated:YES completion:nil];
}

@end
