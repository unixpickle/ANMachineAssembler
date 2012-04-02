//
//  ANAsmInstruction.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmInstruction.h"
#import "ANAsmProgram.h"

@interface ANAsmInstruction (Private)

- (BOOL)getOpcode:(ANAsmToken *)token;
- (BOOL)parseArguments:(NSArray *)tokens;
- (NSNumber *)parseNumber:(NSString *)numStr;

@end

@implementation ANAsmInstruction

- (id)initWithLine:(NSArray *)tokens program:(ANAsmProgram *)theProgram {
    if ((self = [super init])) {
        program = theProgram;
        if ([tokens count] == 0) return nil;
        if (![self getOpcode:[tokens objectAtIndex:0]]) return nil;
        if (![self parseArguments:tokens]) return nil;
    }
    return self;
}

- (NSData *)encodeInstruction {
    NSMutableData * data = [[NSMutableData alloc] init];
    if (opcode < 256) [data appendBytes:&opcode length:1];
    for (id<ANAsmOperand> op in operands) {
        [data appendData:[op encodeOperand]];
    }
    return [data copy];
}

- (UInt16)dataSize {
    UInt16 sum = (opcode < 256 ? 1 : 0);
    for (id<ANAsmOperand> op in operands) {
        sum += [op dataSize];
    }
    return sum;
}

- (BOOL)getOpcode:(ANAsmToken *)token {
    NSString * cmdName = [token stringValue];
    NSDictionary * opcodes = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:0], @"nop", 
                              [NSNumber numberWithInt:1], @"set", 
                              [NSNumber numberWithInt:2], @"copy", 
                              [NSNumber numberWithInt:3], @"read", 
                              [NSNumber numberWithInt:4], @"write", 
                              [NSNumber numberWithInt:5], @"xor", 
                              [NSNumber numberWithInt:6], @"and", 
                              [NSNumber numberWithInt:7], @"or", 
                              [NSNumber numberWithInt:8], @"add", 
                              [NSNumber numberWithInt:9], @"sub", 
                              [NSNumber numberWithInt:10], @"div", 
                              [NSNumber numberWithInt:11], @"mul", 
                              [NSNumber numberWithInt:12], @"cmp", 
                              [NSNumber numberWithInt:13], @"ljmp", 
                              [NSNumber numberWithInt:14], @"ajmp", 
                              [NSNumber numberWithInt:15], @"jge", 
                              [NSNumber numberWithInt:16], @"jle", 
                              [NSNumber numberWithInt:17], @"je", 
                              [NSNumber numberWithInt:18], @"bell", 
                              [NSNumber numberWithInt:19], @"print", 
                              [NSNumber numberWithInt:20], @"readch", 
                              [NSNumber numberWithInt:21], @"hlt", 
                              [NSNumber numberWithInt:22], @"readreg", 
                              [NSNumber numberWithInt:23], @"writereg", 
                              [NSNumber numberWithInt:256], @"data", nil];
    NSNumber * opcodeObj = [opcodes objectForKey:cmdName];
    if (!opcodeObj) return NO;
    opcode = [opcodeObj unsignedIntegerValue];
    return YES;
}

- (BOOL)parseArguments:(NSArray *)tokens {
    NSArray * prefixes = [NSArray arrayWithObjects:@"%", @"$", nil];
    NSMutableArray * ops = [[NSMutableArray alloc] init];
    for (int i = 1; i < [tokens count]; i++) {
        ANAsmToken * token = [tokens objectAtIndex:i];
        NSString * opStr = [token stringValue];
        if ([opStr isEqualToString:@","]) continue;
        
        id op = nil;
        if ([prefixes containsObject:opStr]) {
            if (i + 1 == [tokens count]) return NO;
            
            ANAsmToken * numToken = [tokens objectAtIndex:++i];
            NSNumber * num = [self parseNumber:[numToken stringValue]];
            if (!num) return NO;
            
            UInt16 number = [num unsignedShortValue];
            if ([opStr isEqualToString:@"%"]) {
                op = [[ANAsmRegister alloc] initWithRegister:(UInt8)number];
            } else {
                op = [[ANAsmNumber alloc] initWithNumber:number];
            }
        } else {
            op = [[ANAsmSymbol alloc] initWithName:opStr program:program];
        }
        [ops addObject:op];
    }
    operands = [ops copy];
    return YES;
}

- (NSNumber *)parseNumber:(NSString *)numStr {
    NSScanner * scanner = [NSScanner scannerWithString:numStr];
    unsigned int number = 0;
    
    if ([numStr hasPrefix:@"0x"]) {
        [scanner setScanLocation:2]; // bypass '#' character
        if (![scanner scanHexInt:&number]) return nil;
    } else {
        if (![scanner scanInt:(int *)&number]) return nil;
    }
    return [NSNumber numberWithUnsignedInt:number];
}

@end
