// Emmett-Delta 3D Printer 
// Base on Delta-Six Vertex Created by Sage Merrill
// Released on Openbuilds.com
// which was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

//Modified by David Bunch to handle 3/4" Electrical Conduit Pipe for Horizontals

$vpt=[0,0,0];
$vpr =[36.8,0,114.6];
$vpd =550;

//3/4" EMT is usually 23.4mm
//1/2" EMT is usually 17.9mm
height = 59.75+7;
ExtendHt = 17.25;          //Extend height above main part
EMT_OD=23.7;
EMT_Rad = EMT_OD / 2;
Ht_Half = height / 2;
EMT_OD = 23.7;
EMT12_OD = 18.4;
EMT12_Rad = EMT12_OD / 2;
EMT_Rad = EMT_OD / 2;

//motor_offset = 48.7+1.5;
Mot_Mov=12;                 //How many mm's of movement for tensioning Belts to use
MotExtHt = 0;           //Minimum of 8 when using hardcoded 6mm rounding
Rnd_Z = MotExtHt - 6 + height;
echo("Rnd_Z = ",Rnd_Z);
//triangle_side = 316;
//printer_height = 680;
//delta_radius = 212.4;
Ht = 8;
M5 = 5.5;
//M8 = 8.5;
M3 = 3.4;
WireDia = 7;        //use minimum of 6mm for 4 conductor wire to go thru
Wire_Z_Height = -2;
PipeScrewDia = 4.5;   //Dia. of holes for Screws that mount EMT Pipe to Vertex
                       //Use 5.15 to 5.5 for M5, or 4.15 to 4.5 for M4

Pipe_Qty = 2;
Pipe_Spacing = 30+6+2+2;     //gives 6mm clearance top & bottom of 86mm high vertex
                       //We Need 45mm to put Pipe Tensioning mount in vertically
ScrewSockSpace = 45;   //Spacing between t-Slot screw holes in corner
ScrewSockQty = 2;      //Number of t-slot screws on each side

MicroSwitchHole_Zoffset = 12;       //Z Offset for Micro Switch Holes
BaseThk = 12;
$fn=24;

