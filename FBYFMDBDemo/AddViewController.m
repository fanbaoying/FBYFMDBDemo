//
//  AddViewController.m
//  FBYFMDBDemo
//
//  Created by fby on 2018/1/29.
//  Copyright © 2018年 FBYFMDBDemo. All rights reserved.
//

#import "AddViewController.h"

#import "FMDB.h"

#import "agreeFirstNav.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AddViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSString * dbPath;

@property(strong,nonatomic)UITextField *nameTxteField;
@property(strong,nonatomic)UITextField *ageTxteField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"数据新增" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
    [self content];
}

- (void)leftBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)content {
    
    self.nameTxteField = [[UITextField alloc]initWithFrame:CGRectMake(10, 95, SCREEN_WIDTH-20, 50)];
    self.nameTxteField.layer.borderWidth = 1.0;
    self.nameTxteField.layer.cornerRadius = 5.0;
    self.nameTxteField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.nameTxteField.clipsToBounds = YES;
    self.nameTxteField.placeholder = @"请输入姓名";
    [self.view addSubview:_nameTxteField];
    
    self.ageTxteField = [[UITextField alloc]initWithFrame:CGRectMake(10, 175, SCREEN_WIDTH-20, 50)];
    self.ageTxteField.layer.borderWidth = 1.0;
    self.ageTxteField.layer.cornerRadius = 5.0;
    self.ageTxteField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.ageTxteField.clipsToBounds = YES;
    self.ageTxteField.keyboardType = UIKeyboardTypeNumberPad;
    self.ageTxteField.placeholder = @"请输入年龄";
    [self.view addSubview:_ageTxteField];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH-20, 50)];
    saveBtn.backgroundColor = [UIColor lightGrayColor];
    [saveBtn setTitle:@"保存" forState:0];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)saveBtn:(UIButton *)sender {
    
    if (![_nameTxteField.text  isEqual: @""] && ![_ageTxteField.text  isEqual: @""]) {
        [self saveData];
    }
}

- (void)saveData {
    
    //获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    self.dbPath = fileName;
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    //3.打开数据库
    if ([db open]) {
        //4.创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_userData (id integer PRIMARY KEY AUTOINCREMENT, userName text NOT NULL, userAge text NOT NULL);"];
        if (result){
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }
    self.db=db;
    
    [self insert];
}

//插入数据
-(void)insert{
    BOOL res = [self.db executeUpdate:@"INSERT INTO t_userData (userName, userAge) VALUES (?, ?);", _nameTxteField.text, _ageTxteField.text];
    
    if (!res) {
        NSLog(@"增加数据失败");
    }else{
        NSLog(@"增加数据成功");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"新增数据成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:0.5];
        
    }
}

- (void)dismiss:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
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
