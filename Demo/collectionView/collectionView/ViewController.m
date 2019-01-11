//
//  ViewController.m
//  collectionView
//
//  Created by Lee on 2019/1/10.
//  Copyright © 2019年 Lee. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#define kSpacing 0
#define kCellWidth 50
#define kCellHeight 30

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, copy) NSArray *imagesArray;
@property (nonatomic, strong) UICollectionView *collecitonView;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableSet *unusedViewControllers;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) BOOL isClickScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.unusedViewControllers = [NSMutableSet set];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    /**
     创建collectionView
     */
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), kCellHeight) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor cyanColor];
    collectionView.pagingEnabled = YES;
    /**
     注册item和区头视图、区尾视图
     */
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionViewHeaderView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyCollectionViewFooterView"];
    [self.view addSubview:collectionView];
    self.collecitonView = collectionView;
    
    NSMutableArray *temArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSString *string = [NSString stringWithFormat:@"==%d==", i];
        [temArray addObject:string];
    }
    self.imagesArray = [temArray copy];
    
    // lineView
    [self.collecitonView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(10, kCellHeight- 3, [self titleWidth:self.imagesArray[0]], 3);
    
    // page
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64 + 30;
    frame.size.height -= 64 + 30;
    UIViewController *vc = [self unusedViewController:0];
    self.pageViewController.view.frame = frame;
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - private


- (TestViewController *)unusedViewController:(NSInteger)index{
    if (!self.unusedViewControllers) {
        self.unusedViewControllers = [NSMutableSet set];
    }
    
    NSArray *tempArray = self.unusedViewControllers.allObjects;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:tempArray.count];
    
    for (TestViewController *element in tempArray) {
        if (!element.parentViewController) {
            [array addObject:element];
        }
    }
    
    TestViewController *unusedVC = [array firstObject];
    if (unusedVC) {
    } else {
        unusedVC = [[TestViewController alloc] init];
        [self.unusedViewControllers addObject:unusedVC];
    }
    unusedVC.index = index;
    return unusedVC;
}


- (CGFloat)titleWidth:(NSString *)title {
    UILabel *titleLabel= [[UILabel alloc] init];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    return CGRectGetWidth(titleLabel.frame);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}

/**
 创建cell
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifer = @"MyCollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifer forIndexPath:indexPath];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    cell.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    UILabel *titleLabel = [cell.contentView viewWithTag:2323234];
    if (titleLabel == nil) {
        titleLabel= [[UILabel alloc] init];
        titleLabel.tag = 2323234;
        [cell.contentView addSubview:titleLabel];
    }
    titleLabel.text = self.imagesArray[indexPath.item];
    [titleLabel sizeToFit];
    return cell;
}
/**
 创建区头视图和区尾视图
 */
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader){
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyCollectionViewHeaderView" forIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor yellowColor];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:headerView.bounds];
//        titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区头",indexPath.section];
//        [headerView addSubview:titleLabel];
//        return headerView;
//    }else if(kind == UICollectionElementKindSectionFooter){
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyCollectionViewFooterView" forIndexPath:indexPath];
//        footerView.backgroundColor = [UIColor blueColor];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:footerView.bounds];
//        titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区尾",indexPath.section];
//        [footerView addSubview:titleLabel];
//        return footerView;
//    }
//    return nil;
//
//
//}

/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
    self.isClickScroll = YES;
    UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    self.lineView.frame = CGRectMake(CGRectGetMinX(cell.frame), kCellHeight- 3, [self titleWidth:self.imagesArray[indexPath.row]], 3);
    UIViewController *vc = [self unusedViewController:indexPath.row];
    if (indexPath.item > self.currentIndex) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    [self.collecitonView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self titleWidth:self.imagesArray[indexPath.item]], 30);
}

/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSpacing, kSpacing, kSpacing, kSpacing);
}

/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kSpacing;
}

/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
///**
// 区头大小
// */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(20, 200);
//}
///**
// 区尾大小
// */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(20, 200);
//}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    if (!self.isClickScroll) {
//        NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
//        [self.collecitonView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        self.isClickScroll = NO;
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!self.isClickScroll && decelerate) {
//        NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
//        [self.collecitonView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        self.isClickScroll = NO;
//    }
//}

#pragma mark - get
- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.imagesArray.count] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        for (UIView *subView in _pageViewController.view.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)subView).delegate = self;
            }
        }
    }
    
    return _pageViewController;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    TestViewController *vc = (TestViewController *)viewController;
    NSInteger index = vc.index;
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    --index;
    return  [self unusedViewController:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    TestViewController *vc = (TestViewController *)viewController;
    NSInteger index = vc.index;
    ++index;
    return  [self unusedViewController:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    TestViewController *nextVC = (TestViewController *)[pendingViewControllers firstObject];
//    NSInteger index = [self.imagesArray indexOfObject:nextVC];
    self.currentIndex = nextVC.index;
    [self.collecitonView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    UICollectionViewCell *cell = [self collectionView:self.collecitonView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    self.lineView.frame = CGRectMake(CGRectGetMinX(cell.frame), kCellHeight- 3, [self titleWidth:self.imagesArray[self.currentIndex]], 3);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
    }
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor yellowColor];
    }
    return _lineView;
}
@end