Pipe_Z=EMT_OD /2 +4-1;
UpHt = 6;
TotHt = height + ExtendHt + 6;
echo("TotHt = ", TotHt);
echo("Pipe_Spacing = ",Pipe_Spacing);
echo("Pipe_Z = ",Pipe_Z);
echo("height = ",height);
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
    cube([30.8,30.8,TotHt+2]);
}
module EMT12_1xPipe(E_Ht = TotHt+2)
{
    cylinder(d=EMT12_OD,h=E_Ht,$fn=EMT12OD_Res);
}
module EMT12_Pipes()
{
    translate([0,0, BaseThk])
//    rotate([180,0,0])
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
module VertexBot_Outline()
{
	linear_extrude(height = height, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "OutLineBot");
}
module VertexBot_Outline_Wide()
{
	linear_extrude(height = EMT_Rad, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "OutLineBot_Wide");
}
module OutLineUpperBot(UB_Ht = TotHt)
{
	linear_extrude(height = UB_Ht, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "OutLineUpperBot");
}
module OutLineMidUpperBot()
{
	linear_extrude(height = .1, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "OutLineMidUpperBot");
}
module CornerLeft()
{
    linear_extrude(height = 1, center = false, convexity = 10)polygon(points = 
    [[-24.4,-4.3],[-24.4,15.4],[-26.41,17.4],[-32.29,17.4],[-36.29,16.33],
    [-45.94,10.76],[-45.94,7.52],[-27.58,-5.92]]);
}

module BridgeExtend()
{
    linear_extrude(height = 1, center = false, convexity = 10)polygon(points = 
    [[-33.85,-1.33],[-27.58,-5.92],[-24.4,-4.3],[-24.4,15.4],[-26.41,17.4],
    [-32.29,17.4],[-36.29,16.33]]);
}
module BridgeCorner()
{
    hull()
    {
        translate([-24.5,-8.24,height-11.8])
        cube([.1,27.75,1]);
        translate([0,0,height-1])
        BridgeExtend();
    }
}
module VertexBot_UpperFrameCut()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "BotUpperFrameCut");
}
module CornerCuts()
{
	linear_extrude(height = height+2, center = false, convexity = 10)
	import("EMTH_EMTV_VertexBot.dxf", layer = "CornerCuts");
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
        cube([38.8,10,TotHt+4]);
        //%EMT12_Pipes();
    }
}
module Ears()
{
    hull()
    {
        translate([62.7,62.8,0])
        cylinder(d=20,h=EarHt);
        translate([72.4,62.8,0])
        cylinder(d=20,h=EarHt);
    }
    hull()
    {
        translate([-62.7,62.8,0])
        cylinder(d=20,h=EarHt);
        translate([-72.4,62.8,0])
        cylinder(d=20,h=EarHt);
    }
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
module EMT_Nut()
{
    translate([1,-23.4,11])
    difference()
    {
//If Nut lock is not flush with outside pipe, try adjusting Pipe_Rad-1.3
        rotate([90,0,0])
        rotate([0,90,0])
        rotate([0,0,180])
        difference()
        {
            linear_extrude(height = 5, center = false, convexity = 10)polygon(points = 
            [[8.23,-1.74],[8.23,1.74],[8.19,2.13],[8.08,2.51],[7.89,2.86],
            [7.64,3.16],[0,10.8],[-0.86,10.8],[-0.86,-10.8],[0,-10.8],
            [7.64,-3.16],[7.89,-2.86],[8.08,-2.51],[8.19,-2.13]]);
            translate([4.1,0,-1])
            cylinder(d=M3,h=8,$fn=24);
        }
    }
}
module EMT_NutsSide()
{
    translate([0,0,BaseThk])
    EMT_Nut();
    translate([-7,0,BaseThk])
    EMT_Nut();
}
module vertex()
{
    difference()
    {
	union()
    {
		difference()
        {
            union()
            {
                translate([0,0,0])
                VertexBot_Outline();
                translate([0,0,0])        //EMT_Rad

                VertexBot_Outline_Wide();
                OutLineUpperBot(TotHt);
                EMT_NutsSide();
                translate([0,0,height -10.55])
                EMT_NutsSide();
//                translate([0,0,TotHt/2- 17])
//                EMT_NutsSide();               //if you want 3 NutLocks
                if(MotExtHt > 0)
                {
                    translate([0,8.4,0])
                    ExtbothSidesMotorMnt();     //Add a little plastic to allow more motor adjust
                }
            }
            if(MotExtHt == 0)
            {
                translate([-27.65,57+8.4,Rnd_Z])
                RndCorner();
                translate([27.65,57+8.4,Rnd_Z])
                mirror([1,0,0])
                RndCorner();
            }
            translate([0,8.4,0])
            Pipes();

            translate([0,8.4,0])
            PipeScrewsBothSides();
            translate([0,0,-1]);
            VertexBot_UpperFrameCut();
// Angled Wire Runs on each side of Motor 
            translate([0,8.4,0])
            WireRuns();
            WireTopEMT12();

            translate([0,0,-1])
            CornerCuts();
//            WireBot2060();
////Vertical Extrusion Opening
//            translate([0,0,BaseThk])
//            Cut2060();
            if (BaseThk > 0)
            {
                translate([0,0,-1])
                VertexTop_EMT12_HalfCut();
            }
            //CornerScrewSockets();
        
            translate([0,8.4,29])
            MotorMntAdjustHoles();                  //Adjustment Slot holes for Motor Mount Plate
            //SideCuts();
            translate([0,8.4,11])
            CutBotMotMnt();

//            %ChamfEMT_Corner();
//            mirror([1,0,0])
//            ChamfEMT_Corner();
//Cut 2mm slot for Pipe Tighten

		}
        translate([0,0,height])
        hull()
        {
            OutLineMidUpperBot();
            translate([0,0,5.9])
            OutLineUpperBot(.1);
        }
        BridgeCorner();
	}
            translate([-1,-30,BaseThk])
            cube([2,18,TotHt]);
                translate([0,0,BaseThk])
            VertexTop_EMT12_FullCut();
}
}
module WireTopEMT12()
{
    translate([-9.2,20.9,0])
    BotWireCut();
    translate([9.2,20.9,0])
    BotWireCut();
}
//We use 7mm for Diameter of Wire cut
module BotWireCut()
{
    rotate([90,0,0])
    translate([0,0,-5.5])
    linear_extrude(height = 11, center = false, convexity = 10)polygon(points = 
    [[-3.5,3.5],[-3.5,1.5],[-5,0],[-5,-1],[5,-1],
    [5,0],[3.5,1.5],[3.5,3.5],[3.43,4.18],[3.23,4.84],
    [2.91,5.44],[2.47,5.97],[1.94,6.41],[1.34,6.73],[0.68,6.93],
    [0,7],[-0.68,6.93],[-1.34,6.73],[-1.94,6.41],[-2.47,5.97],
    [-2.91,5.44],[-3.23,4.84],[-3.43,4.18]]);
}
module ChamfEMT_Corner()
{
    translate([0,8.4,-1])
    linear_extrude(height = 10, center = false, convexity = 10)polygon(points = 
    [[-79.13,67],[-75.13,67],[-74.63,65.5],[-75.13,65],[-75.64,64.93],
    [-76.13,64.73],[-76.54,64.41],[-76.86,64],[-77.06,63.52],[-77.13,63],
    [-77.06,62.48],[-76.86,62],[-76.86,61.75],[-79.13,62]]);
}
module MotorCut()
{
    translate([0,48+10,-1])
    rotate([90,0,0])
    color("red")
    linear_extrude(height = 10, center = false, convexity = 10)polygon(points = 
    [[29.65,68.11],[26.2,66.47],[25.65,66.18],[25.06,65.8],[24.5,65.38],
    [23.99,64.91],[23.52,64.39],[23.09,63.84],[22.72,63.25],[22.4,62.63],
    [22.13,61.99],[21.92,61.32],[21.77,60.64],[21.68,59.95],[21.65,59.25],
    [21.65,17.88],[21.54,17.1],[21.24,16.38],[20.77,15.76],[18.1,13.09],
    [16.39,12.38],[-16.4,12.38],[-18.1,13.09],[-20.78,15.76],[-21.25,16.38],
    [-21.55,17.1],[-21.65,17.88],[-21.65,59.25],[-21.69,59.95],[-21.78,60.64],
    [-21.93,61.32],[-22.14,61.99],[-22.4,62.63],[-22.73,63.25],[-23.1,63.84],
    [-23.53,64.39],[-24,64.91],[-24.51,65.38],[-25.07,65.8],[-25.65,66.18],
    [-26.21,66.47],[-29.65,68.11]]);
}
module MotorMntAdjustHoles()
{
    translate([26.4+5,0,13.4])
    MotorMntAdjustSlot();
    translate([26.4+5,0,-13.4])
    MotorMntAdjustSlot();
    translate([-26.4-5,0,13.4])
    MotorMntAdjustSlot();
    translate([-26.4-5,0,-13.4])
    MotorMntAdjustSlot();
}
module MotorMntAdjustSlot()
{
    translate([0,58,0])
    rotate([90,0,0])
    union()
    {
        translate([0,0,0])
        cylinder(d=5.5,h=10,$fn=24);
        translate([-2.75,0,0])
        cube([5.5,Mot_Mov,10]);
        translate([0,Mot_Mov,0])
        cylinder(d=5.5,h=10,$fn=24);
    }
}
module MotorCaps()
{
    linear_extrude(height = 7.5, center = false, convexity = 10)polygon(points = 
    [[-21.65,50.75],[-21.85,54.29],[-21.93,54.86],[-22.05,55.69],[-22.24,56.37],
    [-22.49,57.04],[-22.79,57.68],[-23.14,58.29],[-23.55,58.87],[-24.01,59.41],
    [-24.51,59.91],[-25.05,60.37],[-25.49,60.74],[-26.24,61.14],[-26.88,61.44],
    [-27.54,61.69],[-28.22,61.88],[-28.92,62.01],[-29.62,62.08],[-30.33,62.1],
    [-31.04,62.05],[-31.74,61.94],[-32.42,61.77],[-33.09,61.54],[-33.74,61.26],
    [-34.37,60.92],[-37.99,58.75]]);

