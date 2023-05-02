use <hook.scad>

$fn=600;// Render 'scale'

// Measurements assumed as mm
LOOP_HEIGHT=67;
LOOP_WIDTH=30; 
HOOK_TYPE="none";//[rounded,square,none]
NOBBLE=false;//[true,false]

HOLES=true;//[true,false]
// Size of the hole - radius, in mm.
HOLE_RADIUS=1;
// How many to have down centre of leg of loop - both legs
// If intending to sew through these, recommend doing two(like button holes.
HOLES_LOOP_LEG_CENTRAL_NUMBER=4;
// How many to have along centre of the top of loop
HOLES_LOOP_TOP_CENTRAL_NUMBER=2;


hanger(
    PRINT_HEIGHT,
    PLA_WIDTH,
    LOOP_HEIGHT, LOOP_WIDTH,
    HOOK_TYPE, HOOK_DEPTH, HOOK_HEIGHT,
    HOLES, HOLE_RADIUS, HOLES_LOOP_LEG_CENTRAL_NUMBER, HOLES_LOOP_TOP_CENTRAL_NUMBER,
    NOBBLE, NOBBLE_RADIUS, NOBBLE_DISTANCE);
