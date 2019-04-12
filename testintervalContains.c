/*
 * Filename: testintervalContains.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for intervalContains.s
 *
 * int intervalContains( int start, int end, int value );
 *
 * Checks to see if the interval contains the value (inclusive on both ends).
 *
 * Returns -1 if start > end
 * Returns 1 if the interval contains the value
 * Returns 0 otherwise.
 */
void testintervalContains() {


  /* Test interval containing the value */
  TEST( intervalContains( 0, 2, 1 ) == 1 );

  /* Test interval containing the value */
  TEST( intervalContains( 0, 1, 0 ) == 1 );

  /*
   * TODO: YOU MUST WRITE MORE TEST CASES FOR FULL POINTS!
   *
   * Some things to think about are error cases, extreme cases, normal cases,
   * abnormal cases, etc.
   */
}


int main( void ) {

  fprintf( stderr, "Running tests for intervalContains...\n" );
  testintervalContains();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
