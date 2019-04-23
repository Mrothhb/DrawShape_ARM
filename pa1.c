/*
 * Filename: pa1.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: April 24, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include  <string.h>
#include "pa1.h"
#include "pa1Strings.h"

/*
 * Function name: main()
 * Function Prototype: int main( int argc, char * argv[] );
 * Description: he main function will drive the rest of the program. It will
 * first perform input checking by parsing the command-line arguments and 
 * checking for errors. If all inputs are valid, it will call drawCoolS(). 
 * Otherwise, it will print the corresponding error message and return right 
 * away. 
 * Parameters: argc - the argument count. 
 *             argv[] - the arguments used as input to drive the program. 
 * Side Effects: Prints out the Cool S to stdout or error messages to stderr.
 * Error Conditions: Error converting arg1 to int, error arg1 contains non-
 * numerical characters, arg1 size is not in bounds, arg1 size is not in the 
 * format 4n+3, arg2 is not a single character, arg2 is not within bounds.
 * Return Value: SUCCESS or FAILURE.
 */
int main( int argc, char * argv[] ) {
  char *endPtr;          // Used as a second param of strtol
  char errStr[BUFSIZ];   // Used to build up error string in snprintf
  long result;           // Number used to hold return value from strtol
  char fillChar;         // the fill character to extract from arg 

  // check that the user entered a valid number of command line arguments.
  if ( argc != ARG_NUM ) {
    // Print the COOL_S_USAGE to stderr and return EXIT_FAILURE right away.
    fprintf( stderr, COOL_S_USAGE, argv[0], MIN_SIZE, MAX_SIZE, MIN_CHAR, 
          MAX_CHAR );
    return EXIT_FAILURE;
  }
  
  // Set the global variable errno to 0
  errno = 0;

  // Convert the string argument 2 to an int value 
  result = strtol( argv[SIZE_IDX] , &endPtr, BASE );

  // If an error occured converting to int print to stderr and return 
  if( errno ) {
    snprintf( errStr , BUFSIZ, SIZE_CONVERT_ERR, argv[SIZE_IDX], BASE );
    perror( errStr );
    fprintf( stderr, "%c", NEWLINE_CHAR);
    return EXIT_FAILURE;
  }

  // The size contains non-numerical characters print to stderr and return 
  if( *endPtr != NULL_CHAR ) {
    fprintf( stderr, SIZE_NOT_INT_ERR, BASE );
    return EXIT_FAILURE;
  }

  // The size is not in bounds print to stderr and return
  if( !intervalContains( MIN_SIZE, MAX_SIZE, result) ) {
    fprintf( stderr, SIZE_RANGE_ERR, MIN_SIZE, MAX_SIZE );
    return EXIT_FAILURE;
  }

  // Size is not in the format of 4n + 3 print to stderr anr return 
  if( ! isDividable( (result-SIZE_OFFSET), SIZE_MULTIPLE ) ) { 
    fprintf( stderr, SIZE_FORMAT_ERR );
    return EXIT_FAILURE;
  }
  
  // If argument 3 is not a single character print to stderr and return  
  if( strlen( argv[CHAR_IDX] ) != 1 ) {
    fprintf( stderr, SINGLE_CHAR_ERR );
    return EXIT_FAILURE;
  }

  // Extract the first character from argument 3 
  fillChar = *argv[CHAR_IDX];

  // Argument 3 character is not within bounds
  if( !intervalContains( MIN_CHAR, MAX_CHAR, fillChar )) {
    fprintf( stderr, CHAR_RANGE_ERR, MIN_CHAR, MAX_CHAR );
    return EXIT_FAILURE;
  }
  
  // If all error cases pass then print the Cool S to stdout and return SUCCESS
  drawCoolS( result, fillChar );
 
  return EXIT_SUCCESS;
}
