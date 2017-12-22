#include <stdio.h>

// bumping track, best at 11K
#define BEAT1 (t | (t>>9|t>>7)) * t & (t>>11|t>>9)

// mysterious techno, best at 22K
#define BEAT2 (t&t>>12)*(t>>4|t>>8)

// simplicity
#define BEAT3 t&t>>8

// the 42 melody, best at 11K
#define BEAT4 t*(42&t>>10)

// more mysterious techno, best at 22K
#define BEAT5 (t&t>>12)*(t>>4|t>>8)^t>>6

// mr arppegiator
#define BEAT6 (t/8)>>(t>>9)*t/((t>>14&3)+4)

int main(int t) {
    for(;;t++)
        putchar(
               BEAT2
               );
}
