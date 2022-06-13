NSString *WMText = @"https://hudware-store.github.io"; 
UILabel *watermark;

watermark = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, window.frame.size.width / 4, 20)];
watermark.text = WMText;
watermark.adjustsFontSizeToFitWidth = YES;
watermark.center = CGPointMake(CGRectGetMinX(window.frame) + watermark.frame.size.width / 2 + 10, CGRectGetMaxY(window.frame) - watermark.frame.size.height - 5);
watermark.textAlignment = NSTextAlignmentCenter;

NSUInteger characterCount = [WMText length];

CGFloat randColor = arc4random_uniform(256) / 255.0;
int charsFinished;
CGFloat extraHue;


CGFloat smoothness = 0.02;

NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: watermark.attributedText];

for (charsFinished = 0, extraHue = 0.0; charsFinished != characterCount; charsFinished = charsFinished + 1, extraHue = extraHue + smoothness) {
  [text addAttribute: NSForegroundColorAttributeName
    value: [UIColor colorWithHue:randColor + extraHue saturation:1.0 brightness:1.0 alpha:1.0]
    range: NSMakeRange(charsFinished, 1)];
}

[watermark setAttributedText: text];

//ADD WATERMARK TO THE VIEW YOU WANT 
[window addSubview: watermark];