# XD-Navigition
# 导航栏渐变，tableView头部视图下拉放大
![http://ww3.sinaimg.cn/mw690/afa9a093jw1f8ogas7b9gg208w0gcb2e.gif](http://ww3.sinaimg.cn/mw690/afa9a093jw1f8ogas7b9gg208w0gcb2e.gif)

#import "XDViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Nav_Height 44
@interface XDViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tb;
/** 头部视图View */
@property (nonatomic,strong) UIView *headerView;
/**
 *  大图
 */
@property (nonatomic,strong) UIImageView *headerImageView;
/**
 *  内容view
 */
@property (nonatomic, strong) UIView *headerContentView;
/**
 *  头视图的高度
 */
@property (nonatomic, assign) CGFloat headerHeight;
/**
 *  比例
 */
@property (nonatomic, assign) CGFloat scale;
/**
 *  计划名字
 */
@property (nonatomic,strong) UILabel *NameLabel;


@end

@implementation XDViewController
#pragma mark - 懒加载创建tableView
- (UITableView *)tb{
    
    if (_tb == nil) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tb.backgroundColor = [UIColor clearColor];
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tb;
}
-(UIView *)headerView{
    if (_headerView == nil) {
        _headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.headerHeight)];
    }
    return _headerView;
}
#pragma mark - 创建头部内容 view
-(UIView *)headerContentView{
    
    if (_headerContentView == nil) {
        _headerContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.headerHeight)];
        _headerContentView.backgroundColor = [UIColor blackColor];
        _headerContentView.layer.masksToBounds = YES;
    }
    return _headerContentView;
}
-(UIImageView *)headerImageView{
    
    if (_headerImageView == nil) {
        _headerImageView =[[UIImageView alloc] init];
        _headerImageView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, self.headerHeight);
        _headerImageView.center = self.headerContentView.center;
        _headerImageView.image = [UIImage imageNamed:@"hahha.jpg"];
        self.headerContentView.layer.masksToBounds = YES;
        
    }
    return _headerImageView;
}
- (UILabel *)NameLabel{
    
    if (_NameLabel == nil) {
        _NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.headerContentView.bounds.size.height-Nav_Height*3, SCREEN_WIDTH/2, 44)];
        _NameLabel.text= @"现在就努力还不晚！！！";
        _NameLabel.textColor = [UIColor greenColor];
        _NameLabel.font = [UIFont systemFontOfSize:16];
        
        
    }
    return _NameLabel;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bgcolor"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"往上拉就变透明啦";
    //头视图的高度
    self.headerHeight = SCREEN_HEIGHT/2.5;
    [self.view addSubview:self.tb];
    [self.headerContentView addSubview:self.headerImageView];
    [self.headerView addSubview:self.headerContentView];
    [self.headerContentView addSubview:self.NameLabel];
   
    self.tb.tableHeaderView = self.headerView;
}
//监听scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    NSLog(@"%f",offset_Y);
    if (offset_Y < 0) {
        //去掉背景图片
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉底部线条
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        self.navigationController.navigationBar.alpha = 1;
        //放大比例
        CGFloat add_topHeight = ABS(offset_Y);//求绝对值
        self.scale = (self.headerHeight+add_topHeight)/self.headerHeight;
        CGRect contentView_frame = CGRectMake(0, -add_topHeight, SCREEN_WIDTH, self.headerHeight+add_topHeight);
        self.headerContentView.frame = contentView_frame;
        CGRect imageView_frame = CGRectMake(-(SCREEN_WIDTH*self.scale-SCREEN_WIDTH)/2.0f,0,SCREEN_WIDTH*self.scale,self.headerHeight+add_topHeight);
        self.headerImageView.frame = imageView_frame;
        
        self.NameLabel.frame =CGRectMake(40, self.headerContentView.bounds.size.height-Nav_Height*3, self.NameLabel.frame.size.width, self.NameLabel.frame.size.height);
        
        
    }else if (offset_Y>0){
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bgcolor"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:32/255.0f green:196/255.0f blue:187/255.0f alpha:offset_Y / 100]] forBarMetrics:UIBarMetricsDefault];
        
    }
    
}
//这边用的imageWithBgColor方法
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


//特定行的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
//几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reusID=@"ID";
    //我创建一个cell 先从复用队列dequeue 里面 用上面创建的静态标识符来取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusID];
    //做一个if判断  如果没有cell  我们就创建一个新的 并且 还要给这个cell 加上复用标识符
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"数据－－－%zi",indexPath.row];
    return cell;
    
    
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
