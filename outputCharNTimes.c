/*
 * Filename: outputCharNTimes.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 17, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Function Name: outputCharNTimes()
 * Function Prototype: void ( char ch, int n );
 * Description: Prints the character N times to stdout 
 * Parameters: ch - the character to print 
 *             n - the int determining the amount of times to print 
 * Side Effects: None
 * Error Conditions: None
 * Return Value: None
 */ 
void outputCharNTimes( char ch, int n ) {
  int i;  
  
  // Print the character using outputChar n times
  for ( i = 0; i < n; i++ ) {
    outputChar( ch );
  }
}

