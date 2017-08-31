//
//  SettingViewController.m
//  mcpdict
//
//  Created by Cirno on 2017/8/31.
//  Copyright © 2017年 com.umi.mcpdict. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"pref_title", "");
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.settings = [[NSArray alloc]initWithObjects:
                     @"mandarin_display",
                     @"cantonese_romanization",
                     @"korean_display",
                     @"vietnamese_tone_position",
                     @"japanese_display",
                     nil];
    self.settingOptions = [[NSArray alloc]initWithObjects:@2,@4,@2,@2,@4, nil];
}

-(NSInteger)getKeyInUserDefault:(NSString*)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:key];
}
-(void)setKeyInUserDefault:(NSString*)key
                     Value:(NSInteger)value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.settings count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"setting"];

    NSString* prefKey = self.settings[indexPath.row];
    NSInteger option = [self getKeyInUserDefault:prefKey];
    NSString* titleStr = [NSString stringWithFormat:@"pref_title_%@",prefKey];
    NSString* optionStr = [NSString stringWithFormat:@"pref_entries_%@[%ld]",prefKey,(long)option];
    cell.textLabel.text = NSLocalizedString(titleStr, "");
    cell.detailTextLabel.text = NSLocalizedString(optionStr, "");
    cell.detailTextLabel.alpha = 0.5f;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectOptions:indexPath.row];
}
-(void)selectOptions:(NSInteger)row{
    UIAlertController* options = [[UIAlertController alloc]init];
    for (int i = 0; i<[self.settingOptions[row] intValue]; i++){
        NSString* str = [NSString stringWithFormat:@"pref_entries_%@[%d]",self.settings[row],i];
        UIAlertAction* action = [UIAlertAction actionWithTitle:NSLocalizedString(str, "")
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction* n){
                                                             [self setKeyInUserDefault:self.settings[row] Value:i];
                                                             [self.tableView reloadData];
                                                         }];
        [options addAction:action];

    }
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:UIKitLocalizedString(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [options addAction:cancel];
    [self presentViewController:options animated:YES completion:nil];
}

@end
