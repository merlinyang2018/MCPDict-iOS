//
//  TextInputController.h
//  mcpdict
//
//  Created by Cirno on 2017/8/31.
//  Copyright © 2017年 com.umi.mcpdict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UmiHeader.h"
#import <Hero/Hero-Swift.h>
@protocol TextInputDelegate
-(void)textDidChange:(NSString*)str;
@end
@interface TextInputController : UIViewController

@property (nonatomic,strong) UITextField* Input;
@property (nonatomic,strong) NSString* str;
@property (nonatomic,weak) id <TextInputDelegate>delegate;

@end
