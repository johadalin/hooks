use <hook.scad>

$fn=60;// Render 'scale'
// Measurements assumed as mm

// Internal measurement: bottom of 'leg' to top of arch (also called the loop).
LOOP_HEIGHT=30;
// Internal measurement: distance between legs desk is 31
// Add an extra 1mm for clearance.
LOOP_WIDTH=16; 

////
// Hook (the bit used to hang things on) options:
////

// Rounded or square profiled hook
HOOK_TYPE="rounded";//[rounded,square,none]
HOOK_DEPTH=10;
HOOK_HEIGHT=5;
// Print height from bed
PRINT_HEIGHT=5;//[1:15]
// Horizontal thickness of 2d shape
PLA_WIDTH=2.8;//[2:5]

// Whether or not to have nobbles - may only work with no_hook
NOBBLE=false;//[true,false]

///
// Hole options: additional holes to insert in body (e.g. for screwing onto things)
// 

// Whether or not to have holes
HOLES=false;//[true,false]


hanger(
    PRINT_HEIGHT,
    PLA_WIDTH,
    LOOP_HEIGHT, LOOP_WIDTH,
    HOOK_TYPE, HOOK_DEPTH, HOOK_HEIGHT,
    HOLES, HOLE_RADIUS, HOLES_LOOP_LEG_CENTRAL_NUMBER, HOLES_LOOP_TOP_CENTRAL_NUMBER,
    NOBBLE, NOBBLE_RADIUS, NOBBLE_DISTANCE);
