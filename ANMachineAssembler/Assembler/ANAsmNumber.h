//
//  ANAsmNumber.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmOperand.h"

@interface ANAsmNumber : NSObject <ANAsmOperand> {
    UInt16 number;
}

- (id)initWithNumber:(UInt16)aNum;

@end
