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
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *newString = [NSString stringWithFormat: @"(%@)",pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
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
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *newString = [NSString stringWithFormat: @"[%@]",pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	[pboard clearContents];
	[pboard writeObjects: [NSArray arrayWithObject:newString]];
}


-(void)	encloseInCurlyBrackets: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSUInteger			indentLength = 0;
	NSString			*pboardString = [pboard stringForType: NSPasteboardTypeString];
	for( NSUInteger x = 0; x < [pboardString length]; x++ )
	{
		switch( [pboardString characterAtIndex: x] )
		{
			case ' ':
			case '\t':
				indentLength++;
				break;
			default:
				x = [pboardString length];	// exit loop
				break;
		}
	}
	NSString	*	indentString = [pboardString substringToIndex: indentLength];
	NSArray		*	pboardLines = [pboardString componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"\n\r"]];
	NSMutableString	*	newString = [NSMutableString stringWithString: indentString];
	[newString appendString: @"{\n"];
	for( NSString* currLine in pboardLines )
	{
		[newString appendString: indentString];
		[newString appendString: @"\t"];
		[newString appendString: [currLine stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
		[newString appendString: @"\n"];
	}
	[newString appendString: indentString];
	[newString appendString: @"}\n"];

	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
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
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\\" withString: @"\\\\" options: 0 range: NSMakeRange(0,[pboardString length])];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\"" withString: @"\\\"" options: 0 range: NSMakeRange(0,[pboardString length])];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\r" withString: @"\\r" options: 0 range: NSMakeRange(0,[pboardString length])];
	pboardString = [pboardString stringByReplacingOccurrencesOfString: @"\n" withString: @"\\n" options: 0 range: NSMakeRange(0,[pboardString length])];
	NSString *newString = [NSString stringWithFormat: @"\"%@\"", pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
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
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *quotedPboardString = [pboardString stringByReplacingOccurrencesOfString: @"\\" withString: @"\\\\" options: 0 range: NSMakeRange(0,[pboardString length])];
	quotedPboardString = [quotedPboardString stringByReplacingOccurrencesOfString: @"\"" withString: @"\\\"" options: 0 range: NSMakeRange(0,[pboardString length])];
	NSString *newString = [NSString stringWithFormat: @"NSString*	%@ = @\"%@\";", pboardString, quotedPboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	NSPasteboard	*	clipboard = [NSPasteboard generalPasteboard];
	[clipboard clearContents];
	[clipboard writeObjects: [NSArray arrayWithObject:newString]];
}


-(void)	pasteAsIfdefWrappingSelection: (NSPasteboard *)pboard userData: (NSString *)userData error: (NSString **)outError
{
	NSArray			*classes = [NSArray arrayWithObject:[NSString class]];
	NSDictionary	*options = [NSDictionary dictionary];
	if (![pboard canReadObjectForClasses:classes options:options])
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"pboard couldn't give string.");
		return;
	}
	
	NSString 		*	identifierString = @"DEBUG";
	NSPasteboard	*	clipboard = [NSPasteboard generalPasteboard];
	if( [clipboard canReadObjectForClasses:classes options:options] )
		identifierString = [clipboard stringForType: NSPasteboardTypeString];
	
	// Get and modify the string.
	NSString *pboardString = [pboard stringForType: NSPasteboardTypeString];
	NSString *newString = [NSString stringWithFormat: @"#if %1$@\n%2$@\n#endif // %1$@", identifierString, pboardString];
	if (!newString)
	{
		*outError = NSLocalizedString(@"Error: couldn't filter text.", @"self couldn't filter string.");
		return;
	}
	
	// Write the modified string onto the pasteboard.
	[pboard clearContents];
	[pboard writeObjects: [NSArray arrayWithObject:newString]];
}

@end
