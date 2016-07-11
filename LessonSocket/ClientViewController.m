//
//  ClientViewController.m
//  LessonSocket
//
//  Created by rocky on 16/3/7.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ClientViewController.h"
#import "GCDAsyncSocket.h"
#import "Singleton.h"
@interface ClientViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UITextView *textView;
// 客户端socket
//@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 点击客户端连接方法后创建客户端socket代码：创建客户端socket连接的时候必须指定服务器地址和服务的端口号，才能连接成功服务器端监听的socket。
// 链接方法
- (IBAction)connectServerAction:(id)sender {
    [self connectHost];
}

// 创建socket连接服务器
- (void)connectHost{
    //连接之前先确保断开
    [Singleton sharedInstance].socket.userData = @"用户断开";
    [[Singleton sharedInstance] cutOffSocket];
    BOOL result = [[Singleton sharedInstance]socketConnectHostWithHost:self.addressTF.text port:self.portTF.text.integerValue delegate:self];
    if (result) {
        // 成功
        [self showTextViewWithText:@"开放监听功能"];
    }else{
        // 失败
        [self showTextViewWithText:@"开放监听失败"];
    }
}

// 客户端调用自己的socket发送读取数据，客户端socket代理方法中获取连接是否成功以及接收发送消息的成功回调。
// 发送消息
- (IBAction)sendMessageAction:(id)sender {
    NSData *data = [self.messageTF.text dataUsingEncoding:NSUTF8StringEncoding];
    // 发送消息
    [[Singleton sharedInstance].socket writeData:data withTimeout:-1 tag:0];
}

// 接收消息
- (IBAction)receiveMessageAction:(id)sender {
    [[Singleton sharedInstance].socket readDataWithTimeout:-1 tag:0];
}

// 展示消息
- (void)showTextViewWithText:(NSString *)text{
    self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n",text];
}

#pragma mark - socketdelegate
// 客户端链接服务器成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    [self showTextViewWithText:[NSString stringWithFormat:@"链接服务器成功:%@",host]];
    [[Singleton sharedInstance].socket readDataWithTimeout:-1 tag:0];
    
}

// 连接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"与服务器断开连接！！！！%@",sock.userData);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self showTextViewWithText:@"消息发送成功"];
}

// 成功读取客户端发过来的消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *message = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showTextViewWithText:message];
    [[Singleton sharedInstance].socket readDataWithTimeout:-1 tag:0];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
