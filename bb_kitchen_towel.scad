use <hook.scad>

$fn=60;// Render 'scale'
// Measurements assumed as mm

// Internal measurement: bottom of 'leg' to top of arch (also called the loop).
LOOP_HEIGHT=30; // Guestimate 30mm as nice
// Internal measurement: distance between legs desk is 31
// Add an extra 1mm for clearance.
LOOP_WIDTH=16; // 15mm measured for top of cupboard width.

////
// Hook (the bit used to hang things on) options:
////

// Rounded or square profiled hook
HOOK_TYPE="rounded";//[rounded,square,none]
HOOK_DEPTH=10; // Guestimate
HOOK_HEIGHT=5; // Guestimate

// Print height from bed
PRINT_HEIGHT=5;//Guestimate
// Horizontal thickness of 2d shape
PLA_WIDTH=2.8;//[2:5]

// Whether or not to have nobbles - may only work with no_hook
NOBBLE=false;//[true,false]

// Whether or not to have holes
HOLES=false;//[true,false]


hanger(
    print_height=PRINT_HEIGHT,
    pla_width=PLA_WIDTH,
    loop_height=LOOP_HEIGHT, loop_width=LOOP_WIDTH,
    hook_type=HOOK_TYPE, hook_depth=HOOK_DEPTH, hook_height=HOOK_HEIGHT,
    holes=HOLES, 
    nobble=NOBBLE);
