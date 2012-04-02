//
//  ANAsmSymbol.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmOperand.h"

@class ANAsmProgram;

@interface ANAsmSymbol : NSObject <ANAsmOperand> {
    __weak ANAsmProgram * program;
    NSString * name;
}

@property (nonatomic, weak) ANAsmProgram * program;
@property (readonly) NSString * name;

- (id)initWithName:(NSString *)aName program:(ANAsmProgram *)aProgram;
- (UInt16)offsetInProgram;

@end
