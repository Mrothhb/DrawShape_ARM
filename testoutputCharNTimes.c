/*
 * Filename: testoutputCharNTimes.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for outputCharNTimes.c
 *
 * void outputChar( char ch, int n );
 *
 * Prints the parameter character to stdout N times.
 *
 **/
void testoutputCharNTimes() {

  //test cases for outputCharNTimes 

  outputCharNTimes( 'a', 20 );    // print one char 20 times
  outputCharNTimes( ' ', 10 );    // print a empty char 2000 times
  outputCharNTimes( "a", 10 );    // test String case 
  outputCharNTimes( '!', 10 );    // print a symbol 10 times
  outputCharNTimes( 'b', -10 );   // test negative case 
  outputCharNTimes( '1', 10 );    // test the numeric digit case 
  outputCharNTimes( 'a', 0 );     // test zero times case  
  outputCharNTimes( "", 10 );     // test the empty string 
  outputCharNTimes( '\0', 10);    // test the null character
  outputCharNTimes( '\n', 10);    // test the newline character  

}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testoutputCharNTimes();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
