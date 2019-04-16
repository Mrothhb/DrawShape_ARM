/*
 * Filename: testisDividable.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for isDividable.s
 *
 * int isDividable( int dividend, int divisor );
 *
 * Tests if the dividend is evenly dividable by the divisor Return 1 if the 
 * dividend is evenly dividable by the divisor returns 0 otherwise.
 *
 **/
void testisDividable() {

  char hex1 = 0x62;    // hex for 'b' int is 98
  int valuea = 'a';    // int for 'a'

  TEST(isDividable( 6, 6) == 1); // same value test
  TEST(isDividable( 5, 6) == 0); // smaller dividend but not dividable  
  TEST(isDividable( 6, 5) == 0); //  larger dividend but not dividable
  TEST(isDividable(6, 0) == -1); // divide by zero  
  TEST(isDividable(0,20) == 1);  // zero by number division 
  TEST(isDividable(0,0) == -1);  // zero division 
  TEST(isDividable(-6,6) == 1);  // same operand negative 
  TEST(isDividable(6,-6) == 1);  // same operand negative divisor
  TEST(isDividable(5,-6) == 0);  // smaller dividend negative divisor
  TEST(isDividable(-5,6) == 0);  // smaller dividend negative 
  TEST(isDividable(-6,-6) == 1); // same operand both negative 
  TEST(isDividable(hex1,valuea) == 0); // try to test chars
  

 }


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testisDividable();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