    linear_extrude(height = 7.5, center = false, convexity = 10)polygon(points = 
    [[21.65,50.75],[21.85,54.29],[21.93,54.86],[22.05,55.69],[22.24,56.37],
    [22.49,57.04],[22.79,57.68],[23.14,58.29],[23.55,58.87],[24.01,59.41],
    [24.51,59.91],[25.05,60.37],[25.49,60.74],[26.24,61.14],[26.88,61.44],
    [27.54,61.69],[28.22,61.88],[28.92,62.01],[29.62,62.08],[30.33,62.1],
    [31.04,62.05],[31.74,61.94],[32.42,61.77],[33.09,61.54],[33.74,61.26],
    [34.37,60.92],[37.99,58.75]]);
}
module WireBot2060()
{
    translate([10,0,Wire_Z_Height])
    rotate([-90,0,0])
    BotWireRoute();
    
    translate([-10,0,Wire_Z_Height])
    rotate([-90,0,0])
    BotWireRoute();  
}
module BotWireRoute()
{
    translate([0,Wire_Z_Height-5,-1])
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
    translate([-(WireDia/2),-WireDia,-1])
    cube([WireDia,WireDia,24]);
}
module Cut2060()
{
    linear_extrude(height = height + 20+ ExtendHt, center = false, convexity = 10)polygon(points = 
    [[15.5,-10.13],[17.3,-8.33],[22.7,-8.33],[24.5,-10.13],[30.4,-10.13],
    [30.4,10.18],[-30.4,10.18],[-30.4,-10.13],[-24.5,-10.13],[-22.7,-8.33],
    [-17.3,-8.33],[-15.5,-10.13],[-4.5,-10.13],[-2.7,-8.33],[2.7,-8.33],
    [4.5,-10.13]]);
}
module Cut2060Half()
{
    difference()
    {
        Cut2060();
        translate([-50,0,-1])
        cube([100,100,500]);
    }
}
module V_Slot_20x60(Ht_A=TotHt)
{
    translate([-20,0,0])
//This was traced from the V-Slot 20x60 & taking out the small details
    color("silver")
    rotate([0,0,-90])
    difference()
    {
        linear_extrude(height = Ht_A, center = false, convexity = 10)polygon(points = 
        [[-2.84,-8.2],[-5.5,-8.2],[-5.5,-6.56],[-2.84,-3.9],[2.84,-3.9],
        [5.5,-6.56],[5.5,-8.2],[2.84,-8.2],[4.64,-10],[8.5,-10],
        [10,-8.5],[10,-4.64],[8.2,-2.84],[8.2,-5.5],[6.56,-5.5],
        [3.9,-2.84],[3.9,2.84],[6.56,5.5],[8.2,5.5],[8.2,2.84],
        [10,4.64],[10,15.36],[8.2,17.16],[8.2,14.5],[6.56,14.5],
        [3.9,17.16],[3.9,22.84],[6.56,25.5],[8.2,25.5],[8.2,22.84],
        [10,24.64],[10,35.36],[8.2,37.16],[8.2,34.5],[6.56,34.5],
        [3.9,37.16],[3.9,42.84],[6.56,45.5],[8.2,45.5],[8.2,42.84],
        [10,44.64],[10,48.5],[8.5,50],[4.64,50],[2.84,48.2],
        [5.5,48.2],[5.5,46.56],[2.84,43.9],[-2.84,43.9],[-5.5,46.56],
        [-5.5,48.2],[-2.84,48.2],[-4.64,50],[-8.5,50],[-10,48.5],
        [-10,44.64],[-8.2,42.84],[-8.2,45.5],[-6.56,45.5],[-3.9,42.84],
        [-3.9,37.16],[-6.56,34.5],[-8.2,34.5],[-8.2,37.16],[-10,35.36],
        [-10,24.64],[-8.2,22.84],[-8.2,25.5],[-6.56,25.5],[-3.9,22.84],
        [-3.9,17.16],[-6.56,14.5],[-8.2,14.5],[-8.2,17.16],[-10,15.36],
        [-10,4.64],[-8.2,2.84],[-8.2,5.5],[-6.56,5.5],[-3.9,2.84],
        [-3.9,-2.84],[-6.56,-5.5],[-8.2,-5.5],[-8.2,-2.84],[-10,-4.64],
        [-10,-8.5],[-8.5,-10],[-4.64,-10]]);
//Cut opening between 20x20's
        translate([0,0,-1])
        linear_extrude(height = Ht_A+2, center = false, convexity = 10)polygon(points = 
        [[-8.2,7.3],[-6.24,7.3],[-2.84,3.9],[2.84,3.9],[6.24,7.3],
        [8.2,7.3],[8.2,12.7],[6.24,12.7],[2.84,16.1],[-2.84,16.1],
        [-6.24,12.7],[-8.2,12.7]]);
//Cut 2nd opening
        translate([0,0,-1])
        linear_extrude(height = Ht_A+2, center = false, convexity = 10)polygon(points = 
        [[-8.2,27.3],[-6.24,27.3],[-2.84,23.9],[2.84,23.9],[6.24,27.3],
        [8.2,27.3],[8.2,32.7],[6.24,32.7],[2.84,36.1],[-2.84,36.1],
        [-6.24,32.7],[-8.2,32.7]]);
        translate([0,0,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);      //Drill M5 holes
        translate([0,20,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);
        translate([0,40,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);
    }
}
module WireRuns()
{
    color("red")
    translate([0,0,2.8+6])      //5mm puts hole just touching bottom
    {
        translate([-42,58,0])
        rotate([90,0,0])
        cylinder(d=5.5,h=14);
        translate([42,58,0])
        rotate([90,0,0])
        cylinder(d=5.5,h=14);
    }
}
module Pipe1x()
{
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
        }
    }
}
module PipeScrewsBothSides()
{
    PipeScrews();
    mirror([1,0,0])
    PipeScrews();

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
            translate([0,0,Pipe_Spacing/2])
            PipeScrews1x();                 //Holes half between Pipes
        } else {
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
module OutHole()
{
    if (Mot_Mov > 0)
    {
        union()
        {
            translate([0,-Mot_Mov,-1])
            cylinder(d=M3,h=Ht+4);         //M3 Hole
            translate([0,Mot_Mov,-1])
            cylinder(d=M3,h=Ht+4);         //M3 Hole
            translate([-(M3/2),-Mot_Mov,-1])
            cube([M3,Mot_Mov*2,Ht+4]);             //Connect the 2 M3 Holes
        }
    } else {
        translate([0,0,-1])
        cylinder(d=M3,h=Ht+4);         //M3 Hole
    }
}
module MotorMountAccess()
{
    color("red")
    translate([0,-20,0])
    rotate([-90,0,0])
    {
        translate([-15.5,-11.5,0])
        OutScrewDriverHole();                      //Cut out the Bottom left slot for M3
        translate([15.5,-11.5,0])
        OutScrewDriverHole();                      //Cut out the Bottom right slot for M3
        translate([-15.5,11.5,0])
        OutScrewDriverHole();                      //Cut out the Top left slot for M3
        translate([15.5,11.5,0])
        OutScrewDriverHole();                      //Cut out the Top Right slot for M3
    }
}
module OutScrewDriverHole()
{
    translate([0,0,-1])
    cylinder(d=M3,h=40);         //Screwdriver Access Hole
}
module MotorMount()
{
    translate([0,48.2+6,0])
    rotate([-90,0,0])
    hull()
    {
        translate([0,Mot_Mov,0])
        cylinder(d1=22.3,d2=25.1,h=2.8,$fn=76);
        translate([0,-Mot_Mov,0])
        cylinder(d1=22.3,d2=25.1,h=2.8,$fn=76);
    }
    translate([0,42+6,0])
    rotate([-90,0,0])
    hull()
    {
        translate([0,Mot_Mov,0])
        cylinder(d=16,h=10,$fn=52);
        translate([0,-Mot_Mov,0])
        cylinder(d=16,h=10,$fn=52);
    }
}
module Motor_Plate()
{
    color("cyan")
    import("MotorMount_rev4_repaired.stl", convexity=3);
    Nema17();
}
module Nema17()
{
    rotate([90,0,0])
    translate([0,23.75,0])
    color("silver")

    import("nema17.stl", convexity=3);
}
module CornerScrewSockets()
{
    translate([0,0,Ht_Half])
    {
        for (z =[0:ScrewSockQty-1])
        {
            for (x = [-1,1])
            {
                translate([20*x,-16,z*ScrewSockSpace])
                rotate([90, 0, 180])
                cylinder(d=M5,h=40);
            }
        }
    }
}
module VertSideCutLeft()
{
    translate([0,0,-1])
    linear_extrude(height = 40.75, center = false, convexity = 10)polygon(points = 
    [[-36.4,-7.23],[-38.4,-9.23],[-43.02,-9.23],[-46.02,-7.5],[-49.26,-1.87],
    [-48.53,0.86],[-38.13,6.87],[-36.4,5.87]]);
}
module VertSideCutRight()
{
    translate([0,0,-1])
    linear_extrude(height = 40.75, center = false, convexity = 10)polygon(points = 
    [[36.4,-7.23],[38.4,-9.23],[43.02,-9.23],[46.02,-7.5],[49.26,-1.87],
    [48.53,0.86],[38.13,6.87],[36.4,5.87]]);
}
module VertSideTopLeft()
{
    linear_extrude(height = 1, center = false, convexity = 10)polygon(points = 
    [[-43.59,-8.9],[-45.21,2.78],[-48.53,0.86],[-49.26,-1.87],[-46.02,-7.5]]);
}
module VertSideTopRight()
{
    linear_extrude(height = 1, center = false, convexity = 10)polygon(points = 
    [[43.59,-8.9],[45.21,2.78],[48.53,0.86],[49.26,-1.87],[46.02,-7.5]]);
}
module SideCuts()
{
    hull()
    {
        VertSideCutLeft();
        translate([0,0,height])
        VertSideTopLeft();
    }
    hull()
    {
        VertSideCutRight();
        translate([0,0,height])
        VertSideTopRight();
    }
}
module ExtMotorMnt()
{
    difference()
    {
        union()
        {
            linear_extrude(height = MotExtHt, center = false, convexity = 10)polygon(points = 
            [[43.49,54.4],[42.22,55.06],[41.41,55.4],[40.58,55.66],[39.73,55.85],
            [38.86,55.96],[37.99,56],[21.65,56],[21.65,48.5],[37.57,48.5],
            [38.1,48.47],[38.61,48.39],[39.12,48.26],[39.61,48.07],[40.07,47.83],
            [43.49,54.4],[40.07,47.83]]);
            translate([40.0732,47.8301,0])
            rotate([0,0,-27.5])
            rotate([-90,0,0])
            cylinder(d=4,h=7.4059,$fn=4);
        }
        translate([-27.65,57,Rnd_Z-height])
        RndCorner();
        translate([27.65,57,Rnd_Z-height])
        mirror([1,0,0])
        RndCorner();
        translate([38.67,58.14,Rnd_Z-height])
        rotate([0,0,-27.5])
        RndCorner();
        translate([-38.67,58.14,Rnd_Z-height])
        mirror([1,0,0])
        rotate([0,0,-27.5])
        RndCorner();
    }
}
module ExtbothSidesMotorMnt()
{
    translate([0,0,height])
    ExtMotorMnt();
    mirror([1,0,0])
    translate([0,0,height])
    ExtMotorMnt();
}
module RndCorner()
{
    rotate([90,0,0])
    difference()
    {
        cylinder(d=18,h=12,$fn=24);
        translate([0,0,-1])
        cylinder(d=12,h=14,$fn=48);
        translate([-10,-20,-1])
        cube([20,20,12]);
        translate([-20,-10,-1])
        cube([20,20,14]);
    }
}

module CutBotMotMnt()
{
    translate([0,47.5,])
    rotate([-90,0,0])
    union()
    {
        hull()
        {
            translate([-18.65,0,0])
            cylinder(d=6,h=10,$fn=24);
            translate([18.65,0,0])
            cylinder(d=6,h=10,$fn=24);
        }
        translate([-21.65,-height,0])
        cube([43.3,height,10]);
    }
}
translate([0,8.4,1])
translate([0,0,height / 2])
translate([0,50-7.5,7])
rotate([-90,0,0])
%Motor_Plate();
translate([0,8.4,0])
%Pipes(); 
if (EarsOn == 0)
{
    vertex();;
} else if (EarsOn == 1)
{
    vertex();;
    translate([0,8.4,0])
    Ears();
}