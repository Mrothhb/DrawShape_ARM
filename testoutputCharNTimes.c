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
  outputCharNTimes( 'a', 20 );  //print one char 20 times
  outputCharNTimes( ' ', 2000 );  //print a symbol 2000 times

  
  /*
   * TODO: YOU MUST WRITE MORE TEST CASES FOR FULL POINTS!
   *
   * Some things to think about are error cases, extreme cases, normal cases,
   * abnormal cases, etc.
   */
}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testoutputCharNTimes();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
