//
//  ViewController.m
//  fgx-whiteAndBlack
//
//  Created by 123 on 16/10/17.
//  Copyright © 2016年 123. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setData];
}

/**
 * 一个桶里面有白球、黑球各100个
 * i 、每次从通里面拿出来两个球；
 * ii、如果取出的是两个同色的求，就再放入一个黑球；
 * ii、如果取出的是两个异色的求，就再放入一个白球。
 * 最后桶里面只剩下一个黑球的概率是多少？(验证结果是%100(ii和iii是决定概率的关键))
 */
-(void)setData{
    
    static int white=0,black=0;
    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, ([UIScreen mainScreen].bounds.size.height-100)/2, 300, 100)];
    label.backgroundColor=[UIColor redColor];
    label.numberOfLines=0;
    label.text=[NSString stringWithFormat:@"剩下一个黑球的概率是:％%d",black];
    [self.view addSubview:label];
    
    //为了不阻碍UI显示，开个线程
    dispatch_queue_t www=dispatch_queue_create("www", NULL);
    dispatch_async(www, ^{
        NSLog(@"ssss==%@",[NSThread currentThread]);
        NSMutableArray * dataArray=[[NSMutableArray alloc] init];
        for (int j=0; j<100; j++) {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            for (int i=0; i<200; i++) {
                //假设0是白,1是黑
                if (i%2==0) {
                    [array addObject:@"0"];
                }
                else{
                    [array addObject:@"1"];
                }
            }
            NSLog(@"array==%@",array);
            
            //剩下一个的时候输出
            while (array.count>1) {
                [self setww:array andA:arc4random()%array.count andB:arc4random()%array.count];
            }
            
            //把剩下的一个加到数组中
            [dataArray addObject:array[0]];
        }
        
        for (NSString * str in dataArray) {
            if ([str isEqualToString:@"0"]) {
                white++;
            }
            else{
                black++;
            }
        }
        NSLog(@"dataArray===%@ ; arr==%lu ; \n剩下一个黑球的概率是:％%d",dataArray,dataArray.count,black);
        
        //最后回到主线程更新UI(dispatch_get_main_queue())
        dispatch_async(dispatch_get_main_queue(), ^{
            label.text=[NSString stringWithFormat:@"剩下一个黑球的概率是:％%d",black];
        });
    });
}

/**
 * 0是白，1是黑
 */
-(void)setww:(NSMutableArray *)array andA:(int)a andB:(int)b{
    NSLog(@"arr==%lu ; a==%d ; b==%d",array.count,a,b );
    if (a!=b) {
        //如果取出的是两个同色的求，就再放入一个黑球
        if ([array[a] isEqualToString:array[b]]) {
            if (a>b) {
                //先删下标大的元素
                [array removeObjectAtIndex:a];
                [array removeObjectAtIndex:b];
            }else{
                [array removeObjectAtIndex:b];
                [array removeObjectAtIndex:a];
            }
            [array addObject:@"1"];
        }else{
            //ii、如果取出的是两个异色的求，就再放入一个白球
            if (a>b) {
                [array removeObjectAtIndex:a];
                [array removeObjectAtIndex:b];
            }else{
                [array removeObjectAtIndex:b];
                [array removeObjectAtIndex:a];
            }
            [array addObject:@"0"];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
