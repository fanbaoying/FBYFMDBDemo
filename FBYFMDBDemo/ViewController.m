//
//  ViewController.m
//  FBYFMDBDemo
//
//  Created by fby on 2018/1/29.
//  Copyright © 2018年 FBYFMDBDemo. All rights reserved.
//

#import "ViewController.h"

#import "FMDB.h"

#import "agreeFirstNav.h"
#import "AddViewController.h"

#import "AlterViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)agreeFirstNav *nav;

@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSMutableArray *nameArr;

@property(strong,nonatomic)NSMutableArray *ageArr;

@property(strong,nonatomic)NSMutableArray *idArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"delete" andWithTitleLab:@"数据列表" andWithRightBtn:@"addNav" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self lookData];
}

- (void)lookData {
    
    self.nameArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.ageArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.idArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        
    }
    self.db=db;
    
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_userData"];
    
    // 2.遍历结果
    while ([resultSet next]) {
        
        NSString *nameStr = [resultSet stringForColumn:@"userName"];
        [self.nameArr addObject:nameStr];
        
        NSString *ageStr = [resultSet stringForColumn:@"userAge"];
        [self.ageArr addObject:ageStr];
        
        NSString *idStr = [resultSet stringForColumn:@"id"];
        [self.idArr addObject:idStr];
        
        NSLog(@"%@,%@,%@",_nameArr,_ageArr,_idArr);
    }
    
    [self.myTableView reloadData];
    
}

- (void)leftBtn:(UIButton *)sender {
    
    [self deleteAllData];
}

- (void)rightBtn:(UIButton *)sender {
    
    AddViewController *avc = [[AddViewController alloc]init];
    
    [self.navigationController pushViewController:avc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ageArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AlterViewController *avc = [[AlterViewController alloc]init];
    
    avc.userId = _idArr[indexPath.row];
    avc.userAge = _ageArr[indexPath.row];
    avc.userName = _nameArr[indexPath.row];
    
    [self.navigationController pushViewController:avc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fby"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fby"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@ 年龄：%@岁",_nameArr[indexPath.row],_ageArr[indexPath.row]];
    
    return cell;
}

//删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    
        NSString *str = [NSString stringWithFormat:@"%@",_idArr[indexPath.row]];
        int count = [str intValue];
        
        [self deleteData:count];
    
    }];

    return @[action0];
}

// 删除一条数据
- (void)deleteData:(NSInteger)userid{
    
    NSLog(@"%ld",(long)userid);
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        
        NSString *str = [NSString stringWithFormat:@"DELETE FROM t_userData WHERE id = %ld",userid];
        
        BOOL res = [db executeUpdate:str];
        
        if (!res) {
            NSLog(@"数据删除失败");
            [self lookData];
        } else {
            NSLog(@"数据删除成功");
            [self lookData];
        }
        [db close];
    }
}

// 删除所有数据
- (void)deleteAllData{
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        
        NSString *str = @"DELETE FROM t_userData";
        
        BOOL res = [db executeUpdate:str];
        
        if (!res) {
            NSLog(@"数据清除失败");
            [self lookData];
        } else {
            NSLog(@"数据清除成功");
            [self lookData];
        }
        [db close];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
