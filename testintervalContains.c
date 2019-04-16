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


  TEST( intervalContains( 0, 2, 1 ) == 1 );   // test basic  0 - 2 interval
  TEST( intervalContains( 0, 1, 0 ) == 1 );   // test basic 0 - 1 interval   
  TEST( intervalContains( 0, 0, 0 ) == 1 );   // test all zeros case
  TEST( intervalContains( 2, 1, 0 ) == -1 );  // test start > end 
  TEST( intervalContains( 0, 1, 5 ) == 0 );   // test outside of range end
  TEST( intervalContains( 4, 6, 1 ) == 0 );   // test outside range begining
  TEST( intervalContains( 0, 2, -1 ) == 0 );  // test negative value out beg
  TEST( intervalContains(-4,-1,-2 ) == 1 );   // test all negative in range
  TEST( intervalContains(-4,-1,-5 ) == 0 );   // test all negative outside range
  TEST( intervalContains( -4, 0, -2 ) == 1 ); // test negative start to zero
  TEST( intervalContains(-2,-2,-2 ) == 1 );   // test all same negative
  TEST( intervalContains( 2, 2, 2 ) == 1 );   // test all same positive

}


int main( void ) {

  fprintf( stderr, "Running tests for intervalContains...\n" );
  testintervalContains();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
