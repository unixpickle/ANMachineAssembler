//
//  ANAsmTokenizer.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmTokenizer.h"

@interface ANAsmToken (Private)

- (NSCharacterSet *)symbolCharacters;
- (void)readToNewLine;
- (void)readOverWhitespace;
- (NSString *)readCharactersInSet:(NSCharacterSet *)set;

@end

@implementation ANAsmTokenizer

- (id)initWithText:(NSString *)programBody {
    if ((self = [super init])) {
        buffer = programBody;
        offset = 0;
    }
    return self;
}

- (unichar)readCharacter {
    if (offset == [buffer length]) {
        return 0;
    }
    return [buffer characterAtIndex:offset++];
}

- (NSArray *)allLines {
    NSMutableArray * lines = [[NSMutableArray alloc] init];
    NSArray * line = nil;
    while ([(line = [self nextLine]) count] > 0) {
        [lines addObject:line];
    }
    return [lines copy];
}

- (NSArray *)nextLine {
    NSMutableArray * lineArray = [[NSMutableArray alloc] init];
    ANAsmToken * token = nil;
    while ((token = [self nextToken]) != nil) {
        if ([[token stringValue] isEqualToString:@"\n"]) {
            break;
        }
        [lineArray addObject:token];
    }
    return [lineArray copy];
}

- (ANAsmToken *)nextToken {
    // read up to end of whitespace
    [self readOverWhitespace];
    
    NSCharacterSet * singleChars = [NSCharacterSet characterSetWithCharactersInString:@",:$%\n"];
    NSCharacterSet * symbolChars = [self symbolCharacters];

    unichar start = [self readCharacter];
    if (start == 0) {
        return nil;
    }
    if (start == '#') {
        [self readToNewLine];
        return [self nextToken];
    }
    
    NSString * str = nil;
    if ([symbolChars characterIsMember:start]) {
        offset--;
        str = [self readCharactersInSet:symbolChars];
    } else if ([singleChars characterIsMember:start]) {
        str = [NSString stringWithFormat:@"%C", start];
    } else {
        NSString * reason = [NSString stringWithFormat:@"Unknow character: %C", start];
        @throw [NSException exceptionWithName:@"Syntax error"
                                       reason:reason
                                     userInfo:nil];
    }
    
    return [[ANAsmToken alloc] initWithString:str];
}

#pragma mark Parsing

- (NSCharacterSet *)symbolCharacters {
    NSMutableCharacterSet * set = [[NSMutableCharacterSet alloc] init];
    for (unichar theChar = 'a'; theChar <= 'z'; theChar++) {
        NSString * string = [NSString stringWithFormat:@"%C%C", theChar, toupper(theChar)];
        [set addCharactersInString:string];
    }
    for (int i = 0; i < 10; i++) {
        NSString * string = [NSString stringWithFormat:@"%d", i];
        [set addCharactersInString:string];
    }
    return [set copy];
}

- (void)readToNewLine {
    unichar c = 0;
    while ((c = [self readCharacter]) != 0) {
        if (c == '\n') {
            offset--;
            return;
        }
    }
    return;
}

- (void)readOverWhitespace {
    NSCharacterSet * whitespace = [NSCharacterSet whitespaceCharacterSet];
    unichar c = 0;
    while ((c = [self readCharacter]) != 0) {
        if (![whitespace characterIsMember:c]) {
            offset--;
            return;
        }
    }
    return;
}

- (NSString *)readCharactersInSet:(NSCharacterSet *)set {
    NSMutableString * string = [[NSMutableString alloc] init];
    unichar c = 0;
    while ((c = [self readCharacter]) != 0) {
        if (![set characterIsMember:c]) {
            offset--;
            break;
        }
        [string appendFormat:@"%C", c];
    }
    return [string copy];
}

@end
