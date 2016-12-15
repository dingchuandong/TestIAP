//
//  ZM_PersonAiYiViewController.m
//  begin
//
//  Created by dcd on 16/11/3.
//  Copyright © 2016年 上海宅米贸易有限公司. All rights reserved.
//

#import "ZM_PersonAiYiViewController.h"
#import <StoreKit/StoreKit.h>
#import "ZM_SelectPriceView.h"

@interface ZM_PersonAiYiViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic, strong)NSString *productID;
@property (nonatomic, strong)UIButton *btnSubmit;
@property (nonatomic, strong)UIView *priceBgView;
@property (nonatomic, strong)UILabel *amountLab;
@property (nonatomic, strong)NSArray *infoAry;
@end

@implementation ZM_PersonAiYiViewController
@synthesize productID;
@synthesize btnSubmit;
@synthesize priceBgView;
@synthesize amountLab;
@synthesize infoAry;

- (void)viewDidUnload {
    [super viewDidUnload];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"内购测试";

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, [UIScreen mainScreen].bounds.size.width, 183)];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 64, self.view.frame.size.width, topView.frame.size.height - 64);
    [topView.layer addSublayer:gradientLayer];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    amountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 50)];
    amountLab.font = [UIFont boldSystemFontOfSize:45];
    amountLab.text = [NSString stringWithFormat:@"%d",100];
    amountLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:amountLab];
    
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0
                                                          green:85/255.0
                                                           blue:114/255.0
                                                          alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:143/255.0 green:236/255.0 blue:215/255.0 alpha:1].CGColor];
    amountLab.textColor = [UIColor blackColor];
    
    priceBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 150, self.view.frame.size.width - 20, 100)];
    [self.view addSubview:priceBgView];
    
    btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [btnSubmit setTitle:@"确认支付6元" forState:UIControlStateNormal];
    [btnSubmit addTarget:self action:@selector(addPayOrder) forControlEvents:UIControlEventTouchUpInside];
    btnSubmit.backgroundColor = [UIColor whiteColor];
    [btnSubmit setTitleColor:[UIColor colorWithRed:255/255.0
                                             green:85/255.0
                                              blue:114/255.0
                                             alpha:1] forState:UIControlStateNormal];
    [btnSubmit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btnSubmit.layer.shadowOffset = CGSizeMake(3, 0);
    btnSubmit.layer.shadowOpacity = 0.7;
    btnSubmit.layer.shadowRadius = 4;
    [self.view addSubview:btnSubmit];
    
    // 添加购买监听
    typeof(self) weakSelf = self;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:weakSelf];
    
    infoAry = [NSArray arrayWithObjects:@"6",@"30",@"90",@"189", nil];
    [self resetPriceView];
}

- (void)addPayOrder
{
    // 检测是否允许内购
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:productID];
    }else{
        NSLog(@"不允许程序内付费");
    }
}

- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)resetPriceView
{
    float width = (priceBgView.frame.size.width - 10)/2;
    for (int i = 0; i < self.infoAry.count; i ++) {
        ZM_SelectPriceView *priceView = [[ZM_SelectPriceView alloc] initWithFrame:CGRectMake(i%2 * (10 + width), i/2 * (10 + 45), width, 45)];
        priceView.titleLab.text = [NSString stringWithFormat:@"%@爱意",infoAry[i]];
        [priceView.priceBtn setTitle:[NSString stringWithFormat:@"%@元",infoAry[i]] forState:UIControlStateNormal];
        priceView.priceBtn.tag = i;
        [priceView.priceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [priceView.priceBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:255/255.0
                                                                                          green:85/255.0
                                                                                           blue:114/255.0
                                                                                          alpha:1]] forState:UIControlStateSelected];
        
        if (i == 0) {
            priceView.priceBtn.selected = YES;
            //iTunes上的产品id
            productID = @"zhai.me.begin.goods1";

        }else{
            
        }
        
        [priceView.priceBtn addTarget:self action:@selector(resetNormal:) forControlEvents:UIControlEventTouchUpInside];
        [priceBgView addSubview:priceView];
    }
}

- (void)resetNormal:(UIButton *)sender
{
    for (ZM_SelectPriceView *view in priceBgView.subviews) {
        if ([view isKindOfClass:[ZM_SelectPriceView class]]) {
            view.priceBtn.selected = NO;
            view.priceBtn.layer.borderColor = [UIColor blackColor].CGColor;
        }
    }

    sender.selected = YES;
    sender.layer.borderColor = [UIColor colorWithRed:255/255.0
                                               green:85/255.0
                                                blue:114/255.0
                                               alpha:1].CGColor;

    [btnSubmit setTitle:[NSString stringWithFormat:@"确认充值%@",self.infoAry[sender.tag]] forState:UIControlStateNormal];
}
//请求商品
- (void)requestProductData:(NSString *)type{
    
    NSLog(@"请求商品");
    NSSet *nsset = [NSSet setWithObject:type];
    // 请求动作
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    typeof(self) weakSelf = self;
    request.delegate = weakSelf;
    [request start];
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"收到了请求反馈");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"没有这个商品");
        return;
    }
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%ld",(unsigned long)[product count]);
    SKProduct *p = nil;
    // 所有的商品, 遍历招到我们的商品
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        if([pro.productIdentifier isEqualToString:productID]) {
            p = pro;
        }
    }
    SKPayment * payment = [SKPayment paymentWithProduct:p];
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"商品信息请求错误:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"请求结束");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
//                [SVProgressHUD showSuccessWithStatus:@"交易完成"];
                // 结束掉请求
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
//                [SVProgressHUD showWithStatus:@"正在请求付费信息" maskType:SVProgressHUDMaskTypeGradient];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
//                [SVProgressHUD showErrorWithStatus:@"已经购买过商品"];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
//                [SVProgressHUD showErrorWithStatus:@"交易失败, 请重试"];
                break;
            default:
//                [SVProgressHUD dismiss];
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    //购买完成
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];

    NSString * productIdentifier = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
//    NSString * receipt = [[productIdentifier dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    
    if ([productIdentifier length] > 0) {        
        //向自己的服务器验证购买凭证
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)dealloc{
    typeof(self) weakSelf = self;
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:weakSelf];
}
    
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//- (NSString *)base64EncodedString;
//{
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    return [data base64EncodedStringWithOptions:0];
//}
//
//- (NSString *)base64DecodedString
//{
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
//    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
