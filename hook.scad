$fn=600;// Render 'scale'
// Measurements assumed as mm

// Internal measurement: bottom of 'leg' to top of arch (also called the loop).
LOOP_HEIGHT=67;
// Internal measurement: distance between legs desk is 31
// Add an extra 1mm for clearance.
LOOP_WIDTH=30; 

////
// Hook (the bit used to hang things on) options:
////

// Rounded or square profiled hook
HOOK_TYPE="none";//[rounded,square,none]
// Internal measurement: gap between arch and hook lip. 5 for small hook, 21 for headset
HOOK_DEPTH=21;//[1:40]
// Internal measurement: height of hook lip above semi circle. 
// 2.5 (or a similar size to PLA_WIDTH) recommended for round (or the hook will not have a rounded end). 
// A size similar to HOOK_DEPT recommended for square
HOOK_HEIGHT=2.5;//[0:25]

///
// Print options:
///

// Print height from bed
PRINT_HEIGHT=20;//[1:15]
// Horizontal thickness of 2d shape
PLA_WIDTH=2.8;//[2:5]


///
// Nobble (little bumps on the hook to  clip in) options:
//

// Whether or not to have nobbles - may only work with no_hook
NOBBLE=false;//[true,false]
// Size of the nobble - radius, in mm. There's a bit of offset that's weirder for smaller radius. If bothered, edit the code.
NOBBLE_RADIUS=2;
// Distance of nobble inner edge from top, in mm (maybe add 0.5 for leeway). Make sure the loop_height is long enough to take the size of the nobble. Probably want this distance + 2*nobble_radius <= loop_height
NOBBLE_DISTANCE=20.5;

///
// Hole options: additional holes to insert in body (e.g. for screwing onto things)
// 

// Whether or not to have holes
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
    
module hanger(
    print_height,
    pla_width,
    loop_height, loop_width,
    hook_type, hook_depth, hook_height,
    holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number,
    nobble, nobble_radius, nobble_distance) {
    if (hook_type == "rounded") {
        union(){
            loop(
                print_height,
                pla_width, loop_height, loop_width,
                holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number,
                nobble, nobble_radius, nobble_distance
            );
            // Translate the hook so it's on the right hand edge of the loop. 
            // Note, the edges of the hook are rounded, so need to move up by
            // 1/2 the pla width for the left edge to overlap the loop.
            translate([loop_width + pla_width , pla_width/2])
                roundedhook(print_height, pla_width, hook_depth, hook_height);
        };
    };

    if(hook_type == "square"){
        union(){
            loop(
                print_height,
                pla_width, loop_height, loop_width,
                holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number,
                nobble, nobble_radius, nobble_distance
            );
            // Translate the hook so it's on the right hand edge of the loop. 
            // Note, the left edge of the hook is rounded, so overlap (translated
            // by an extra pla_width).          
            translate([loop_width + pla_width , 0])
                square_hook(print_height, pla_width, hook_depth, hook_height);
    }
    };
    if (hook_type == "none") {
        loop(
            print_height,
            pla_width, loop_height, loop_width,
            holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number,
            nobble, nobble_radius, nobble_distance
        );
    };
}


// Just the 3D hook with a semi-circular profile. Smoother for hanging things off
// 'U'' shaped, with top of left arm of the 'U' flat, and top of right arm rounded off.
// Note, doesn't include the loop/hanger.
// Positioned so that the 'U''s top left edge is at zero, and almost the entire
// shape is in the bottom right quadrant ,
// except the rounded edge on the top of the arms- which stick up by pla_width/2.
module roundedhook(print_height, pla_width, hook_depth, hook_height){
    linear_extrude(height=print_height) {
        union(){
        // Move it across by 1/2 the depth(the radius) so the arc is fully in the right side, rather than being centred on 0,0
        translate([pla_width + hook_depth/2, 0])semi_arc(hook_depth/2, pla_width);
        // Add the rounded end to the left side
        translate([0, -0.5*pla_width])rounded_square(pla_width, pla_width);
        // Add a rounded square to the right side of the semi-arc, of height hook_height, so the hook can be
        // extended up for a 'taller' hook (and rounded edges)
        translate([pla_width + hook_depth, -0.5*pla_width])rounded_square(pla_width, hook_height);
        }
    }
}

// Just the 3D hook with a square profile. Not great for hanging things on really
// Squared off 'L' shape (mirrored), with both ends rounded off.
// Note, doesn't include the loop/hanger.
// Positioned (as you'd expect) so that the bottom left of the mirrored 'L's 
// edge is at zero, and the entire shape is in the upper right quadrant.
module square_hook(print_height, pla_width, hook_depth, hook_height){
    linear_extrude(height=print_height) {
        rounded_square((2*pla_width + hook_depth), pla_width);
        translate([pla_width + hook_depth, 0])
            rounded_square(pla_width, hook_height + pla_width);
        }
}



