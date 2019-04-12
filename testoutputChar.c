/*
 * Filename: testoutputChar.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for outputChar.s
 *
 * void outputChar( char ch );
 *
 * Prints the parameter character to stdout.
 *
 **/
void testoutputChar() {

  outputChar('a');  //single test case for one character
  outputChar('0');  //test zero case
  outputChar('\n'); //test newline 
  outputChar("aa"); //string test
  outputChar('#');  //test symbols
  outputChar(' '); //test empty 
  outputChar("");  //test empty string
  outputChar('\0');  //test null char
  
  /*
   * TODO: YOU MUST WRITE MORE TEST CASES FOR FULL POINTS!
   *
   * Some things to think about are error cases, extreme cases, normal cases,
   * abnormal cases, etc.
   */
}


int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testoutputChar();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
