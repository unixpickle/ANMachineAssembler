//
//  ANAsmToken.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAsmToken.h"

@implementation ANAsmToken

@synthesize stringValue;

- (id)initWithString:(NSString *)string {
    if ((self = [super init])) {
        stringValue = string;
    }
    return self;
}

- (NSString *)description {
    return stringValue;
}

@end