// The complete 3D upside down "U" shaped part of the hook (the hanger), 
// that slots over
// the divider, with tabs to hold it in place.
module loop(
    print_height,
    pla_width, height, width, 
    holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number,
    nobble, nobble_radius, nobble_distance
){
    difference(){
        linear_extrude(height=print_height) {
            loop_body(
            pla_width, height, width, 
            nobble, nobble_radius, nobble_distance
        );}
      
            loop_subtractions(
                print_height,
                pla_width, height, width,
                holes, hole_radius, hole_loop_leg_central_number, holes_loop_top_central_number
        );
        }

    };
 
 // 2D shape for the loop/hanger, without any subtractions.
 module loop_body(
    pla_width, height, width, 
    nobble, nobble_radius, nobble_distance){
        union(){
        // Main U shape
        // left leg
        rounded_square(pla_width, height+pla_width);
        //top
        translate([0,height])rounded_square((2*pla_width + width), pla_width);
        //right leg
        translate([width+pla_width,0])rounded_square(pla_width, height+pla_width);

        if (nobble) {
            // Tabs to hold in place - aka nobbles
            // Y Distance to translate the nobble.
            // Move the nobble up by the height so centre of semicircle is at the 
            // top of the loop. Then move down by  the radius of the nobble (so the
            // edge is in line with the top rather than the centre of the nobble) 
            // and then move down by the actual amount you want.
            // Note that the distance is an estimate - and won't work for small 
            // radius - the x offset is such that the nobble is in the centre of 
            // the pla width.
            translate_dist_nobble=(height-nobble_radius) - nobble_distance;
            translate([pla_width/2, translate_dist_nobble])
                rotate([0,0,90])semicircle(nobble_radius); 
            translate([width+pla_width+(pla_width/2),translate_dist_nobble])
                rotate([0,0,270])semicircle(nobble_radius);
        }
        }
}

// 3d shapes to be subtracted from the loop. (E.g. holes through the side of the 
// loop legs for screws.). These are solid shapes, ready for a diffrence()
module loop_subtractions(
    print_height,
    pla_width, height, width, 
    holes, hole_radius, holes_loop_leg_central_number, holes_loop_top_central_number,
){
    if (holes) {
        // Tabs to hold in place - aka nobbles
        // Y Distance to translate the nobble.
        // Move the nobble up by the height so centre of semicircle is at the 
        // top of the loop. Then move down by  the radius of the nobble (so the
        // edge is in line with the top rather than the centre of the nobble) 
        // and then move down by the actual amount you want.
        // Note that the distance is an estimate - and won't work for small 
        // radius - the x offset is such that the nobble is in the centre of 
        // the pla width.
        
        // Side holes - double the number of dots, and slect out the odd numbers to get them
        // spaced so that they're not a full gap from the edge.
        y_measurement_side_hole = height/(holes_loop_leg_central_number*2);
        for (side_hole_number = [1: 1: holes_loop_leg_central_number*2]) {
            if (side_hole_number %2 !=0) {
                // Holes for left leg
                translate([0, y_measurement_side_hole*side_hole_number, print_height/2])
                    rotate([0,90,0])
                    cylinder(pla_width*2, hole_radius, center=true);
                
                // Holes for right leg
                translate([pla_width*2 + width, y_measurement_side_hole*side_hole_number, PRINT_HEIGHT/2])
                    rotate([0,90,0])
                    cylinder(pla_width*2, hole_radius, center=true);
                }};
         
        // Top holes - double the number of dots, and slect out the odd numbers to get them
        // spaced so that they're not a full gap from the edge.
        x_measurement_top_hole = width/(holes_loop_top_central_number*2);
         for (top_hole_number = [1: 1: holes_loop_top_central_number*2]) {
            if (top_hole_number %2 !=0) {
                // Holes for top
                translate([pla_width + x_measurement_top_hole*top_hole_number, pla_width +height, PRINT_HEIGHT/2])
                    rotate([90,0,0])
                    cylinder(pla_width*2, hole_radius, center=true);
                }};               
        };
}
    
    
// Produces a 2D rectangle with rounded corners, starting at [0,0]
// Rounding has to be based on the smaller dimension, so we don't draw a 
// square with negative sides
module rounded_square(width, length){
    rounding= width>length ? length*0.2 : width*0.2;
    translate([rounding, rounding])
    minkowski(){
        square([width-(2*rounding), length-(2*rounding)]);
        circle(rounding);
    }
}

// 2D Semicircle. Go figure
module semicircle(radius){
difference(){
    circle(r=radius);
    translate([-radius,0])square(2*radius);
    }
}

// Outline of half a 2D circle  
// Cuts one semi-circle with another, to produce an arc 
module semi_arc(radius, width){
    difference(){
    semicircle(radius+width);
    circle(r=radius);
    }
}
