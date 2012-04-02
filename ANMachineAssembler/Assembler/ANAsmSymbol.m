//
//  ANAsmSymbol.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmSymbol.h"
#import "ANAsmProgram.h"

@implementation ANAsmSymbol

@synthesize program;
@synthesize name;

- (id)initWithName:(NSString *)aName program:(ANAsmProgram *)aProgram {
    if ((self = [super init])) {
        program = aProgram;
        name = aName;
    }
    return self;
}

- (NSData *)encodeOperand {
    UInt16 offset = [self offsetInProgram];
    UInt8 bytes[2];
    bytes[0] = offset & 255;
    bytes[1] = (offset >> 8) & 255;
    return [NSData dataWithBytes:bytes length:2];
}

- (UInt16)dataSize {
    return 2;
}

- (UInt16)offsetInProgram {
    return [program offsetOfSymbol:self.name];
}

@end
