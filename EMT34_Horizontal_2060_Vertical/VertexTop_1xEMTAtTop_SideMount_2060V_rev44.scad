// Emmett-Delta 3D Printer 
// Base on Delta-Six Vertex Created by Sage Merrill
// Released on Openbuilds.com
// which was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

//Modified by David Bunch to handle 3/4" Electrical Conduit Pipe for Horizontals

//$vpt=[6.56,16.38,-10.5];
//$vpr =[56.4,0,233.1];
//$vpd =285.35;
//3.8oz at 50% infill & print time of 7:43:56
height = 40;
ExtendHt = 0;          //Extend height above main part
EMT_OD=23.7;
EMT_Rad = EMT_OD / 2;

Ht_Half = height / 2;
thickness = 5;

triangle_side = 316;
printer_height = 680;
delta_radius = 212.4;
Ht = 8;
M5 = 5.5;
WireDia = 7;        //use minimum of 6mm for 4 conductor wire to go thru
Wire_Z_Height = 4;
M8 = 8.5;
M3 = 3.4;
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

//1= Yes, 0 = No
Assembly = 0;           //(This will not print correctly in Assembly orientation)
module VertexTop_Outline()
{
	linear_extrude(height = height, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "Outline");
}
module VertexTop_UpperFrameCut()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "UpperFrameCut");
}
module VertexTop_Alum2060FullCut()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "Alum2060FullCut");
}
module VertexTop_Alum2060HalfCut()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "Alum2060HalfCut");
}
module V2060()
{
    V_Ht = 200;
    color("Silver",.5)
    translate([0,0,-V_Ht+TotHt-BaseThk])
	linear_extrude(height = V_Ht, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "Alum2060");
}
//module VertexTop_Alum2060()
//{
//    //translate([-20,0,0])
////This was traced from the V-Slot 20x60 & taking out the small details
//
//	linear_extrude(height = 200, center = false, convexity = 10)
//	import("VertexTop_2060_44.dxf", layer = "Alum2060");
//}
module VertexTop_CornerCuts()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("VertexTop_2060_44.dxf", layer = "CornerCuts");
}
module Ears()
{
    translate([63,63,0])
    cylinder(d=20,h=EarHt);
    translate([-63,63,0])
    cylinder(d=20,h=EarHt);
    hull()
    {
        translate([51.3,-14.5,0])
        cylinder(d=16,h=EarHt);
        translate([58.8,-1.5,0])
        cylinder(d=16,h=EarHt);
    }
    hull()
    {
        translate([-51.3,-14.5,0])
        cylinder(d=16,h=EarHt);
        translate([-58.8,-1.5,0])
        cylinder(d=16,h=EarHt);
    }
}
module vertex()
{
		difference()
        {
            color("Blue")
            translate([0,0,PipeBaseThk])
            VertexTop_Outline();

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
            WireTop2060();

            translate([0,0,-1])
            VertexTop_Alum2060HalfCut();
//    translate([0,0,-1])             //These cut out too much plastic with Wireholes at top
//    MidTSlot_Open();                //Give access to insert tnuts after vertex in place
//    translate([-20,0,-1])
//    MidTSlot_Open();                //Give access to insert tnuts after vertex in place
//    translate([20,0,-1])
//    MidTSlot_Open();                //Give access to insert tnuts after vertex in place
            translate([0,0,height-BaseThk])
            rotate([0,180,0])
            VertexTop_Alum2060FullCut();
// Corner Screw Sockets
            CornerScrewSockets();

            IdlerCut();

            translate([0,-14,0])
            IdlerMntAdjustHoles();                  //Adjustment Slot holes for Idler Mount Plate
            translate([0,0,-1])
            VertexTop_CornerCuts();
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
    translate([0,0,15])
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
    translate([0,34,18])
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
    translate([-4,34,22])
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
module WireTop2060()
{
    translate([10,0,height-Wire_Z_Height])
    rotate([-90,0,0])
    BotWireRoute();
    
    translate([-10,0,height-Wire_Z_Height])
    rotate([-90,0,0])
    BotWireRoute();  
}
//Use minimum of 6mm for wire to go thru
module BotWireRoute()
{
    translate([0,-1,-1])
    cylinder(d=WireDia,h=24,$fn=32);
    hull()
    {
        translate([0,-1,-1])
        cylinder(d1=WireDia+4,d2=WireDia,h=4,$fn=32);
        translate([0,-7,-1])
        cylinder(d1=WireDia+4,d2=WireDia,h=4,$fn=32);
    }
    hull()
    {
        translate([0,-1,12])
        cylinder(d1=WireDia,d2=WireDia+4,h=4,$fn=32);
        translate([0,-7,12])
        rotate([0,0,0])
        cylinder(d1=WireDia,d2=WireDia+4,h=4,$fn=32);
    }
    translate([-(WireDia/2),-WireDia-1,-1])
    cube([WireDia,WireDia,24]);
}
module WireRuns()
{
    color("red")
    translate([0,0,height -(2.8+6)])      //5mm puts hole just touching bottom
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
    translate([-46.3082,9.0793,0])
    rotate([0,0,30])
    rotate([-90,0,0])
    cylinder(d=EMT_OD,h=300,$fn=64);            //Cut Left Side opening for EMT pipe

    translate([46.3082,9.0793,0])
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
    translate([-62.8077,9.9572,0])
    rotate([0,0,30])
    rotate([0,90,0])
    cylinder(d=PipeScrewDia,h=32);

    translate([-81.3098,42.0038,0])
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
    translate([0,0,0])
    import("Idler_2holeMount_44mmHoleSpacingAssembly_rev8.stl", convexity=3);
}
module Carriage()
{
    color("Orange")
    import("carriage_20x60_Rev20.stl", convexity=3);
}
module CarriageBack()
{
    rotate([0,0,180])
    color("Orange")
    import("BackPlate_20x60_Rev20.stl", convexity=3);
}
module LimitHolder()
{
    //rotate([0,0,180])
    color("Yellow")
    import("Delta_EMT_LimitSwitchHolder_120deg_1x_rev2.stl", convexity=3);
}
module DrawFinal()
{
    translate([0,0,height])
    rotate([180,0,0])
    {
        vertex();
    
//        %Pipes();
        
        %V2060();
//        %V_Slot_20x60(TotHt+100);
    }
}
if (Assembly == 1)
{
    translate([0,0,-18])
    %LimitHolder();
    
    #translate([0,0,0])
    %Idler_Cap();
    
    translate([23,-32,-10.5-4])
    rotate([0,0,120])
    rotate([90,0,0])
    %LimitSwitch();
    rotate([0,0,180])
    {
        translate([0,10+1.5,-31-2])
        rotate([-90,0,0])
        %Carriage();         //Measures 1.5mm clearance from Vertical 2060
        translate([0,-11.5,-31-2])
        rotate([90,0,0])
        %CarriageBack();
    }
    translate([0,-28,12.5])
    
    rotate([-90,0,0])
    %TimingBelt();
    translate([0,0,40])
    rotate([0,180,0])
    DrawFinal();
} else {
    if (EarsOn == 0)
    {
        DrawFinal();
    } else if (EarsOn == 1)
    {
        DrawFinal();
        rotate([0,0,180])
        Ears();
    }
}
translate([0,0,TotHt])
rotate([0,180,0])
{
    translate([0,0,-18])
    %LimitHolder();
    
    #translate([0,0,0])
    %Idler_Cap();
    
    translate([23,-32,-10.5-4])
    rotate([0,0,120])
    rotate([90,0,0])
    %LimitSwitch();
    rotate([0,0,180])
    {
        translate([0,10+1.5,-31-2])
        rotate([-90,0,0])
        %Carriage();         //Measures 1.5mm clearance from Vertical 2060
        translate([0,-11.5,-31-2])
        rotate([90,0,0])
        %CarriageBack();
    }
    translate([0,-28,12.5])
    
    rotate([-90,0,0])
    %TimingBelt();
}