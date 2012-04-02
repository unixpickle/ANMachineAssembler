//
//  ANAsmProgram.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmInstruction.h"
#import "ANAsmSymbol.h"

@interface ANAsmProgram : NSObject {
    NSArray * programFlow;
    NSMutableDictionary * symbols;
}

@property (readonly) NSArray * programFlow;

- (id)initWithLines:(NSArray *)lines;
- (UInt16)offsetOfSymbol:(NSString *)name;
- (NSData *)compileProgram;

@end
