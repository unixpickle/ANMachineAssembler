//
//  main.m
//  ANMachineAssembler
//
//  Created by Alex Nichol on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAsmTokenizer.h"
#import "ANAsmProgram.h"

int main (int argc, const char * argv[]) {
    /*if (argc != 3) {
        fprintf(stderr, "Usage: %s <infile> <outfile>\n", argv[0]);
        return 1;
    }*/
    @autoreleasepool {
        //NSString * input = [NSString stringWithUTF8String:argv[1]];
        //NSString * output = [NSString stringWithUTF8String:argv[2]];
        
        NSString * input = @"/Users/alex/Desktop/script.txt";
        NSString * output = @"/Users/alex/Desktop/program";
        
        NSString * text = [NSString stringWithContentsOfFile:input
                                                     encoding:NSASCIIStringEncoding
                                                       error:nil];
        if (!text) {
            fprintf(stderr, "%s: error: failed to read input file\n", argv[0]);
            return 1;
        }
        ANAsmTokenizer * tokenizer = [[ANAsmTokenizer alloc] initWithText:text];
        NSArray * lines = [tokenizer allLines];
        ANAsmProgram * program = [[ANAsmProgram alloc] initWithLines:lines];
        NSData * encoded = [program compileProgram];
        if (![encoded writeToFile:output atomically:YES]) {
            fprintf(stderr, "%s: error: failed to write to output file\n", argv[0]);
            return 1;
        }
    }
    return 0;
}

