//
//  ANAsmToken.h
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAsmToken : NSObject {
    NSString * stringValue;
}

@property (readonly) NSString * stringValue;

- (id)initWithString:(NSString *)string;

@end
