/*
 * Filename: drawCoolSEC.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 24, 2019
 * Sources of Help: Textbook, cse 30 wbesite, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa1.h"
#define INVALID_BASE 2
#define EXIT_FAILURE 0

// Function prototype for drawStraight
void drawStraight( int size, char fillChar );

/*
 * Function name: drawCoolSEC():
 * Function Prototype: void drawCoolS( int size, char fillChar );
 * Description: This function will print out the entire Cool S design using
 * the given size and fillChar specified by the user. Helper methods 
 * drawCrissCross.c and drawCap.s will be called to help draw the Cool S.
 * the Cool S. This function will also print extra criss-cross and straight
 * section patterns in the middle of the Cool S determined by the size argument.
 * Parameters: size - the size of the Cool S
 *             fillChar - the character used to fill in the Cool S design
 * Side Effects: Prints out the Cool S to stdout with extra criss-cross and 
 * straight section.
 * Error Conditions: None
 * Return Value: None
 */
void drawCoolS( int size, char fillChar ) {  
  int sum_of_digits;    // The sum of the digits in size 
  int i;
  int base = BASE;      // Base to extract the digits 

  // Use the sum of the digits in the size to determine print count 
  sum_of_digits = sumOfDigits( size, base );
  
  // Error checking if the base is less than 2
  if( sum_of_digits < INVALID_BASE ) {
    fprintf( stderr, "Invalid Base -- Base must be at least 2 -- %c", 
              NEWLINE_CHAR);
    return EXIT_FAILURE;
  }

  // Draw the top cap
  drawCap( size, fillChar, DIR_UP );
  
  // Print the criss-cross and the straight section sum_of_digits times
  for ( i = 0; i < sum_of_digits; i++ ) {
    // Draw the first straight section 
    drawStraight( size, fillChar );
    // Draw the criss-cross pattern 
    drawCrissCross( size, fillChar );

    }

    // Draw the last straight section
    drawStraight( size, fillChar );
    // Draw the bottom cap
    drawCap( size, fillChar, DIR_DOWN );
}

/*
 * Function name: drawStraight()
 * Function Prototype: void drawStraight( int size, char fillChar );
 * Description: This function will print out the straight portions of the Cool
 * S using the size and the fillChar. 
 * Parameters: size - the size of the Cool S
 *             fillChar - the character used to fill in the Cool S design
 * Side Effects: Prints out the straight portion of Cool S to stdout.
 * Error Conditions: None.
 * Return Value: None.
 */
void drawStraight( int size, char fillChar ) {
  int i;
  // Calculate thickness of the Cool S
  int thickness = size / HALF_DIVISOR - 1;    

  // Print the straight portion the amount of times determined by thickness
  for ( i = 0; i < thickness; i++ ) {
    //Draw the top portion of the first middle straight section
    outputChar( PIPE_CHAR );

    // Draw the fill characters
    outputCharNTimes( fillChar, thickness );
    outputChar( PIPE_CHAR );
    outputCharNTimes( fillChar, thickness );
    outputChar( PIPE_CHAR );

    // Start the next line
    outputChar( NEWLINE_CHAR );
 }
}
