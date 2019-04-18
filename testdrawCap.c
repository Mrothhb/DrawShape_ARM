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
void testdrawCap() {
  
  drawCap(7,'0',0);
  
}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testdrawCap();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
