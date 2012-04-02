//
//  ANAsmOperand.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANAsmOperand <NSObject>

- (NSData *)encodeOperand;
- (UInt16)dataSize;

@end
