//
//  ANAsmProgram.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmProgram.h"

@interface ANAsmProgram (Private)

- (NSString *)processSymbol:(NSArray *)symbolLine;

@end

@implementation ANAsmProgram

@synthesize programFlow;

- (id)initWithLines:(NSArray *)lines {
    if ((self = [super init])) {
        NSMutableArray * flow = [[NSMutableArray alloc] init];
        symbols = [[NSMutableDictionary alloc] init];
        UInt16 offset = 0;
        
        for (NSUInteger i = 0; i < [lines count]; i++) {
            NSArray * line = [lines objectAtIndex:i];
            if ([line count] == 0) continue;
            
            if ([[[line objectAtIndex:0] stringValue] isEqualToString:@":"]) {
                NSString * symbol = [self processSymbol:line];
                if (!symbol) {
                    flow = nil;
                    symbols = nil;
                    @throw [NSException exceptionWithName:@"Invalid Symbol"
                                                   reason:@"Invalid symbol declaration"
                                                 userInfo:nil];
                }
                [symbols setObject:[NSNumber numberWithUnsignedShort:offset]
                            forKey:symbol];
            } else {
                ANAsmInstruction * instruction = [[ANAsmInstruction alloc] initWithLine:line
                                                                                program:self];
                if (!instruction) {
                    flow = nil;
                    symbols = nil;
                    @throw [NSException exceptionWithName:@"Invalid Instruction"
                                                   reason:@"Invalid instruction call"
                                                 userInfo:nil];
                }
                [flow addObject:instruction];
                offset += [instruction dataSize];
            }
        }
        
        programFlow = [flow copy];
    }
    return self;
}

- (UInt16)offsetOfSymbol:(NSString *)name {
    NSNumber * number = [symbols objectForKey:name];
    if (!number) {
        NSString * reason = [NSString stringWithFormat:@"Unknown symbol name: %@", name];
        @throw [NSException exceptionWithName:@"Unknown Symbol"
                                       reason:reason
                                     userInfo:nil];
    }
    return [number unsignedShortValue];
}

- (NSData *)compileProgram {
    NSMutableData * data = [[NSMutableData alloc] init];
    for (ANAsmInstruction * instruction in programFlow) {
        [data appendData:[instruction encodeInstruction]];
    }
    return [data copy];
}

#pragma mark Privateo

- (NSString *)processSymbol:(NSArray *)symbolLine {
    if ([symbolLine count] != 2) {
        return nil;
    }
    return [[symbolLine objectAtIndex:1] stringValue];
}

@end
