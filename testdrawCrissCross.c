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
void testdrawCrissCross() {
  
  drawCrissCross(7,'a');
  
}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testdrawCrissCross();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
