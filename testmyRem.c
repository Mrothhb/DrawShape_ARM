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
  
  int charA = 'a';
  char charSym = 0x7E;

  TEST(myRem( 6, 3 ) == 6 % 3);   // test dividend > divisor 
  TEST(myRem( 3, 6 ) == 3 % 6);   // test dividend < divisor 
  TEST(myRem( 6, 1 ) == 6 % 1);   // test mod one case
  TEST(myRem( 0, 6 ) == 0 % 6);   // test 0 mod with divisor case
  TEST(myRem(-6, 5 ) == -6 % 5);  // test negative dividend case
  TEST(myRem( 6, -5 ) == 6 % -5);  // test negative divisor case 
  TEST(myRem( 2, 2 ) == 2 % 2);   // test dividend == divisor 
  TEST(myRem( -6, -6 ) == -6 % -6); // test negative dividend and divisor 
  TEST(myRem(charA,charSym ) == charA % charSym); // test local variables  

}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testmyRem();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
