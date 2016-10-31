// Emmett-Delta 3D Printer 
// Based on Delta-Six Vertex Created by Sage Merrill
// Released on Openbuilds.com
// which was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

//Modified by David Bunch to handle 3/4" Electrical Conduit Pipe for Horizontals

//Modified 2/1/2016 to handle 4x 1/2" Electrical Conduit Pipes Vertically 

$vpt=[-4.8,-22,25.6];
$vpr =[55,0,71.2];
$vpd =435;
height = 40;
ExtendHt = 0;          //Extend height above main part
EMT_OD = 23.7;
EMT12_OD = 18.4;
EMT12_Rad = EMT12_OD / 2;
EMT_Rad = EMT_OD / 2;

Ht_Half = height / 2;
thickness = 5;

triangle_side = 316;
printer_height = 680;
delta_radius = 212.4;
Ht = 8;
M5 = 5.5;
//WireDia = 7;        //use minimum of 6mm for 4 conductor wire to go thru
Wire_Z_Height = 4;
M8 = 8.5;
M3 = 3.5;
PipeScrewDia = 4.5;   //Dia. of holes for Screws that mount EMT Pipe to Vertex
                       //Use 5.15 to 5.5 for M5, or 4.15 to 4.5 for M4

Pipe_Qty = 1;
//Pipe_Spacing = 30+6;     //gives 6mm clearance top & bottom of 86mm high vertex
                       //We Need 45mm to put Pipe Tensioning mount in vertically
Pipe_Spacing = -20;      //Use +20 for pipe at bottom & -20 for pipe even with top
ScrewSockSpace = 15;   //Spacing between t-Slot screw holes in corner
ScrewSockQty = 2;      //Number of t-slot screws on each side

MicroSwitchHole_Zoffset = 12;       //Z Offset for Micro Switch Holes
BaseThk = 10;
$fn=48;
PipeBaseThk=0;
IdlerMnt_X_Offset = 22;             //Idler Mount Bolt offset from center
                                    //Need at leas 20mm for 5mm thick plastic from Center hole
Idler_Move = 5;
Pipe_Z = EMT_Rad + (PipeBaseThk-2);
//Pipe_Z = 28.1;                      //Pipe will be level with top
Pipe_Z = height - 11.9;                       //Pipe will be level with bottom, so we can add corner part at top
UpHt = 6;
TotHt = PipeBaseThk + height + ExtendHt;
echo("TotHt = ", TotHt);
echo("Ht_Half + PipeBaseThk = ",Ht_Half + PipeBaseThk);
EarHt=.5;
EarsOn=0;       //Draw Ears, 1 = Yes, 0 = No

//Makes each segment about .7mm and even number of segments
EMT12OD_Res = (round(((EMT12_OD * 3.14)/4)/.7)*4);       //Resolution of Chamfers
echo("EMT12OD_Res = ",EMT12OD_Res);


module EMT12_4xCut()
{
    translate([-EMT12_Rad,EMT12_Rad,0])
    EMT12_1xPipe();
    translate([-EMT12_Rad,-EMT12_Rad,0])
    EMT12_1xPipe();
    translate([EMT12_Rad,EMT12_Rad,0])
    EMT12_1xPipe();
    translate([EMT12_Rad,-EMT12_Rad,0])
    EMT12_1xPipe();
    translate([-15.4,-15.4,0])
    cube([30.8,30.8,height+2]);
}
module EMT12_1xPipe(E_Ht = height+2)
{
    cylinder(d=EMT12_OD,h=E_Ht,$fn=EMT12OD_Res);
}
module EMT12_Pipes()
{
    translate([0,0,height - BaseThk])
    rotate([180,0,0])
    {
    translate([-EMT12_Rad,EMT12_Rad,0])
    EMT12_1xPipe(100);
    translate([-EMT12_Rad,-EMT12_Rad,0])
    EMT12_1xPipe(100);
    translate([EMT12_Rad,EMT12_Rad,0])
    EMT12_1xPipe(100);
    translate([EMT12_Rad,-EMT12_Rad,0])
    EMT12_1xPipe(100);
    }
}
//EMT12_Pipes();
module VertexTop_Outline()
{

	linear_extrude(height = height, center = false, convexity = 10)
	import("EMTH_EMTV_VertexTop.dxf", layer = "Outline");
}
module VertexTop_UpperFrameCut()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("EMTH_EMTV_VertexTop.dxf", layer = "UpperFrameCut");
}
module VertexTop_EMT12_FullCut()
{
    translate([0,0,0])
    EMT12_4xCut();
}

