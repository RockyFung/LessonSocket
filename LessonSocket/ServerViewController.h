//
//  ServerViewController.h
//  LessonSocket
//
//  Created by rocky on 16/3/7.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

@interface ServerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UITextView *textView;



// 服务器监听
@property (weak, nonatomic) IBOutlet UIButton *listenAction;
// 发送消息
@property (weak, nonatomic) IBOutlet UIButton *sendMessageAction;
// 接收消息
@property (weak, nonatomic) IBOutlet UIButton *receiveMessage;

@end
