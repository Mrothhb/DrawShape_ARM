/*
 * Filename: drawStraight.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Textbook, cse 30 wbesite, lecture notes, discussion notes.
 */
#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Function name: drawStraight()
 * Function Prototype: void drawStraight( int size, char fillChar );
 * Description: TODO This function will print out the entire Cool S design using
 * the given size and fillCharspecified by the user. Helper methods 
 * drawCrissCross.c and drawCap.s will be called to help draw the Cool S.
 * the Cool S. 
 * Parameters: size - the size of the Cool S
 *             fillChar - the character used to fill in the Cool S design
 * Side Effects: Prints out the Cool S to stdout.
 * Error Conditions: None
 * Return Value: None
 */
void drawStraight( int size, char fillChar ) {
  int i;
  // Calculate thickness of the Cool S
  int thickness = size / HALF_DIVISOR - 1;    

  // Draw the first straight section
  for ( i = 0; i < thickness / HALF_DIVISOR + 1; i++ ) {
    //Draw the top portion of the first middle straight section
    outputChar( PIPE_CHAR );

    // Draw the fill characters
    outputCharNTimes( fillChar, thickness );
    outputChar( PIPE_CHAR );

    // Start the next line
    outputChar( NEWLINE_CHAR );
  }
}