module VertexTop_EMT12_HalfCut()
{
    difference()
    {
        EMT12_4xCut();
        translate([-19.4,-5,-2])
        cube([38.8,10,height+4]);
        %EMT12_Pipes();
    }
}
module VertexTop_CornerCuts()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("EMTH_EMTV_VertexTop.dxf", layer = "CornerCuts");
}
module EMT_Nut()
{
    translate([1,-23.4,height-BaseThk])
    difference()
    {
//If Nut lock is not flush with outside pipe, try adjusting Pipe_Rad-1.3
        rotate([90,0,0])
        rotate([0,90,0])
        rotate([0,0,180])
        difference()
        {
            linear_extrude(height = 5, center = false, convexity = 10)polygon(points = 
            [[-0.5,0],[-0.5,26.43],[0,26.43],[1.5,24.93],[6.27,24.93],
            [6.87,24.83],[7.42,24.55],[7.86,24.12],[8.13,23.57],[8.23,22.97],
            [8.23,9.06],[8.19,8.67],[8.08,8.29],[7.89,7.94],[7.64,7.64],
            [0,0]]);
//            [[0,31.6],[7.64,23.96],[7.89,23.66],[8.08,23.31],[8.19,22.93],
//            [8.23,22.54],[8.23,9.06],[8.19,8.67],[8.08,8.29],[7.89,7.94],
//            [7.64,7.64],[0,0],[-0.5,0],[-0.5,31.6]]);
            translate([4.1,10.8,-1])
            cylinder(d=M3,h=8,$fn=24);
            translate([4.1,20.8,-1])
            cylinder(d=M3,h=8,$fn=24);
        }
    }
}
module EMT_NutsSide()
{
    EMT_Nut();
    translate([-7,0,0])
    EMT_Nut();
}
module Ears()
{
    linear_extrude(height = EarHt, center = false, convexity = 10)
	import("EMTH_EMTV_VertexTop.dxf", layer = "Ears");
}
module vertex()
{
		difference()
        {
            color("Blue")
            union()
            {
                translate([0,0,PipeBaseThk])
                VertexTop_Outline();
                EMT_NutsSide();
//                translate([0,0,18.4])
//                EMT_NutsSide();
            }

            Pipes();

            PipeScrewsBothSides();

            color("magenta")
            IdlerBoltHole();            //Hole for Idler bolt to extend
////Upper A Frame Hole (Large)
            translate([0,0,-1])
            VertexTop_UpperFrameCut();
//  // Angled Wire Runs on each side of Idler 
//
            WireRuns();
            WireTopEMT12();

            translate([0,0,-1])
            VertexTop_EMT12_HalfCut();

            translate([0,0,height-BaseThk])
            rotate([0,180,0])
            VertexTop_EMT12_FullCut();
// Corner Screw Sockets
            //CornerScrewSockets();

            IdlerCut();

            translate([0,-14+8.4,0])
            IdlerMntAdjustHoles();                  //Adjustment Slot holes for Idler Mount Plate
            translate([0,0,-1])
            VertexTop_CornerCuts();
//Cut 2mm slot for Pipe Tighten
            translate([-1,-30,-BaseThk])
            cube([2,18,height]);
//            translate([-1,-30,-1])
//            cube([2,18,height+2]);           //Uncomment if you want slit full height
		}
}
module MidTSlot_Open()
{
    linear_extrude(height = height + 20+ ExtendHt, center = false, convexity = 10)polygon(points = 
    [[-6.5,6.15],[-3.25,2.9],[3.25,2.9],[6.5,6.15],[6.5,9.2],
    [-6.5,9.2]]);
}

module IdlerBoltHole()
{
    translate([0,8.4,15])
    rotate([-90,0,0])
    {
        translate([0,-4,0])
        cylinder(d=10,h=20,$fn=36);
        translate([-5,-4,0])
        cube([10,8,20]);
        translate([0,4,0])
        cylinder(d=10,h=20,$fn=36);
    }
}
module IdlerCut()
{
    translate([0,34+8.4,18])
    rotate([-90,0,0])
    {
        color("cyan")
        cylinder(d=24,h=10,$fn=76);
        translate([-12,0,0])
        cube([24,20,10]);
    }
    RndCorner();
    mirror([1,0,0])
    RndCorner();
}
module RndCorner()
{
    translate([-4,34+8.4,22])
    rotate([-90,0,0])
    translate([-14,16,0])
    difference()
    {
        cylinder(d=18,h=10,$fn=24);
        translate([0,0,-1])
        cylinder(d=12,h=12,$fn=48);
        translate([-10,-20,-1])
        cube([20,20,12]);
        translate([-20,-10,-1])
        cube([20,20,12]);
    }
}
module IdlerMntAdjustHoles()
{ 
    translate([IdlerMnt_X_Offset,0,12])
    IdlerMntAdjustSlot();

    translate([-IdlerMnt_X_Offset,0,12])
    IdlerMntAdjustSlot();
}

module IdlerMntAdjustSlot()
{
    translate([0,58,3.5])
    rotate([90,0,0])
    union()
    {
        translate([0,Idler_Move,0])
        cylinder(d=5.5,h=10,$fn=24);
        translate([-2.75,-Idler_Move,0])
        cube([5.5,Idler_Move*2,10]);
        translate([0,-Idler_Move,0])
        cylinder(d=5.5,h=10,$fn=24);
    }
}

