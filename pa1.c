/*
 * Filename: pa1.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: TODO, 2019
 * Sources of Help: Lecture notes, cse 30 website, texbook. 
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include "pa1.h"
#include "pa1Strings.h"

// TODO function header
int main( int argc, char * argv[] ) {
  char *endPtr;         // Used as a second param of strtol
  char errStr[BUFSIZ];  // Used to build up error string in snprintf
  long result;          // Number used to hold return value from strtol
  char  fillChar;       // the fill character to extract from arg 

  // check that the user entered a valid number of command line arguments.
  if ( argc != ARG_NUM ) {

    // Print the COOL_S_USAGE to stderr and return EXIT_FAILURE right away.
    fprintf( stderr, COOL_S_USAGE, argv[0], MIN_SIZE, MAX_SIZE, MIN_CHAR, 
          MAX_CHAR );
    return EXIT_FAILURE;
  }
  
  // Size: set the global variable errno to 0
  errno = 0;

  // Call strtol() to convert the Cool S size to an int 
  result = strtol( argv[SIZE_IDX] , &endPtr, BASE );

  // Error converting to int 
  if( errno ) {
    snprintf( errStr , BUFSIZ, SIZE_CONVERT_ERR, result, BASE );
    perror( errStr );
    fprintf( stderr,"\n");
    return EXIT_FAILURE;
  }

  // The size contains non-numerical characters
  if( *endPtr != '\0' ) {
    fprintf( stderr, SIZE_NOT_INT_ERR, BASE );
    return EXIT_FAILURE;
  }

  // Size is not in bounds
  if( !intervalContains( MIN_SIZE, MAX_SIZE, result) ) {
    fprintf( stderr, SIZE_RANGE_ERR, MIN_SIZE, MAX_SIZE );
    return EXIT_FAILURE;
  }

  // Size is not in the format of 4n + 3
  if( ! isDividable( (result-SIZE_OFFSET), SIZE_MULTIPLE ) ) { 
    fprintf( stderr, SIZE_FORMAT_ERR );
    return EXIT_FAILURE;
  }
  
  // extract the first character from the argument 
  fillChar = argv[CHAR_IDX];

  // If its not a single character 
  if( strlen( argv[CHAR_IDX] ) != 1 ) {
    fprintf( stderr, SINGLE_CHAR_ERR );
    return EXIT_FAILURE;
  }
  
  // argument 2 character is not within bounds
  if( !intervalContains( MIN_CHAR, MAX_CHAR, fillChar )) {
    fprintf( stderr, CHAR_RANGE_ERR, MIN_CHAR, MAX_CHAR );
    return EXIT_FAILURE;
  }
 
  return EXIT_SUCCESS;
}
