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
  
  int i;
  int j = BUFSIZ;
  int charA = 'a';         // local variable char character a
  char charSym = 0x7E;    // local variable char hex value 
  int i_mod_j;

  TEST(myRem( 6, 3 ) == 6 % 3);   // test dividend > divisor 
  TEST(myRem( 3, 6 ) == 3 % 6);   // test dividend < divisor 
  TEST(myRem( 6, 1 ) == 6 % 1);   // test mod one case
  TEST(myRem( 0, 6 ) == 0 % 6);   // test 0 mod with divisor case
  TEST(myRem(-6, 5 ) == -6 % 5);  // test negative dividend case
  TEST(myRem( 6, -5 ) == 6 % -5);  // test negative divisor case 
  TEST(myRem( 2, 2 ) == 2 % 2);   // test dividend == divisor 
  TEST(myRem( -6, -6 ) == -6 % -6); // test negative dividend and divisor 
  TEST(myRem(charA,charSym ) == charA % charSym); // test local variables
  
  // load test 
  for ( i = 0; i < BUFSIZ; i++){
    i_mod_j = i%j;
    TEST(myRem( i, j ) == (i % j));
    printf(" i = %d \n j = %d \n i mod j = %d \n", i, j, i_mod_j);
    j--;
    }

}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testmyRem();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
