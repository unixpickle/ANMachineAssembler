//
//  ANAsmNumber.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmNumber.h"

@implementation ANAsmNumber

- (id)initWithNumber:(UInt16)aNum {
    if ((self = [super init])) {
        number = aNum;
    }
    return self;
}

- (NSData *)encodeOperand {
    UInt8 bytes[2];
    bytes[0] = number & 255;
    bytes[1] = (number >> 8) & 255;
    return [NSData dataWithBytes:bytes length:2];
}

- (UInt16)dataSize {
    return 2;
}

@end
