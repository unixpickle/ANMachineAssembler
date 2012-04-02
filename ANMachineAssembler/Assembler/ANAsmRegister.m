//
//  ANAsmRegister.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmRegister.h"

@implementation ANAsmRegister

- (id)initWithRegister:(UInt8)regNum {
    if ((self = [super init])) {
        regID = regNum;
    }
    return self;
}

- (NSData *)encodeOperand {
    return [NSData dataWithBytes:&regID length:1];
}

- (UInt16)dataSize {
    return 1;
}

@end
