use <hook.scad>

$fn=600;// Render 'scale'

// Measurements assumed as mm
LOOP_HEIGHT=67;
LOOP_WIDTH=30; 

HOOK_TYPE="none";
NOBBLE=false;
HOLES=false;
// Size of the hole - radius, in mm.
HOLE_RADIUS=1; // Smallish - guestimate
// How many to have down centre of leg of loop - both legs
// If intending to sew through these, recommend doing two(like button holes.
HOLES_LOOP_LEG_CENTRAL_NUMBER=4;
// How many to have along centre of the top of loop
HOLES_LOOP_TOP_CENTRAL_NUMBER=2;


hanger(
    loop_height=LOOP_HEIGHT, loop_width=LOOP_WIDTH,
    hook_type=HOOK_TYPE,
    holes=HOLES, hole_radius=HOLE_RADIUS, holes_loop_leg_central_number=HOLES_LOOP_LEG_CENTRAL_NUMBER, holes_loop_top_central_number=HOLES_LOOP_TOP_CENTRAL_NUMBER,
    nobble=NOBBLE);
