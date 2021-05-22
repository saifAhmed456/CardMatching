//
//  HIstory_ViewController.m
//  cardMatch
//
//  Created by Shaik A S on 05/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "HIstory_ViewController.h"

@interface HIstory_ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *text_view_outlet;
-(void)updateUI;
@end

@implementation HIstory_ViewController
-(NSMutableAttributedString *)attributed_string_to_display_history
{
    if(!_attributed_string_to_display_history)
        _attributed_string_to_display_history = [[NSMutableAttributedString alloc]init];
    return _attributed_string_to_display_history;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}
-(void) viewWillAppear:(BOOL)animated
{  [super viewWillAppear:YES];
    [self updateUI];
}
-(void)updateUI
{
    [self.text_view_outlet setAttributedText:self.attributed_string_to_display_history];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
