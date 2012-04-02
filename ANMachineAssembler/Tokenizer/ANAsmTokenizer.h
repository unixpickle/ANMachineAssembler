//
//  ANAsmTokenizer.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmToken.h"

@interface ANAsmTokenizer : NSObject {
    NSString * buffer;
    NSUInteger offset;
}

- (id)initWithText:(NSString *)programBody;
- (unichar)readCharacter;

- (NSArray *)allLines;
- (NSArray *)nextLine;
- (ANAsmToken *)nextToken;

@end
