//
//  TDCameraPreview.h
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TDCameraPreview;
@protocol TDCameraPreviewDelegate <NSObject>
@required;
- (void)viewDidTapWithPreview:(TDCameraPreview *)preiview;
@end

@interface TDCameraPreview : UIView
@property (nonatomic, weak) id<TDCameraPreviewDelegate> delegate;
@property (nonatomic, copy) NSString *plainText;
@end

NS_ASSUME_NONNULL_END
