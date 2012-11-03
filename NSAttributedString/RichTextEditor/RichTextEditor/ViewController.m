//
//  ViewController.m
//  RichTextEditor
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44.0f)];
    UIBarButtonItem *boldButton = [[UIBarButtonItem alloc] initWithTitle:@"B"
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(bold:)];
    UIBarButtonItem *underlineButton = [[UIBarButtonItem alloc] initWithTitle:@"U"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                       action:@selector(underline:)];
    UIBarButtonItem *strikeButton = [[UIBarButtonItem alloc] initWithTitle:@"S"
                                                                        style:UIBarButtonItemStyleBordered
                                                                    target:self action:@selector(strike:)];
    UIBarButtonItem *highlightButton = [[UIBarButtonItem alloc] initWithTitle:@"Marker"
                                                                     style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                       action:@selector(highlight:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(clear:)];
    
    toolbar.items = @[boldButton, underlineButton, strikeButton, highlightButton, flexibleSpace, clearButton];
    
    self.textView.inputAccessoryView = toolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)bold:(id)sender
{
    [self applyAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24.0f], NSForegroundColorAttributeName : [UIColor redColor]}];
}

- (void)strike:(id)sender
{
    [self applyAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (void)underline:(id)sender
{
    [self applyAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (void)highlight:(id)sender
{
    [self applyAttributes:@{NSBackgroundColorAttributeName : [UIColor yellowColor]}];
}

- (void)clear:(id)sender
{
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
	[text addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:24.0f]} range:NSMakeRange(0, self.textView.text.length)];
	self.textView.attributedText = text;
}

- (void)applyAttributes:(NSDictionary *)attributes {
	NSRange selection = self.textView.selectedRange;
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
	
	[text addAttributes:attributes range:selection];
	self.textView.attributedText = text;
	self.textView.selectedRange = selection;
}

@end
