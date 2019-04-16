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
  
  // local variables to test as parameters
  int testA = 'A';
  char testPound = '#';
  int testHexBracket = 0x5B;
  char str[] = "test\0";

  outputChar('a');            // single test case for one character
  outputChar('0');            // test zero case
  outputChar('\n');           // test newline 
  outputChar(str);            // string test
  outputChar('#');            // test symbols
  outputChar(' ');            // test empty 
  outputChar("");             // test empty string
  outputChar(0x22);           // test hex value 
  outputChar(testA);          // test int local variable holding hex char
  outputChar(testPound);      // test pound char as a char local var 
  outputChar(testHexBracket); // test hex format of bracket stored in int var

 }

int main( void ) {

  fprintf( stderr, "Running tests for testOutputChar...\n" );
  testoutputChar();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
