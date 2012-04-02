//
//  ANAsmRegister.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmOperand.h"

@interface ANAsmRegister : NSObject <ANAsmOperand> {
    UInt8 regID;
}

- (id)initWithRegister:(UInt8)regNum;

@end
