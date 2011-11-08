//
//  ULIAppDelegate.m
//  CodingService
//
//  Created by Uli Kusterer on 07.11.11.
//  Copyright (c) 2011 The Void Software. All rights reserved.
//

#import "ULIAppDelegate.h"

@implementation ULIAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
	[[NSApplication sharedApplication] setServicesProvider: self];
}


-(void)	encloseInBrackets: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *newString = [NSString stringWithFormat: @"(%@)",pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"self couldn't rotate letters.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	[pboard clearContents];
	[pboard writeObjects: [NSArray arrayWithObject:newString]];
}


-(void)	encloseInSquareBrackets: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *newString = [NSString stringWithFormat: @"[%@]",pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"self couldn't rotate letters.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	[pboard clearContents];
	[pboard writeObjects: [NSArray arrayWithObject:newString]];
}


-(void)	encloseInQuotes: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\\" withString: @"\\\\" options: 0 range: NSMakeRange(0,[pboardString length])];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\"" withString: @"\\\"" options: 0 range: NSMakeRange(0,[pboardString length])];
	NSString *newString = [NSString stringWithFormat: @"\"%@\"", pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"self couldn't rotate letters.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	[pboard clearContents];
	[pboard writeObjects: [NSArray arrayWithObject:newString]];
}


-(void)	copyConstantDeclaration: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *quotedPboardString = [pboardString stringByReplacingOccurrencesOfString: @"\\" withString: @"\\\\" options: 0 range: NSMakeRange(0,[pboardString length])];
	quotedPboardString = [quotedPboardString stringByReplacingOccurrencesOfString: @"\"" withString: @"\\\"" options: 0 range: NSMakeRange(0,[pboardString length])];
	NSString *newString = [NSString stringWithFormat: @"NSString*	%@ = \"%@\";", pboardString, quotedPboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't encrypt text.", @"self couldn't rotate letters.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	NSPasteboard	*	clipboard = [NSPasteboard generalPasteboard];
	[clipboard clearContents];
	[clipboard writeObjects: [NSArray arrayWithObject:newString]];
}

@end
