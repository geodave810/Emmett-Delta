//Jig to drill 2 holes in Horizontal EMT or PVC Pipe 
//Revised 11/4/2016 for 1/2" EMT, 3/4" EMT & 1/2" PVC By: David Bunch 10/17/2016
//
//For tensioning screw, I will use an M3x18mm screw
//I use arrays to determine which pipe style to create based on ET index number
//1/2" EMT Jig printed vertical took 2:2657 & weighs .9oz
//1/2" EMT Jig printed horizontal took 1:30:23 & weighs .64oz
//if you want to save time & plastic print them horizontal
//
ET = 0;                                     //0 = 1/2" EMT, 1 = 3/4" EMt, 2 = 1/2" PVC
A_Drill_Offset = [9.25,9,9.25];             //Starting Offset of Drill Hole
A_Drill_Spacing = [42,37,42];               //Spacing between Drill Holes
A_NutMnt_Y_Offset = [11,15,13.5];           //Offset location distance for Tensioning Block
A_PIPE_OD = [18.4,23.7,21.8];               //Diameter of Pipes
A_Jig_Offset = [13.2,15.85,14.9];           //Offset to relocate Jig to Zero Z Height

Drill_Offset = A_Drill_Offset[ET];
Drill_Spacing = A_Drill_Spacing[ET];
NutMnt_Y_Offset = A_NutMnt_Y_Offset[ET];
PIPE_OD = A_PIPE_OD[ET];
Jig_Offset = A_Jig_Offset[ET];

Ht = (Drill_Offset * 2) + Drill_Spacing;        //Height of Drill jig
Ht2 = Ht / 2;

M3 = 3.4;                       //Holding Tensioning Bolt Diameter hole
M3Nut_OD = 6.4;
M3Head_OD = 5.5;
Hole_OD = 5.15;                 //Drill Hole Diameter
M3_Res = 16;                    //Resolution of Tensioning Bolt Hole
Hole_OD_Res = 24;               //Drill Hole Resolution

Pipe_Res = (round(((PIPE_OD * 3.14)/4)/.7)*4);;

echo(Drill_Offset = Drill_Offset);
echo(Drill_Spacing = Drill_Spacing);
echo(NutMnt_Y_Offset = NutMnt_Y_Offset);
echo(PIPE_OD = PIPE_OD);
echo(Ht = Ht);
echo(Pipe_Res = Pipe_Res);

$fn=24;
module DrHole()
{
    rotate([0,90,0])
    cylinder(d = Hole_OD ,h = PIPE_OD+14, center = true, $fn = Hole_OD_Res);
}
module DrillJig_EMT12()
{
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[5.47,13.2],[-5.47,13.2],[-15.2,3.47],[-15.2,-3.47],[-5.47,-13.2],
    [5.47,-13.2],[13.2,-5.47],[13.2,5.47]]);
}
module DrillJig_EMT34()
{
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[-6.57,-15.85],[6.57,-15.85],[15.85,-6.57],[15.85,6.57],[6.57,15.85],
    [-6.57,15.85],[-17.85,4.57],[-17.85,-4.57]]);
}
module DrillJig_PVC12()
{
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[-16.9,-4.17],[-6.17,-14.9],[6.17,-14.9],[14.9,-6.17],[14.9,6.17],
    [6.17,14.9],[-6.17,14.9],[-16.9,4.17]]);
}
module DrillJig()
{
    if (ET == 0){ DrillJig_EMT12();}
    if (ET == 1){ DrillJig_EMT34();}
    if (ET == 2){ DrillJig_PVC12();}
}
module Pipe_Nut()
{
    translate([-1,NutMnt_Y_Offset,Ht2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    difference()
    {
        linear_extrude(height = 6, center = false, convexity = 10)polygon(points = 
        [[8.23,-1.74],[8.23,1.74],[8.19,2.13],[8.08,2.51],[7.89,2.86],
        [7.64,3.16],[0,10.8],[-0.86,10.8],[-0.86,-10.8],[0,-10.8],
        [7.64,-3.16],[7.89,-2.86],[8.08,-2.51],[8.19,-2.13]]);
        translate([4.1,0,-1])
        cylinder(d=M3,h=8,$fn=M3_Res);
    }
}

module M3_Nut()
{
    color("red",.5)
    translate([-1,NutMnt_Y_Offset,Ht2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    translate([4.1,0,6])
    difference()
    {
        rotate([0,0,30])
        cylinder(d=M3Nut_OD,h=4,$fn=6);
        translate([0,0,-1])
        cylinder(d=M3,h=6,$fn=M3_Res);
    }
}
module Pipe_NutsSide()
{
    Pipe_Nut();
    translate([8,0,0])
    Pipe_Nut();
    %M3_Nut();
    color("red",.5)
    translate([16.5,NutMnt_Y_Offset,Ht2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    translate([4.1,0,6])
    %cylinder(d=M3Head_OD,h=3.5,$fn=24);
}
module PipeSlot()
{
    translate([-1,-1,-1])
    cube([2,PIPE_OD,Ht+20]);
}
module Pipe()
{
    translate([0,0,-1])
    cylinder(d=PIPE_OD,h=Ht + 2,$fn=Pipe_Res);
}
module PipeTaper()
{
    translate([0,0,-.01])
    cylinder(d1=PIPE_OD+4,d2=PIPE_OD,h=2.01,$fn=Pipe_Res);     //Chamfer bottom opening
    translate([0,0,Ht-2])
    cylinder(d1=PIPE_OD,d2=PIPE_OD+2,h=2.01,$fn=Pipe_Res);     //Chamfer Top Pipe opening
}
module DrawFinal()
{
    difference()
    {
        union()
        {
            DrillJig();         //Main part for the Drill Jig
            Pipe_NutsSide();    //Add the tightening screw plate to hole pipe in jig
        }
        Pipe();                 //Cut the Pipe opening
        PipeTaper();            //Taper Pipe opening

        PipeSlot();             //Cut 2mm Pipe tensioning Slot
        translate([0,0,Drill_Offset])
        DrHole();               //1st drill jig hole for drilling thru pipe
        translate([0,0,Drill_Offset + Drill_Spacing])
        DrHole();               //2nd drill jig hole for drilling thru pipe
    }
}
rotate([0,0,90])                //Rotate along X-Axis
translate([0,Ht2,Jig_Offset])   //Move up to build plate
rotate([90,0,0])                //Rotate part to print on its side
DrawFinal();