module WireTopEMT12()
{
    translate([-9.2,20.9,height])
    BotWireCut();
    translate([9.2,20.9,height])
    BotWireCut();

}
//We use 7mm for Diameter of Wire cut
module BotWireCut()
{
    rotate([-90,0,0])
    translate([0,0,-5.5])
    linear_extrude(height = 11, center = false, convexity = 10)polygon(points = 
    [[-3.5,3.5],[-3.5,1.5],[-5,0],[-5,-1],[5,-1],
    [5,0],[3.5,1.5],[3.5,3.5],[3.43,4.18],[3.23,4.84],
    [2.91,5.44],[2.47,5.97],[1.94,6.41],[1.34,6.73],[0.68,6.93],
    [0,7],[-0.68,6.93],[-1.34,6.73],[-1.94,6.41],[-2.47,5.97],
    [-2.91,5.44],[-3.23,4.84],[-3.43,4.18]]);
}
module WireRuns()
{
    color("red")
    translate([0,8.4,height -(2.8+6)])      //5mm puts hole just touching bottom
    {
        translate([-34,48,0])
        rotate([90,0,0])
        cylinder(d=5.5,h=14);
        translate([34,48,0])
        rotate([90,0,0])
        cylinder(d=5.5,h=14);
    }
}
module Pipe1x()
{
    translate([-46.3082,9.0793+8.4,0])
    rotate([0,0,30])
    rotate([-90,0,0])
    cylinder(d=EMT_OD,h=300,$fn=64);            //Cut Left Side opening for EMT pipe

    translate([46.3082,9.0793+8.4,0])
    rotate([0,0,-30])
    rotate([-90,0,0])
    cylinder(d=EMT_OD,h=300,$fn=64);            //Cut Right Side opening for EMT pipe
}
module Pipes()
{
    translate([0,0,Pipe_Z])
    {
        if (Pipe_Qty == 2)
        {
            Pipe1x();
            translate([0,0,Pipe_Spacing])
            Pipe1x();
        } else {
            Pipe1x();
            %Pipe1x();
        }
    }
}
module PipeScrewsBothSides()
{
    if (PipeBaseThk > 0)
    {
        PipeScrews();
        mirror([1,0,0])
        PipeScrews();
    } else {
        PipeScrews();
        mirror([1,0,0])
        PipeScrews();
    }
}
module PipeScrews()
{
    translate([0,0,Pipe_Z])
    {
        if (Pipe_Qty == 2)
        {
            PipeScrews1x();
            translate([0,0,Pipe_Spacing])
            PipeScrews1x();
        } else {
            PipeScrews1x();
            translate([0,0,Pipe_Spacing])
            PipeScrews1x();
        }
    }
}
module PipeScrews1x()
{
    translate([-62.2014,18.7073,0])
    rotate([0,0,30])
    rotate([0,90,0])
    cylinder(d=PipeScrewDia,h=32);

    translate([-80.7035,50.7538,0])
    rotate([0,0,30])
    rotate([0,90,0])
    cylinder(d=PipeScrewDia,h=32);
}
module OutScrewDriverHole()
{
    translate([0,0,-1])
    cylinder(d=M3,h=40);         //Screwdriver Access Hole
}

module CornerScrewSockets()
{
    translate([0,0,Ht_Half-10])
    {
        translate([0,-16,ScrewSockSpace])
        rotate([90, 0, 180])                    //Add a Hole in Center Top
        cylinder(d=M5,h=10,$fn=32);             //for connecting Tetrahedron top at corners
        for (z =[0:ScrewSockQty-1])
        {
            for (x = [-1,1])
            {
                translate([20*x,-16,z*ScrewSockSpace])
                rotate([90, 0, 180])
                color("red")
                cylinder(d=M5,h=40,$fn=32);         //Drill thru both sides of plastic
            }
        }
    }
}
module TimingBelt()
{
    color("black")
    import("TimingBelt_100mm.stl", convexity=3);
}
module LimitSwitch()
{
    color("red")
    import("LimitSwitch.stl", convexity=3);
}
module Idler_Cap()
{
    translate([0,0,15])
    import("Idler_2holeMount_44mmHoleSpacingAssembly_rev8_repaired.stl", convexity=3);
}
module Carriage()
{
    color("Orange")
    import("carriage_20x60_Rev20_repaired.stl", convexity=3);
}
module CarriageBack()
{
    rotate([0,0,180])
    color("Orange")
    import("BackPlate_20x60_Rev20_repaired.stl", convexity=3);
}
module LimitHolder()
{
    //rotate([0,0,180])
    color("Orange")
    import("Delta_EMT_LimitSwitchHolder_120deg_1x_rev2_repaired.stl", convexity=3);
}
module DrawFinal()
{
    translate([0,0,height])
    rotate([180,0,0])
    vertex();
}
if (EarsOn == 0)
{
    DrawFinal();
} else if (EarsOn == 1)
{
    DrawFinal();
    rotate([0,0,180])
    Ears();
}