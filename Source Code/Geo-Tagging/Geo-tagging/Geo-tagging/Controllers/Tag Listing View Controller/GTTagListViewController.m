//
//  GTTagListViewController.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTTagListViewController.h"
#import "GTTagListTableViewCell.h"

@interface GTTagListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellIdentifier ;
}
    @property (weak, nonatomic) IBOutlet UITableView *tblTagsList;
    @end

@implementation GTTagListViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    cellIdentifier = @"GTTagListTableViewCell";
    [self initializeTableView];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.arrTags.count > self.index){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        [self.tblTagsList scrollToRowAtIndexPath:indexPath
                                atScrollPosition:UITableViewScrollPositionTop
                                        animated:TRUE];
    }
}

    -(void) initializeTableView {
        [self.tblTagsList registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        self.tblTagsList.delegate = self;
        self.tblTagsList.dataSource = self;
        self.tblTagsList.estimatedRowHeight = 80.0;
        self.tblTagsList.rowHeight = 80.0;
        [self.tblTagsList setTableFooterView:nil];
    }
    
- (IBAction)btnCloseDidClicked:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
    
#pragma mark - Table View Data Source
    
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return self.arrTags.count;
    }
    
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        GTTagListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        GTTagModel *objTag = [self.arrTags objectAtIndex:indexPath.row];
        if(!cell)
        {
            cell = [[GTTagListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell configureCell:objTag];
        cell.backgroundColor = [UIColor whiteColor];
        
        if (self.index == indexPath.row) {
            cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
        }
        
        return cell;
    }
    
#pragma mark - Table View Delegate
    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        GTTagModel *objTag = [self.arrTags objectAtIndex:indexPath.row];
        [self.delegate showMarkerForLatitude:objTag.latitude longitude:objTag.longitude];
        [self dismissViewControllerAnimated:true completion:nil];
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
