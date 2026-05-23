//
//  SUPMapLocationModel.h
//  SUPER-PTT
//
//  Created by broad on 2024/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUPLocationModel : NSObject

@property(nonatomic,assign) CGFloat Lat;
@property(nonatomic,assign) CGFloat Lon;

@end


@interface SUPMapLocationModel : NSObject

@property(nonatomic,assign) NSInteger Uid;
@property(nonatomic,assign) NSInteger CompId;
@property(nonatomic,assign) CGFloat Speed;
@property(nonatomic,assign) CGFloat Direction;
@property(nonatomic,assign) NSInteger Stimestamp;
@property(nonatomic,assign) NSInteger Rtimestamp;
@property(nonatomic,assign) NSInteger CoordinateType;
@property(nonatomic,assign) CGFloat Altitude;
// 卫星定位(GPS)  = 1、基站定位 = 2、WIFI定位 = 3、AGPS = 4
@property(nonatomic,assign) NSInteger PositionType;
@property(nonatomic,copy) NSString *Address;
@property(nonatomic,copy) NSString *_class;
@property(nonatomic,strong) SUPLocationModel *Baidu;
@property(nonatomic,strong) SUPLocationModel *Gcj;
@property(nonatomic,strong) SUPLocationModel *Wgs84;

@end

NS_ASSUME_NONNULL_END
