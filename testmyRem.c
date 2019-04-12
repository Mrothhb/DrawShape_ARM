/*
 * Filename: testmyRem.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for myRem.s
 *
 * int myRem( int dividend, int divisor );
 *
 * Acts as a % operator like in C. returns the remainder of two operands.
 *
 **/
void testmyRem() {

  TEST(myRem( 6, 3 ) == 0);   // test dividend > divisor 
  TEST(myRem( 3, 6 ) == 3);   // test dividend < divisor 
  TEST(myRem( 0, 0 ) == 0);   // test zero zero case
  TEST(myRem( 6, 1 ) == 0);   // test mod one case
  TEST(myRem( 6, 0 ) == 0);   // test zero case TODO fails
  TEST(myRem( 0, 6 ) == 0);   // test 0 mod with divisor case
  TEST(myRem(-6, 5 ) == -1);  // test negative dividend case
  TEST(myRem( 6, -5 ) == 1);  // test negative divisor case 
  TEST(myRem( 2, 2 ) == 0);   // test dividend == divisor 
  TEST(myRem( -6, -6 ) == 0); // test negative dividend and divisor 
  
  /*
   * TODO: YOU MUST WRITE MORE TEST CASES FOR FULL POINTS!
   *
   * Some things to think about are error cases, extreme cases, normal cases,
   * abnormal cases, etc.
   */
}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testmyRem();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
