//
//  JWShowCell.m
//  JesterWildApp
//

#import "JWShowCell.h"
#import "JWShow.h"

@interface JWShowCell ()
{
    UILabel* label;
}
@end

@implementation JWShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.frame = CGRectMake(0,0, width, 44);
        label = [[UILabel alloc] initWithFrame:[self frame]];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = -1;
        [self addSubview:label];
    }
    return self;
}

- (void) setLabelText:(NSString *)text
{
    label.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
