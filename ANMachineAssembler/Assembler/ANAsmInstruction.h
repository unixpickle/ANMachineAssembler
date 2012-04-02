//
//  ANAsmInstruction.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmNumber.h"
#import "ANAsmRegister.h"
#import "ANAsmSymbol.h"
#import "ANAsmToken.h"

@class ANAsmProgram;

@interface ANAsmInstruction : NSObject {
    NSUInteger opcode;
    NSArray * operands;
    __weak ANAsmProgram * program;
}

- (id)initWithLine:(NSArray *)tokens program:(ANAsmProgram *)theProgram;
- (NSData *)encodeInstruction;
- (UInt16)dataSize;

@end
